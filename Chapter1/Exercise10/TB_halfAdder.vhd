LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
use work.Utilities.ALL;
 
ENTITY TB_halfAdder IS
END TB_halfAdder;
 
ARCHITECTURE behavior OF TB_halfAdder IS 
	constant stepTime : time := 10 ns;
	
	constant SLInit : std_logic := '0';
	
	-- Component Declaration for the Unit Under Test (UUT)
	COMPONENT halfAdderStruct
		PORT (
			in1 : in STD_LOGIC;
			in2 : in STD_LOGIC;
			
			carryOut : 	out STD_LOGIC;
			sum : 		out STD_LOGIC
		);
	END COMPONENT;
	
	COMPONENT halfAdderBehave
		PORT (
			in1 : in STD_LOGIC;
			in2 : in STD_LOGIC;
			
			carryOut : 	out STD_LOGIC;
			sum : 		out STD_LOGIC
		);
	END COMPONENT;
		
	--Inputs
	signal in1 : STD_LOGIC;
	signal in2 : STD_LOGIC;

	--Outputs
	signal carryOutStruct, carryOutBehave : STD_LOGIC;
	signal sumStruct, sumBehave : STD_LOGIC;
BEGIN

	uutStruct: halfAdderStruct
	PORT MAP (
		in1 => in1,
		in2 => in2,

		carryOut => carryOutStruct,
		sum => sumStruct
	);
	
	uutBehave: halfAdderBehave
	PORT MAP (
		in1 => in1,
		in2 => in2,

		carryOut => carryOutBehave,
		sum => sumBehave
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
		
		variable calculatedSum, calculatedCarryOut : STD_LOGIC;
		variable in1SLV, in2SLV : STD_LOGIC_VECTOR(0 downto 0);
	begin		
		wait for stepTime/2;
		
		loop
			in1SLV(0) := in1;
			in2SLV(0) := in2;
			
			(calculatedCarryOut, calculatedSum) := std_logic_vector("0"&unsigned(in1SLV) + unsigned(in2SLV));
			
			if calculatedSum /= sumStruct then
				report "Invalid result in struct: <-{In1=" & tostr(In1) & "}, <-{In2=" & tostr(In2) & "}, ->{[sum=" & tostr(sumStruct)  & "], [Expected sum=" & tostr(calculatedSum) & "]}" severity warning;
				errorCount := errorCount + 1;
			end if;
			
			if calculatedCarryOut /= carryOutStruct then
				report "Invalid result in struct: <-{In1=" & tostr(In1) & "}, <-{In2=" & tostr(In2) & "}, ->{[carryOut=" & tostr(carryOutStruct)  & "], [Expected carryOut=" & tostr(calculatedCarryOut) & "]}" severity warning;
				errorCount := errorCount + 1;
			end if;
			
			if calculatedSum /= sumBehave then
				report "Invalid result in struct: <-{In1=" & tostr(In1) & "}, <-{In2=" & tostr(In2) & "}, ->{[sum=" & tostr(sumBehave)  & "], [Expected sum=" & tostr(calculatedSum) & "]}" severity warning;
				errorCount := errorCount + 1;
			end if;
			
			if calculatedCarryOut /= carryOutBehave then
				report "Invalid result in struct: <-{In1=" & tostr(In1) & "}, <-{In2=" & tostr(In2) & "}, ->{[carryOut=" & tostr(carryOutBehave)  & "], [Expected carryOut=" & tostr(calculatedCarryOut) & "]}" severity warning;
				errorCount := errorCount + 1;
			end if;
			
			if in1 /= SLInit and in2 /= SLInit then
				report "Number of invalid results: " & tostr(errorCount);
			end if;
		
			wait for stepTime;
		end loop;
	end process;
END;


