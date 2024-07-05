LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY decoder2to4Struct IS
	PORT (
		input : in STD_LOGIC_VECTOR(1 downto 0);
		
		output : out STD_LOGIC_VECTOR(3 downto 0)
	);
END decoder2to4Struct;

ARCHITECTURE fpga OF decoder2to4Struct IS
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
	
	signal notInput : STD_LOGIC_VECTOR(1 downto 0);
	signal notIn2 : STD_LOGIC;
	signal in1AndNotIn2 : STD_LOGIC;
	signal notIn1AndIn2 : STD_LOGIC;
BEGIN
	notInput0_c: 				a_7404 port map (input(0), notInput(0));
	notInput1_c: 				a_7404 port map (input(1), notInput(1));
	notInput0AndNotInput1_c: 	a_7408 port map (notInput(0), notInput(1), output(0));
	input0AndNotInput1_c: 		a_7408 port map (input(0), notInput(1), output(1));
	notInput0AndInput1_c: 		a_7408 port map (notInput(0), input(1), output(2));
	input0AndInput1_c: 			a_7408 port map (input(0), input(1), output(3));
END fpga;
