library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity DataMemory is
	port(
		MemRead: in std_logic;
		MemWrite: in std_logic;
		where: in std_logic_vector(31 downto 0);
		Data: in std_logic_vector(31 downto 0);
		saida1: out std_logic_vector(31 downto 0)
	);
end entity;

architecture arch_DataMemory of DataMemory is
	type memoria is array( 255 downto 0 ) of std_logic_vector( 7 downto 0 );
	signal memory: memoria;   

	begin
		process(MemRead)
		begin
    
			if(MemRead = '1')then
			   saida1(7 downto 0)   <= memory(conv_integer(where));
			   saida1(15 downto 8)  <= memory(conv_integer(where) + 1);
			   saida1(23 downto 16) <= memory(conv_integer(where) + 2);
			   saida1(31 downto 24) <= memory(conv_integer(where) + 3);
			end if;
			
		end process;

		process(MemWrite)
		begin
			if(MemWrite = '1')then
			   memory(conv_integer(where))     <= Data(7 downto 0);
			   memory(conv_integer(where) + 1) <= Data(15 downto 8);
			   memory(conv_integer(where) + 2) <= Data(23 downto 16);
			   memory(conv_integer(where) + 3) <= Data(31 downto 24);
			end if;
			
		end process;	
end architecture;
