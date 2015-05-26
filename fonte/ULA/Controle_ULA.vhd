library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity ControleULA is
	port(
		OpCode: in std_logic_vector( 1 downto 0 );
		funct: in std_logic_vector( 5 downto 0 );
		opULA: out std_logic_vector( 2 downto 0 );
		jr: out std_logic
	);
end entity;

architecture arch_ControleULA of ControleULA is

begin
	process(OpCode, funct)

	begin
		jr <= '0';
		if(OpCode = "00")then
			opULA <= "010";	-- LW, SW, ADDi
			
		elsif(OpCode = "01")then
			opULA <= "110";--sub para fazer beq e bne
		
		elsif (OpCode = "10")then
			opULA <= "111";--slti

		else
			if(funct(3 downto 0) = "0000")then
				opULA <= "010";
				
			elsif(funct(3 downto 0) = "0010")then
				opULA <= "110";
			
			elsif(funct(3 downto 0) = "0100")then
				opULA <= "000";
			
			elsif(funct(3 downto 0) = "0101")then
				opULA <= "001";
			
			elsif(funct(3 downto 0) = "1010")then
				opULA <= "111";

			elsif(funct(3 downto 0) = "1000")then
				jr <= '1';			
			end if;
		end if;
		
	end process;
end architecture;
