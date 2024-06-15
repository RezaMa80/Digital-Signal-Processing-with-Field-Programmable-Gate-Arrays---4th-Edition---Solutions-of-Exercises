LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY MultiPREPBenchmark2 IS
	PORT (
		clk : IN STD_LOGIC;
		rst : IN STD_LOGIC;
		
		data1 	: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		data2  	: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		ldpre		: IN STD_LOGIC;
		ldcomp 	: IN STD_LOGIC;
		sel   	: IN STD_LOGIC;
		
		data0 : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END MultiPREPBenchmark2;

ARCHITECTURE fpga OF MultiPREPBenchmark2 IS
	constant PREPBenchmark2Count : positive := 5203;
	
	component PREPBenchmark2
		port (
			clk : IN STD_LOGIC;
			rst : IN STD_LOGIC;
			
			data1 	: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
			data2  	: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
			ldpre		: IN STD_LOGIC;
			ldcomp 	: IN STD_LOGIC;
			sel   	: IN STD_LOGIC;
			
			data0 : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
		);
	end component;
	
	type data1_T is array (natural range<>) of std_logic_vector(7 downto 0);
	signal data1s : data1_T(PREPBenchmark2Count downto 0);
BEGIN
	data1s(PREPBenchmark2Count) <= data1;
	
	PREPBenchmark1_Gen: 
	for X in PREPBenchmark2Count-1 downto 0 generate
		PREPBenchmark2X: PREPBenchmark2 
		port map (
			clk => clk,
			rst => rst,
			data1 => data1s(X+1),
			data2 => data2,
			ldpre => ldpre,
			ldcomp => ldcomp,
			sel => sel,
			data0 => data1s(X)
		);
	end generate;
	
	data0 <= data1s(0);
END fpga;
