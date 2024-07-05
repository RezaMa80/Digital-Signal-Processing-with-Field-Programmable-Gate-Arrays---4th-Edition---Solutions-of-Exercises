LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY XNORGateStruct IS
	PORT (
		in1 : in STD_LOGIC;
		in2 : in STD_LOGIC;
		
		output : out STD_LOGIC
	);
END XNORGateStruct;

ARCHITECTURE fpga OF XNORGateStruct IS
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
	
	signal notIn1 : STD_LOGIC;
	signal notIn2 : STD_LOGIC;
	signal notIn1AndNotIn2 : STD_LOGIC;
	signal in1AndIn2 : STD_LOGIC;
BEGIN
	notIn1_c: 						a_7404 port map (in1, notIn1);
	notIn2_c: 						a_7404 port map (in2, notIn2);
	notIn1AndNotIn2_c: 				a_7408 port map (notIn1, notIn2, notIn1AndNotIn2);
	in1AndIn2_c: 					a_7408 port map (in1, in2, in1AndIn2);
	notIn1AndNotIn2OrIn1AndIn2_c: 	a_7432 port map (notIn1AndNotIn2, in1AndIn2, output);
END fpga;
