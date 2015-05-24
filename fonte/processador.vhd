library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity Processador is
	port(
		clk: in std_logic;
		reset: in std_logic;
		N_instruction: in std_logic_vector(31 downto 0);
		where: in std_logic_vector(31 downto 0)
	);
end entity;

architecture arch_processador of processador is
		-- PC --
	component PC is
		port(
			clk: in std_logic;
			In1: in std_logic_vector(31 downto 0);
			saida: out std_logic_vector(31 downto 0)
		);
	end component;	

		-- Data Memory --
	component DataMemory is
		port(
			MemRead: in std_logic;
			MemWrite: in std_logic;
			where: in std_logic_vector(31 downto 0);
			Data: in std_logic_vector(31 downto 0);
			saida1: out std_logic_vector(31 downto 0)
		);
	end component;
	
		-- Instruction Memory --
	component InstructionMemory is
    		port(	
			W_Instruction: in std_logic_vector(31 downto 0);
			instrucao_atual: in std_logic_vector(31 downto 0);
			N_Instruction: in std_logic_vector(31 downto 0);
			saida: out std_logic_vector(31 downto 0)
    		);
	end component;

		-- B_Registradores --
	component B_Registradores is
		port(
			clk: in std_logic;
			RegWrite: in std_logic;
			R_Register1: in std_logic_vector(4 downto 0);
			R_Register2: in std_logic_vector(4 downto 0);
			W_Register: in std_logic_vector(4 downto 0);
			W_Data: in std_logic_vector(31 downto 0);
			R_Data1: out std_logic_vector(31 downto 0);
			R_Data2: out std_logic_vector(31 downto 0)
		);	
	end component;

		-- extender --
	component extender is
		port(
			In1: in std_logic_vector(15 downto 0);
			saida: out std_logic_vector(31 downto 0)
		);
	end component;	

		-- shifter --
	component shifter is
		port(
			In1: in std_logic_vector(31 downto 0);
			saida: out std_logic_vector(31 downto 0)
		);
	end component;	
	

		-- MUX 2x1 --
	component MUX2x1 is
		port(
			controle: in std_logic;
			In1: in std_logic_vector(31 downto 0);
			In2: in std_logic_vector(31 downto 0);
			saida: out std_logic_vector(31 downto 0)
		);
	end component;


	component MUX2x15bits is
		port(
			controle: in std_logic;
			In1: in std_logic_vector(4 downto 0);
			In2: in std_logic_vector(4 downto 0);
			saida: out std_logic_vector(4 downto 0)
		);
	end component;	

		-- ULA --
	component ULA is
		port(
			op: in std_logic_vector( 2 downto 0 );
			In1, In2: in std_logic_vector( 31 downto 0 );
			flag_Z: out std_logic;
			resp: out std_logic_vector( 31 downto 0 )
		);	
	end component;

		-- Controle da ULA --
	component ControleULA is
		port(
			OpCode: in std_logic_vector( 1 downto 0 );
			funct: in std_logic_vector( 5 downto 0 );
			opULA: out std_logic_vector( 2 downto 0 )
		);
	end component;

	
	component somador is
		port(
			In1: in std_logic_vector(31 downto 0);
			In2: in std_logic_vector(31 downto 0);
			saida: out std_logic_vector(31 downto 0)
		);
	end component;


	component controle is
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
	end component;


	signal PC_clk: std_logic;
	signal PC_out: std_logic_vector(31 downto 0);
	signal PC_entrada: std_logic_vector(31 downto 0);

	signal IM_W_inst: std_logic_vector(31 downto 0);
	signal IM_N_inst: std_logic_vector(31 downto 0);
	signal IM_saida: std_logic_vector(31 downto 0);

	signal S_saida: std_logic_vector(31 downto 0);

	signal C_Jump: std_logic;
	signal C_Branch: std_logic;
	signal C_BNE: std_logic;
	signal C_MemRead: std_logic;
	signal C_MemtoReg: std_logic;
	signal C_ALUOp: std_logic_vector(1 downto 0);
	signal C_MemWrite: std_logic;
	signal C_ALUSrc: std_logic;
	signal C_RegWrite: std_logic;
	signal C_Dst: std_logic;
	signal C_JAL: std_logic;

	signal M_5bits: std_logic_vector(4 downto 0);
	signal M_aux1: std_logic_vector(4 downto 0);
	signal M_aux2: std_logic_vector(4 downto 0);

	signal W_DATA: std_logic_vector(31 downto 0);
	signal R_DATA1: std_logic_vector(31 downto 0);
	signal R_DATA2: std_logic_vector(31 downto 0);

	begin
		U0: PC port map(PC_clk, PC_entrada, PC_out);
		U1: InstructionMemory port map(IM_W_inst, PC_out, IM_N_inst, IM_saida);
		U2: somador port map(PC_out, "00000000000000000000000000000100", S_saida);
		U3: controle port map(IM_saida(31 downto 26), C_Jump, C_Branch, C_BNE, C_MemRead, C_MemtoReg, C_ALUOp, C_MemWrite, C_ALUSrc, C_RegWrite, C_Dst, C_JAL);
		M_aux1 <= IM_saida(20 downto 16);
		M_aux2 <= IM_saida(15 downto 11);
		U4: MUX2x15bits port map(C_RegDst, M_aux1, M_aux2, M_5bits);
		U5: B_Registradores port map(PC_clk, C_RegWrite, IM_saida(25 downto 21), IM_saida(20 downto 16), M_5bits, W_DATA, R_DATA1, R_DATA2);
		


end architecture;
