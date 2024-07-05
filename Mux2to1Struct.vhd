LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY mux2to1Struct IS
	PORT (
		in1 : in STD_LOGIC;
		in2 : in STD_LOGIC;
		sel : in STD_LOGIC;
		
		output : out STD_LOGIC
	);
END mux2to1Struct;

ARCHITECTURE fpga OF mux2to1Struct IS
	-- Not Gate
	component a_7404
		port (	
			a_2: in STD_LOGIC;
			a_1: out STD_LOGIC
		);
	end component;
	
	-- And Gate
	component a_7408
		port (
			a_2: in STD_LOGIC;
			a_3: in STD_LOGIC;
			a_1: out STD_LOGIC
		);
	end component;

	-- Or Gate 
	component a_7432
		port (	
			a_2: in STD_LOGIC;
			a_3: in STD_LOGIC;
			a_1: out STD_LOGIC
		);
	end component;
	
	signal notSel : STD_LOGIC;
	signal notSelAndIn1 : STD_LOGIC;
	signal selAndIn2 : STD_LOGIC;
BEGIN
	notSel_c: 					a_7404 port map (sel, notSel);
	notSelAndIn1_c: 			a_7408 port map (notSel, in1, notSelAndIn1);
	selAndIn2_c: 				a_7408 port map (sel, in2, selAndIn2);
	notSelAndIn1OrSelAndIn2_c: 	a_7432 port map (notSelAndIn1, selAndIn2, output);
END fpga;
