LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
use work.Utilities.ALL;
 
ENTITY TB_Decoder2to4 IS
END TB_Decoder2to4;
 
ARCHITECTURE behavior OF TB_Decoder2to4 IS 
	constant stepTime : time := 10 ns;
		
	-- Component Declaration for the Unit Under Test (UUT)
		component decoder2to4Behave IS
			PORT (
				input : in STD_LOGIC_VECTOR(1 downto 0);
				
				output : out STD_LOGIC_VECTOR(3 downto 0)
			);
		END component decoder2to4Behave;
	
		component decoder2to4Struct IS
			PORT (
				input : in STD_LOGIC_VECTOR(1 downto 0);
				
				output : out STD_LOGIC_VECTOR(3 downto 0)
			);
		END component decoder2to4Struct;

		
	--Inputs
	signal input : STD_LOGIC_VECTOR(1 downto 0);

	--Outputs
	signal outputStruct, outputBehave : STD_LOGIC_VECTOR(3 downto 0);
	
	constant ALL_ONE : STD_LOGIC_VECTOR(input'RANGE) := (others => '1');
BEGIN

	uutStruct: decoder2to4Struct
	PORT MAP (
		input => input,
		
		output => outputStruct
	);
	
	uutBehave: decoder2to4Behave
	PORT MAP (
		input => input,
		
		output => outputBehave
	);
	
	driveInputs_proc:
	process
		variable inputVar : std_logic_vector(input'RANGE) := (others => '0');
	begin
		input <= inputVar;
		
		wait for stepTime;
				
		inputVar := std_logic_vector(unsigned(inputVar) + 1);
				
		if (input = ALL_ONE) then  
			EndSim;
		end if;
	end process;

	checkOutputs_proc:
	process
		variable errorCount : natural := 0;
		
		variable calculatedOutput : STD_LOGIC_VECTOR(outputStruct'RANGE);
	begin		
		wait for stepTime/2;
		
		loop
			calculatedOutput := (others => '0');
			calculatedOutput(toint(input)) := '1';
						
			if calculatedOutput /= outputStruct then
				report "Invalid result in struct: <-{Input=" & tostr(input) & "}, ->{[output=" & tostr(outputStruct, false, true)  & "], [Expected output=" & tostr(calculatedOutput, false, true) & "]}" severity warning;
				errorCount := errorCount + 1;
			end if;
			
			if calculatedOutput /= outputBehave then
				report "Invalid result in behave: <-{Input=" & tostr(input) & "}, ->{[output=" & tostr(outputBehave, false, true)  & "], [Expected output=" & tostr(calculatedOutput, false, true) & "]}" severity warning;
				errorCount := errorCount + 1;
			end if;
			
			if input = ALL_ONE then
				report "Number of invalid results: " & tostr(errorCount);
			end if;
		
			wait for stepTime;
		end loop;
	end process;
END;


