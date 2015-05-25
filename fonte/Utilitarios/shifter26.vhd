library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std;
use ieee.std_logic_unsigned.all;

entity shifter26 is
	port(
		In1: in std_logic_vector(25 downto 0);
		saida: out std_logic_vector(27 downto 0)
	);
end entity;	
	
	
architecture arch_shifter26 of shifter26 is
signal a: std_logic_vector(27 downto 0);
begin
	process(In1)
	begin
		a <= In1 & "00";
	end process;
	saida <= a;
end architecture;
