library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity InstructionMemory is
    port(	
		Address: in std_logic_vector(31 downto 0);
		N_Address: in std_logic_vector(31 downto 0);
		N_Instruction: in std_logic_vector(31 downto 0);
		saida: out std_logic_vector(31 downto 0)
    );
end entity;

architecture arch_InstructionMemory of InstructionMemory is
	type mem is array(255 downto 0) of std_logic_vector(7 downto 0);
	signal Instrucao: mem;   
	
	begin
		process(Address)
		begin
			saida(7 downto 0) <= Instrucao(conv_integer(Address));		--	
			saida(15 downto 8) <= Instrucao(conv_integer(Address) + 1);	--	Carrega byte a byte
			saida(23 downto 16) <= Instrucao(conv_integer(Address) + 2);	--
			saida(31 downto 24) <= Instrucao(conv_integer(Address) + 3);	--
		end process;

		process(N_Address)	-- Se for escrever novas instrucoes
		begin
			Instrucao(conv_integer(N_Address))     <= N_Instruction(7 downto 0);
			Instrucao(conv_integer(N_Address) + 1) <= N_Instruction(15 downto 8);
			Instrucao(conv_integer(N_Address) + 2) <= N_Instruction(23 downto 16);
			Instrucao(conv_integer(N_Address) + 3) <= N_Instruction(31 downto 24);
		end process;	
end architecture;
