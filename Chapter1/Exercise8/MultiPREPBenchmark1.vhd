LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY MultiPREPBenchmark1 IS
	PORT (
		clk :  IN STD_LOGIC;
		rst :  IN STD_LOGIC;
		
		idp : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		id  :  IN STD_LOGIC_VECTOR(23 DOWNTO 0);
		s   :  IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		sl   :  IN STD_LOGIC;
		
		q :  OUT STD_LOGIC_VECTOR(7 DOWNTO 0) := (others => 'X')
	);
END MultiPREPBenchmark1;

ARCHITECTURE fpga OF MultiPREPBenchmark1 IS
	constant PREPBenchmark1Count : positive := 4991;
	
	component PREPBenchmark1 
		port (
			clk :  IN STD_LOGIC;
			rst :  IN STD_LOGIC;
			
			idp : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
			id  :  IN STD_LOGIC_VECTOR(23 DOWNTO 0);
			s   :  IN STD_LOGIC_VECTOR(1 DOWNTO 0);
			sl   :  IN STD_LOGIC;
			
			q :  OUT STD_LOGIC_VECTOR(7 DOWNTO 0) := (others => 'X')
		);
	end component;
	
	type q_T is array (natural range<>) of std_logic_vector(7 downto 0);
	signal qs : q_T(PREPBenchmark1Count downto 0);
BEGIN
	qs(PREPBenchmark1Count) <= idp;
	
	PREPBenchmark1_Gen: 
	for X in PREPBenchmark1Count-1 downto 0 generate
		PREPBenchmark1X: PREPBenchmark1 
		port map (
			clk => clk,
			rst => rst,
			idp => qs(X+1),
			id => id,
			s => s,
			sl => sl,
			q => qs(X)
		);
	end generate;
	
	q <= qs(0);
END fpga;
