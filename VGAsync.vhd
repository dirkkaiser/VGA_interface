library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity VGAsync is
	port(	Clock_in	: in std_logic;
			Reset		: in std_logic;
			H_va		: out std_logic;
			V_va		: out	std_logic;
			Vsync		: out std_logic;
			Hsync		: out std_logic);
end entity;

architecture VGAsync_arch of VGAsync is

signal HCNT : integer;
signal VCNT : integer;

begin

process (Clock_in, Reset)
	begin
		if(Reset = '0') then
			HCNT <= 0;
			VCNT <= 0;
		elsif(rising_edge(Clock_in)) then
			if (HCNT >= 799) then
				HCNT <= 0;
				VCNT <= VCNT + 1;
			else
				HCNT <= HCNT + 1;
			end if;
			if (VCNT >= 524) then
				VCNT <=0;
			end if;
			if(HCNT < 640) then
				H_va <= '1';
			else
				H_va <= '0';
			end if;
			if(HCNT <= 751 and HCNT >= 656) then
				Hsync <= '0';
			else
				Hsync <= '1';
			end if;
			if(VCNT < 480) then
				V_va <= '1';
			else
				V_va <= '0';
			end if;
			if(VCNT <= 491 and VCNT >= 490) then
				Vsync <= '0';
			else
				Vsync <= '1';
			end if;
		end if;
	end process;

end architecture;
			
