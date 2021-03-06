library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity MUX2x15bits is
	port(
		controle: in std_logic;
		In1: in std_logic_vector(4 downto 0);
		In2: in std_logic_vector(4 downto 0);
		saida: out std_logic_vector(4 downto 0)
	);
end entity;	
	
	
architecture arch_MUX2x15bits of MUX2x15bits is
begin
	process(controle, In1, In2)
	begin
		if(controle = '0')then
			saida <= In1;
		
		elsif(controle = '1')then
			saida <= In2;	
		
		end if;
	end process;
end architecture;
