LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use work.Utilities.ALL;
 
ENTITY TB_XNORGate IS
END TB_XNORGate;
 
ARCHITECTURE behavior OF TB_XNORGate IS 
	constant stepTime : time := 10 ns;
	
	constant SLInit : std_logic := '0';
	
	-- Component Declaration for the Unit Under Test (UUT)
	COMPONENT XNORGateStruct
		PORT (
			in1 : in STD_LOGIC;
			in2 : in STD_LOGIC;
			
			output : out STD_LOGIC
		);
	END COMPONENT;
	
	COMPONENT XNORGateBehave
		PORT (
			in1 : in STD_LOGIC;
			in2 : in STD_LOGIC;
			
			output : out STD_LOGIC
		);
	END COMPONENT;
		
	--Inputs
	signal in1 : STD_LOGIC;
	signal in2 : STD_LOGIC;

	--Outputs
	signal outputStruct, outputBehave : STD_LOGIC;
BEGIN

	uutStruct: XNORGateStruct
	PORT MAP (
		in1 => in1,
		in2 => in2,

		output => outputStruct
	);
	
	uutBehave: XNORGateBehave
	PORT MAP (
		in1 => in1,
		in2 => in2,

		output => outputBehave
	);
	
	driveInputs_proc:
	process
		variable in1Var, in2Var : std_logic := SLInit;
	begin
		in1 <= in1Var;
		in2 <= in2Var;
		
		wait for stepTime;
				
		in1Var := not in1Var;
				
		if (in1 /= SLInit) then 
			in1Var := SLInit;
			in2Var := not in2Var;
			
			if (in2 /= SLInit) then 
				EndSim;
			end if;
		end if;
	end process;

	checkOutputs_proc:
	process
		variable errorCount : natural := 0;
		
		variable calculatedOutput : STD_LOGIC;
	begin		
		wait for stepTime/2;
		
		loop
			calculatedOutput := in1 xnor in2;
			
			if calculatedOutput /= outputStruct then
				report "Invalid result in struct: <-{In1=" & tostr(In1) & "}, <-{In2=" & tostr(In2) & "}, ->{[output=" & tostr(outputStruct)  & "], [Expected Output=" & tostr(calculatedOutput) & "]}" severity warning;
				errorCount := errorCount + 1;
			end if;
			
			if calculatedOutput /= outputBehave then
				report "Invalid result in behave: <-{In1=" & tostr(In1) & "}, <-{In2=" & tostr(In2) & "}, ->{[output=" & tostr(outputBehave)  & "], [Expected Output=" & tostr(calculatedOutput) & "]}" severity warning;
				errorCount := errorCount + 1;
			end if;
			
			if in1 /= SLInit and in2 /= SLInit then
				report "Number of invalid results: " & tostr(errorCount);
			end if;
		
			wait for stepTime;
		end loop;
	end process;
END;


