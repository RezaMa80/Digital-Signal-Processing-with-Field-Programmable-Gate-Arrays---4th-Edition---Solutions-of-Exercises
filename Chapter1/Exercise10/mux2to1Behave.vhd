LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY mux2to1Behave IS
	PORT (
		in1 : in STD_LOGIC;
		in2 : in STD_LOGIC;
		sel : in STD_LOGIC;
		
		output : out STD_LOGIC
	);
END mux2to1Behave;

ARCHITECTURE fpga OF mux2to1Behave IS
BEGIN
	with sel
		select output <= 	in1 when '0', 
							in2 when '1',
							'X' when others;
END fpga;
