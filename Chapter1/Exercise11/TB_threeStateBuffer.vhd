LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
use work.Utilities.ALL;
 
ENTITY TB_threeStateBuffer IS
END TB_threeStateBuffer;
 
ARCHITECTURE sim OF TB_threeStateBuffer IS 
	constant stepTime : time := 10 ns;
	
	constant initSL : STD_LOGIC := '0';	
	
	-- Component Declaration for the Unit Under Test (UUT)
	component threeStateBuffer IS
		PORT (
				input : in STD_LOGIC;
				gate : in STD_LOGIC;
				
				output : out STD_LOGIC
		);
	END component threeStateBuffer;

	--Inputs
	signal input : STD_LOGIC;
	signal gate : STD_LOGIC;

	--Outputs
	signal output : STD_LOGIC;
BEGIN
	uut: threeStateBuffer
	PORT MAP (
		input 	=> input,
		gate 	=> gate,
		output 	=> output
	);
	
	driveInputs_proc:
	process
		variable inputVar 	: std_logic := initSL;
		variable gateVar 	: std_logic := initSL;
	begin
		input <= inputVar;
		gate <= gateVar;
		
		wait for stepTime;
				
		inputVar := not inputVar;
				
		if (input /= initSL) then 
			gateVar := not gateVar;
			
			if (gate /= initSL) then 
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
			if gate = '1' then
				calculatedOutput := input;
			else
				calculatedOutput := 'Z';
			end if;
						
			if calculatedOutput /= output then
				report "Invalid result: <-{Input=" & tostr(input) & "}, <-{Gate=" & tostr(gate) & "}, ->{[output=" & tostr(output)  & "], [Expected output=" & tostr(calculatedOutput) & "]}" severity warning;
				errorCount := errorCount + 1;
			end if;
			
			if input /= initSL and gate /= initSL then
				report "Number of invalid results: " & tostr(errorCount);
			end if;
		
			wait for stepTime;
		end loop;
	end process;
END;


