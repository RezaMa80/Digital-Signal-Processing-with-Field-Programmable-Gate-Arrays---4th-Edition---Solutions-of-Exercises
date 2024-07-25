LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY threeStateBuffer IS
	PORT (
		input : in STD_LOGIC;
		gate : in STD_LOGIC;
		
		output : out STD_LOGIC
	);
END threeStateBuffer;

ARCHITECTURE fpga OF threeStateBuffer IS
BEGIN
	output <= input when (gate = '1') else 'Z';
END fpga;
