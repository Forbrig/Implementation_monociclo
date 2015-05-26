library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity PC is
	port(
		clk: in std_logic;
		In1: in std_logic_vector(31 downto 0);
		Reset: in std_logic;
		saida: out std_logic_vector(31 downto 0)
	);
end entity;	
	
	
architecture arch_PC of PC is
signal valor: std_logic_vector(31 downto 0);
begin
	process(clk, reset)
	begin
		if(reset = '1')then
			valor <= "00000000000000000000000000000000";
		elsif( clk'event and clk = '1' ) then
			valor <= In1;
		end if;
	end process;
	saida <= valor;
end architecture;
