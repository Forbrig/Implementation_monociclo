library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity ULA is
	port(
		op: in std_logic_vector( 2 downto 0 );
		In1, In2: in std_logic_vector( 31 downto 0 );
		flag_Z: out std_logic;
		resp: out std_logic_vector( 31 downto 0 )
	);
end entity;

architecture arch_ULA of ULA is
	signal r: std_logic_vector (31 downto 0);
begin

	process(op, In1, In2)

	begin
		if( op = "000" )then
			r <= In1 and In2;
		elsif( op = "001" )then
			r <= In1 or In2;
		elsif( op = "010" )then
			r <= In1 + In2;
		elsif( op = "110" )then
			r <= In1 - In2;
		elsif( op = "111" )then
			if( In1 < In2 )then
				r <= "00000000000000000000000000000001";
			else 
				r <= "00000000000000000000000000000000";
			end if;
		end if;
		
		if(r = "00000000000000000000000000000000")then
			flag_Z <= '1';
		else
			flag_Z <= '0';
		end if;
	end process;	
	resp <= r;
end architecture; 
