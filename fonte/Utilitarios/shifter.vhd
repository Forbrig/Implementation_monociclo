library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std;
use ieee.std_logic_unsigned.all;

entity shifter is
	port(
		In1: in std_logic_vector(31 downto 0);
		saida: out std_logic_vector(31 downto 0)
	);
end entity;	
	
	
architecture arch_shifter of shifter is
signal a: std_logic_vector(31 downto 0);
begin
	process(In1)
	begin
		a(31 downto 2) <= In1(31 downto 2);
		a(1 downto 0) <= "00";
	end process;
	saida <= a;
end architecture;
