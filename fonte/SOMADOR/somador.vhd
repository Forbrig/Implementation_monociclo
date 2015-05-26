library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity somador is
	port(
		In1: in std_logic_vector(31 downto 0);
		In2: in std_logic_vector(31 downto 0);
		saida: out std_logic_vector(31 downto 0)
	);
end entity;	
	
	
architecture arch_somador of somador is
begin
	saida <= In1 + In2;
end architecture;
