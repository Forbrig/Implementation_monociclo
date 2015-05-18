library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity extender is
	port(
		In1: in std_logic_vector(15 downto 0);
		saida: out std_logic_vector(31 downto 0)
	);
end entity;	
	
	
architecture arch_extender of extender is
begin
	process(In1)
	begin
		saida <= "0000000000000000" & In1; 
		
	end process;
end architecture;
