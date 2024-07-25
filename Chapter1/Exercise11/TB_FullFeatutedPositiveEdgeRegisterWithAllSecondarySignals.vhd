LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
use work.Utilities.ALL;
use std.textio.all;

use work.TBUtilities_FullFeatutedPositiveEdgeRegisterWithAllSecondarySignals.ALL;
use work.TBCases_FullFeatutedPositiveEdgeRegisterWithAllSecondarySignals.ALL;

ENTITY TB_FullFeatutedPositiveEdgeRegisterWithAllSecondarySignals IS
END TB_FullFeatutedPositiveEdgeRegisterWithAllSecondarySignals;
 
ARCHITECTURE sim OF TB_FullFeatutedPositiveEdgeRegisterWithAllSecondarySignals IS 
	-- Component Declaration for the Unit Under Test (UUT)
	component FullFeatutedPositiveEdgeRegisterWithAllSecondarySignals IS
		PORT (
			clk 		: in STD_LOGIC;
			clkEn 		: in STD_LOGIC;
			
			aSyncReset 	: in STD_LOGIC;
			syncReset 	: in STD_LOGIC;
			
			aSyncLoad 	: in STD_LOGIC;
			syncLoad 	: in STD_LOGIC;
			
			aSyncData 	: in STD_LOGIC;
			syncData 	: in STD_LOGIC;
			
			input 		: in STD_LOGIC;
			
			output 		: out STD_LOGIC
		);
	END component FullFeatutedPositiveEdgeRegisterWithAllSecondarySignals;

	--Inputs
	signal clk : STD_LOGIC := '0';
	signal clkEn : STD_LOGIC := '0';
	
	signal aSyncReset : STD_LOGIC := '0';
	signal syncReset : STD_LOGIC := '0';
	
	signal aSyncLoad : STD_LOGIC := '0';
	signal syncLoad : STD_LOGIC := '0';
	
	signal aSyncData : STD_LOGIC := '0';
	signal syncData : STD_LOGIC := '0';
	
	signal input : STD_LOGIC := '0';
	
	--Outputs
	signal output : STD_LOGIC;
	
	signal errorCount : natural := 0;
BEGIN
	uut: FullFeatutedPositiveEdgeRegisterWithAllSecondarySignals
	PORT MAP (
		clk 	=> clk,
		clkEn 	=> clkEn,
		
		aSyncReset => aSyncReset,
		syncReset => syncReset,
		
		aSyncLoad => aSyncLoad,
		syncLoad => syncLoad,
		
		aSyncData => aSyncData,
		syncData => syncData,
		
		input => input,
		
		output 	=> output
	);
	
	driveClock:
	process
	begin
		wait for clkTime/2;
		
		loop
			wait for clkTime/2;
			clk <= not clk;
		end loop;
	end process;
	
	driveInputs_proc:
	process
		variable testCase : cases_T;
		variable sampleCounter : natural := 1;
		
		procedure RunCase_InsideScope is
		begin
			RunCase (
				testCase => testCase,
				clkEn => clkEn,
				aSyncReset => aSyncReset, 
				syncReset => syncReset,
				aSyncLoad => aSyncLoad,
				syncLoad => syncLoad,
				aSyncData => aSyncData,
				syncData => syncData,
				input => input
			);
		end procedure;
		
		procedure setOutputTo1_InsideScope is
		begin
			 setOutputTo1 (
				clkEn => clkEn,
				aSyncReset => aSyncReset, 
				syncReset => syncReset,
				aSyncLoad => aSyncLoad,
				syncLoad => syncLoad,
				aSyncData => aSyncData,
				syncData => syncData,
				input => input
			 );
		end procedure;
	begin
		wait for clkTime/2;
		
		while sampleCounter <= sampleCount loop
			report "Case started: Test Loading Input";
			testCase := TestLoadingInput;
			RunCase_InsideScope;
			report "Case finished: Test Loading Input";
			
			report "Case started: Test Sync Load";
			testCase := TestSyncLoad;
			RunCase_InsideScope;
			report "Case finished: Test Sync Load";
			
			report "Case started: Test Sync Reset";
			testCase := TestSyncReset;
			setOutputTo1_InsideScope;
			RunCase_InsideScope;
			report "Case finished: Test Sync Reset";
			
			report "Case started: Test Async Load";
			testCase := TestAsyncLoad;
			RunCase_InsideScope;
			report "Case finished: Test Async Load";
			
			report "Case started: Test No Load";
			testCase := TestNoLoad;
			RunCase_InsideScope;
			report "Case finished: Test No Load";
			testCase := TestNoLoad;
			
			report "Case started: Test Async Reset";
			testCase := TestAsyncReset;
			setOutputTo1_InsideScope;
			RunCase_InsideScope;
			report "Case finished: Test Async Reset";
			
			sampleCounter := sampleCounter + 1;
		end loop;
		
		report "Number of invalid results: " & tostr(errorCount);
		EndSim;
	end process;

	checkOutputs_proc:
	process		
		variable calculatedOutput : STD_LOGIC := '0';
	begin
		wait for stepTime/2;
		
		loop
			wait on aSyncReset, aSyncLoad, aSyncData, clk;
			
			if (aSyncReset = '0') then
				calculatedOutput := '0';
			elsif (aSyncLoad = '1') then
				calculatedOutput := aSyncData;
			else 
				if (rising_edge(clk)) then
					if (clkEn = '1') then
						if (syncReset = '0') then
							calculatedOutput := '0';
						elsif (syncLoad = '1') then
							calculatedOutput := syncData;
						else
							calculatedOutput := input;
						end if;
					end if;
				end if;
			end if;
			
			wait for stepTime;
					
			if calculatedOutput /= output then
				report "Invalid result: <-{clkEn=" & tostr(clkEn) & "}, <-{aSyncReset=" & tostr(aSyncReset) & "}, <-{syncReset=" & tostr(syncReset) & "}, <-{aSyncLoad=" & tostr(aSyncLoad) & "}, <-{aSyncData=" & tostr(aSyncData) & "}, <-{syncData=" & tostr(syncData) & "}, <-{syncLoad=" & tostr(syncLoad) & "}, <-{input=" & tostr(input) & "}, ->{[output=" & tostr(output)  & "], [Expected output=" & tostr(calculatedOutput) & "]}" severity warning;
				errorCount <= errorCount + 1;
			end if;
		end loop;
	end process;
END;


