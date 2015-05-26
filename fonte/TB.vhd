library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity TB is
end entity;

architecture arch_TB of TB is	
	
	component Processador is
	port(
		clk: in std_logic;
		reset: in std_logic;
		N_instruction: in std_logic_vector(31 downto 0);
		where: in std_logic_vector(31 downto 0);
		WDATA_out: out std_logic_vector(31 downto 0);
		SaidaUla: out std_logic_vector(31 downto 0);
		SaidaBR2: out std_logic_vector(31 downto 0)
	);
end component;

	signal clkPC, reset: std_logic;
	signal newInstruction, address: std_logic_vector( 31 downto 0 );
	signal W_DATA, SAIDA_ULA, SAIDA_BR_2: std_logic_vector( 31 downto 0 );
	
begin
	U0: Processador port map(clkPC, reset, newInstruction, address, W_DATA, SAIDA_ULA, SAIDA_BR_2);

	process
	begin
		-- Comeca zerando e colocando a primeira instrucao --
		clkPC 			<= '0';
		reset 			<= '0';
		


		newInstruction 		<= "00001100000000000000000000000010";
		wait for 5 ns;
		address 		<= "00000000000000000000000000000000";--instrucao de endereco 0.
		wait for 5 ns;
		
		
		--OP: add $9, $0, $0 
		newInstruction 		<= "00000000000000000100100000100000";
		wait for 5 ns;
		address 		<= "00000000000000000000000000000100";--instrucao de endereco 4.
		wait for 5 ns;
		

		--OP: addi $10, $0, 1
		newInstruction 		<= "00000001010010010100000000100010";
		wait for 5 ns;		
		address 		<= "00000000000000000000000000001000";--instrucao de endereco 8.
		wait for 5 ns;		
		

		--OP: beq $8, $0, 24 [quebra-0x00000024] rótolo loop esta aqui [0000000c]
		newInstruction 		<= "10101101010010000000000000000000";
		wait for 5 ns;
		address 		<= "00000000000000000000000000001100";--instrucao de endereco 12.
		wait for 5 ns;
		

		--OP: add $11, $9, $10
		newInstruction 		<= "10001101010001110000000000000000";
		wait for 5 ns;
		address 		<= "00000000000000000000000000010000";--instrucao de endereco 16.
		wait for 5 ns;
		

		--OP:add $9, $0, $10
		newInstruction 		<= "00000000000001110010100000101010";
		wait for 5 ns;
		address 		<= "00000000000000000000000000010100";--instrucao de endereco 20.
		wait for 5 ns;

		


		
		newInstruction 		<= "00010001010001110000000000000011";
		wait for 5 ns;
		address 		<= "00000000000000000000000000011000";--instrucao de endereco 24.
		wait for 5 ns;
		

		--OP: add $11, $9, $10
		newInstruction 		<= "00010101010001110000000000000111";
		wait for 5 ns;
		address 		<= "00000000000000000000000000011100";--instrucao de endereco 28.
		wait for 5 ns;
		

		--OP:add $9, $0, $10
		newInstruction 		<= "00101000111001000000000000000101";
		wait for 5 ns;
		address 		<= "00000000000000000000000000100000";--instrucao de endereco 32.
		wait for 5 ns;


		--OP:jr $3 | 
		newInstruction 		<= "00100000000110100000000000011100";
		wait for 5 ns;
		address 		<= "00000000000000000000000000101000";--instrucao de endereco 40.
		wait for 5 ns;
		

		newInstruction 		<= "00000011010000000000000000001000";
		wait for 5 ns;
		address 		<= "00000000000000000000000000101100";--instrucao de endereco 44.
		wait for 5 ns;



		-- Comeca --
		reset <= '1';
		wait for 5 ns;
		reset <= '0';
		wait for 5 ns;

		for i in 0 to 200 loop
		
			clkPC <= '0';
			wait for 2 ns;
			clkPC <= '1';
			wait for 2 ns;
		end loop;
		

		wait;
	end process;
end architecture;

