library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity top is
	port (Clock_50	: in std_logic;
			Reset		: in std_logic;
			SW			: in std_logic_vector (9 downto 0);
			KEY		: in std_logic_vector (1 downto 0);
			LEDR		: out std_logic_vector (9 downto 0);
			GPIO		: out std_logic_vector (28 downto 0);
---------------------------------VGA-----------------------------------
			VGA_R		: out std_logic_vector(3 downto 0);
			VGA_G		: out std_logic_vector(3 downto 0);
			VGA_B		: out std_logic_vector(3 downto 0);
			Hsync		: out std_logic;
			Vsync		: out std_logic);

end entity;

architecture top_arch of top is

------------------------------------------------------------------------

component  clock_25 is
	port(	Clock_In	: in	std_logic;
			Reset		: in	std_logic;
			Clock_Out: out	std_logic);
end component;

component VGAsync is
	port(	Clock_in	: in std_logic;
			Reset		: in std_logic;
			H_va		: out std_logic;
			V_va		: out	std_logic;
			Vsync		: out std_logic;
			Hsync		: out std_logic);
end component;

--------------------------------------------------------------------------

signal Clock_Div		: std_logic;
signal H_va				: std_logic;
signal V_va				: std_logic;
signal ACNT_int		: integer;
signal Hsync_internal: std_logic;
signal Vsync_internal: std_logic;

--------------------------------------------------------------------------

begin

CLK_25 : clock_25 port map (Clock_In => Clock_50, Reset => Reset, Clock_Out => Clock_Div);
SYNC1 : VGAsync port map (Clock_in => Clock_Div, Reset => Reset, H_va => H_va, V_va => V_va, Hsync => Hsync_internal, Vsync => Vsync_internal);
LEDR(0) <= Clock_Div; 
GPIO(0) <= Clock_Div;
GPIO(1) <= Hsync_internal;
GPIO(2) <= Vsync_internal;
Hsync <= Hsync_internal;
Vsync <= Vsync_internal;

---------------------------------Color Test----------------------------------

TESTPATTERN: process(V_va,H_va,Clock_Div,Reset) 
begin
	if(Reset = '0') then
		VGA_R <= "0000";
		VGA_G <= "0000";
		VGA_B <= "0000";
		ACNT_int <= 0;
	elsif (rising_edge(Clock_DiV)) then
		if (V_va = '1' and H_va = '1') then
			if (ACNT_int > 307200) then
				ACNT_int <= 0;
			else
				ACNT_int <= ACNT_int + 1;
			end if;
			if (ACNT_int < 102400) then
				VGA_R <= "1111";
				VGA_G <= "0000";
				VGA_B <= "0000";
			elsif(ACNT_int >= 102400 and ACNT_int < 204800) then
				VGA_R <= "0000";
				VGA_G <= "1111";
				VGA_B <= "0000";
			elsif(ACNT_int >= 204800 and ACNT_int <= 307200) then
				VGA_R <= "0000";
				VGA_G <= "0000";
				VGA_B <= "1111";
			end if;
		end if;
	end if;
end process;

-----------------------------------------------------------------------------
end architecture;