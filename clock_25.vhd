library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity clock_25 is
	port (Clock_in : in std_logic;
			Reset : in std_logic;
			Clock_out : out std_logic);
end entity;

architecture clock_25_arch of clock_25 is

signal Clock_CNT : std_logic;

begin

CLK1 : process(Clock_in, Reset)
	begin
		if(Reset = '0') then
			Clock_CNT <= '0';
		elsif(rising_edge(Clock_in)) then
					Clock_CNT <= not Clock_CNT;
		end if;
	end process;

Clock_out <= Clock_CNT;


end architecture;