LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY XNORGateBehave IS
	PORT (
		in1 : in STD_LOGIC;
		in2 : in STD_LOGIC;
		
		output : out STD_LOGIC
	);
END XNORGateBehave;

ARCHITECTURE fpga OF XNORGateBehave IS
BEGIN
	output <= in1 xnor in2;
END fpga;
