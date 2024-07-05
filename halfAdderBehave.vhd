LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY halfAdderBehave IS
	PORT (
		in1 : in STD_LOGIC;
		in2 : in STD_LOGIC;
		
		carryOut : 	out STD_LOGIC;
		sum : 		out STD_LOGIC
	);
END halfAdderBehave;

ARCHITECTURE fpga OF halfAdderBehave IS
	signal in1SLV, in2SLV : std_logic_vector(0 downto 0);
	signal sumResult : std_logic_vector(1 downto 0);
BEGIN
	in1SLV(0) <= in1;
	in2SLV(0) <= in2;
	
	sumResult <= std_logic_vector(
									("0"&unsigned(in1SLV)) + unsigned(in2SLV)
								);
								
	(carryOut, sum) <= sumResult;
END fpga;
