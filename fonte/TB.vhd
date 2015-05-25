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

		--n-esimo termo da sequencia de fibonacci.
		--deve ser colocado aqui no lugar do 8.
		--OP: addi $8, $0, 8
		newInstruction <= x"20080008";
		wait for 5 ns;
		address <= x"00000000";--instrucao de endereco 0.
		wait for 5 ns;
		
		
		--OP: add $9, $0, $0 
		newInstruction <= x"00004820";
		wait for 5 ns;
		address <= x"00000004";--instrucao de endereco 4.
		wait for 5 ns;
		

		--OP: addi $10, $0, 1
		newInstruction <= x"200a0001";
		wait for 5 ns;		
		address <= x"00000008";--instrucao de endereco 8.
		wait for 5 ns;		
		

		--OP: beq $8, $0, 24 [quebra-0x00000024] rótolo loop esta aqui [0000000c]
		newInstruction <= x"11000006";
		wait for 5 ns;
		address <= x"0000000c";--instrucao de endereco 12.
		wait for 5 ns;
		

		--OP: add $11, $9, $10
		newInstruction <= x"012a5820";
		wait for 5 ns;
		address <= x"00000010";--instrucao de endereco 16.
		wait for 5 ns;
		

		--OP:add $9, $0, $10
		newInstruction <= x"000a4820";
		wait for 5 ns;
		address <= x"00000014";--instrucao de endereco 20.
		wait for 5 ns;
		

		--OP: add $10, $0, $11
		newInstruction <= x"000b5020";
		wait for 5 ns;
		address <= x"00000018";--instrucao de endereco 24.
		wait for 5 ns;

		--OP: addi $8, $8, -1 
		newInstruction <= x"2108ffff";
		wait for 5 ns;
		address <= x"0000001c";--instrucao de endereco 28.
		wait for 5 ns;
		

		--OP: j 0x000000003 [loop]
		newInstruction <= x"08000003";
		wait for 5 ns;
		address <= x"00000020";--instrucao de endereco 32.
		wait for 5 ns;
		

		--OP: rotolo quebra esta aqui
		newInstruction <= x"00000000";
		wait for 5 ns;
		address <= x"00000024";--instrucao de endereco 36.
		wait for 5 ns;
		

		--OP: ?
		newInstruction <= x"00000000";
		wait for 5 ns;
		address <= x"00000028";--instrucao de endereco 40.
		wait for 5 ns;
		

		--OP: ?
		newInstruction <= x"00000000";
		wait for 5 ns;
		address <= x"0000002c";--instrucao de endereco 44.
		wait for 5 ns;
		

		reset <= '0';
		wait for 5 ns;
		reset <= '1';
		wait for 5 ns;
		reset <= '0';

		wait for 1 ns;
		for i in 0 to 200 loop
		
			clkPC <= '0';
			wait for 5 ns;
			clkPC <= '1';
			wait for 5 ns;
		end loop;
		

		wait;
	end process;
end architecture;
