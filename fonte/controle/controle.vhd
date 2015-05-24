library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity controle is
	port(
			instrucao: 	in std_logic_vector(5 downto 0);
			
			Jump: 		out std_logic;
			Branch: 	out std_logic;
			BNE: 		out std_logic;
			MemRead: 	out std_logic;
			MemtoReg: 	out std_logic;
			ALUOP: 		out std_logic_vector(1 downto 0);
			MemWrite: 	out std_logic;
			ALUSrc: 	out std_logic;
			RegWrite: 	out std_logic;
			RegDst: 	out std_logic;
			JAL: 		out std_logic
		);
end entity;	

architecture arch_controle of controle is

begin
	process(instrucao)
	begin

		if(instrucao = "000000")then	-- R-TYPE
			Jump		<= 0;
			Branch		<= 0;
			BNE			<= 0;
			MemRead		<= 0;
			MemtoReg	<= 1;
			ALUOP		<= "10";
			MemWrite	<= 0;
			ALUSrc		<= 0;
			RegWrite	<= 1;
			RegDst		<= 1; 
			JAL			<= 0;
			
		elsif(instrucao = "100011")then		-- LW		
			RegDst <= '0';
			Branch <= '0';
			MemtoReg <= '1';
			RegWrite <= '1';
			MemRead <= '1';
			MemWrite <= '0';
			ALUSrc <= '1';
			ALUOP <= "00";
			Jump <= '0';
			BNE <= '0';
			JAL <= '0';
		
		elsif(instrucao = "101011")then --	sw
			RegDst <= '0';
			Branch <= '0';
			MemtoReg <= '0';
			RegWrite <= '0';
			MemRead <= '0';
			MemWrite <= '1';
			ALUSrc <= '1';
			ALUOP <= "00";
			Jump <= '0';
			BNE <= '0';
			JAL <= '0';
			
		elsif(instrucao = "000100" )then --	beq
			RegDst <= '0';
			Branch <= '1';
			MemtoReg <= '0';
			RegWrite <= '0';
			MemRead <= '0';
			MemWrite <= '0';
			ALUSrc <= '0';
			ALUOP <= "01"; 
			Jump <= '0';
			BNE <= '0';
			JAL <= '0';
		
		elsif(instrucao = "000010")then --	Jump
			RegDst <= '0';
			Branch <= '0';
			MemtoReg <= '0';
			RegWrite <= '0';
			MemRead <= '0';
			MemWrite <= '0';
			ALUSrc <= '0';
			ALUOP <= "00"; 
			Jump <= '1';
			BNE <= '0';
			JAL <= '0';
		
		elsif(instrucao = "001000")then --	addi
			RegDst <= '0';
			Branch <= '0';
			MemtoReg <= '0';
			RegWrite <= '1';
			MemRead <= '0';
			MemWrite <= '0';
			ALUSrc <= '1';
			ALUOP <= "00"; 
			Jump <= '0';
			BNE <= '0';
			JAL <= '0';
		
		elsif(instrucao = "001100")then --	slti
			RegDst <= '0';
			Branch <= '0';
			MemtoReg <= '0';
			RegWrite <= '1';
			MemRead <= '0';
			MemWrite <= '0';
			ALUSrc <= '1';
			ALUOP <= "10"; 
			Jump <= '0';
			BNE <= '0';
			JAL <= '0';
		
		elsif(instrucao = "000101")then --	BNE
			RegDst <= '0';
			Branch <= '0';
			MemtoReg <= '0';
			RegWrite <= '0';
			MemRead <= '0';
			MemWrite <= '0';
			ALUSrc <= '0';
			ALUOP <= "01"; 
			Jump <= '0';
			BNE <= '1';
			JAL <= '0';
			
		elsif(instrucao = "000011")then --	JAL
			RegDst <= '0';
			Branch <= '0';
			MemtoReg <= '0';
			RegWrite <= '1';
			MemRead <= '0';
			MemWrite <= '0';
			ALUSrc <= '0';
			ALUOP <= "00"; 
			Jump <= '1';
			BNE <= '0';
			JAL <= '1';

		end if;
		
	end process;
end architecture;
