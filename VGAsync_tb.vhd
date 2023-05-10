library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity VGAsync_tb is
end entity;

architecture VGAsync_tb_arch of VGAsync_tb is

component VGAsync is
   port(Clock_in	: in std_logic;
	Reset		: in std_logic;
	H_va		: out std_logic;
	V_va		: out	std_logic;
	Vsync		: out std_logic;
	Hsync		: out std_logic);
end component;

signal Clock_tb		: std_logic;
signal Reset_tb		: std_logic;
signal H_va_tb		: std_logic;
signal V_va_tb		: std_logic;
signal Vsync_tb		: std_logic;
signal Hsync_tb		: std_logic;

begin

DUT : VGAsync port map (Clock_in => Clock_tb, Reset => Reset_tb, H_va => H_va_tb, V_va => V_va_tb, Vsync => Vsync_tb, Hsync => Hsync_tb);

RESET_PROC : process
	begin
	    	Reset_TB <= '0'; wait for 15 ns;
		Reset_TB <= '1'; wait;
	end process;

CLOCK_PROC : process
	begin
	    Clock_TB <= '0'; wait for 20 ns;
	    Clock_TB <= '1'; wait for 20 ns;
	end process;

end architecture;

