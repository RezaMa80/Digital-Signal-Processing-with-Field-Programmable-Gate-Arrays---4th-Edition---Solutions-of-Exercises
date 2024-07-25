library IEEE;
use IEEE.STD_LOGIC_1164.all;
use std.textio.all;
use work.Utilities.ALL;
use work.TBUtilities_FullFeatutedPositiveEdgeRegisterWithAllSecondarySignals.ALL;

package TBCases_FullFeatutedPositiveEdgeRegisterWithAllSecondarySignals is
	procedure RunCase (
		variable testCase : in cases_T;
		signal clkEn: out std_logic;
		signal aSyncReset: out std_logic;
		signal syncReset: out std_logic;
		signal aSyncLoad: out std_logic;
		signal syncLoad: out std_logic;
		signal aSyncData: out std_logic;
		signal syncData: out std_logic;
		signal input: out std_logic
	);
	
	procedure setOutputTo1 (
		signal clkEn: out std_logic;
		signal aSyncReset: out std_logic;
		signal syncReset: out std_logic;
		signal aSyncLoad: out std_logic;
		signal syncLoad: out std_logic;
		signal aSyncData: out std_logic;
		signal syncData: out std_logic;
		signal input: out std_logic
	);
end TBCases_FullFeatutedPositiveEdgeRegisterWithAllSecondarySignals;

package body TBCases_FullFeatutedPositiveEdgeRegisterWithAllSecondarySignals is
	procedure RunCase (
		variable testCase : in cases_T;
		signal clkEn : out std_logic;
		signal aSyncReset : out std_logic;
		signal syncReset : out std_logic;
		signal aSyncLoad : out std_logic;
		signal syncLoad : out std_logic;
		signal aSyncData : out std_logic;
		signal syncData : out std_logic;
		signal input : out std_logic
	) is
	begin
		case testCase is
			when TestLoadingInput =>
				for i in 1 to testCount loop
					clkEn 		<= '1';
					aSyncReset 	<= '1';
					syncReset 	<= '1';
					aSyncLoad 	<= '0';
					syncLoad 	<= '0';
					aSyncData 	<= readSLV(bitsFile, 1)(0);
					syncData 	<= readSLV(bitsFile, 1)(0);
					input 		<= readSLV(bitsFile, 1)(0);
					wait for clkTime;
				end loop;
				
			when TestSyncLoad =>
				for i in 1 to testCount loop
					clkEn 		<= '1';
					aSyncReset 	<= '1';
					syncReset 	<= '1';
					aSyncLoad 	<= '0';
					syncLoad 	<= '1';
					aSyncData 	<= readSLV(bitsFile, 1)(0);
					syncData 	<= readSLV(bitsFile, 1)(0);
					input 		<= readSLV(bitsFile, 1)(0);
					wait for clkTime;
				end loop;
				
			when TestSyncReset =>
				clkEn 		<= '1';
				aSyncReset 	<= '1';
				syncReset 	<= '0';
				aSyncLoad 	<= '0';
				syncLoad 	<= readSLV(bitsFile, 1)(0);
				aSyncData 	<= readSLV(bitsFile, 1)(0);
				syncData 	<= readSLV(bitsFile, 1)(0);
				input 		<= readSLV(bitsFile, 1)(0);
				wait for clkTime;
				
			when TestAsyncLoad =>
				for i in 1 to testCount loop
					clkEn 		<= '1';
					aSyncReset 	<= '1';
					syncReset 	<= readSLV(bitsFile, 1)(0);
					aSyncLoad 	<= '1';
					syncLoad 	<= readSLV(bitsFile, 1)(0);
					aSyncData 	<= readSLV(bitsFile, 1)(0);
					syncData 	<= readSLV(bitsFile, 1)(0);
					input 		<= readSLV(bitsFile, 1)(0);
					wait for clkTime;
				end loop;
				
			when TestNoLoad =>
				for i in 1 to testCount loop
					clkEn 		<= '0';
					aSyncReset 	<= '1';
					syncReset 	<= readSLV(bitsFile, 1)(0);
					aSyncLoad 	<= '0';
					syncLoad 	<= readSLV(bitsFile, 1)(0);
					aSyncData 	<= readSLV(bitsFile, 1)(0);
					syncData 	<= readSLV(bitsFile, 1)(0);
					input 		<= readSLV(bitsFile, 1)(0);
					wait for clkTime;
				end loop;
				
			when TestAsyncReset =>
				clkEn 		<= readSLV(bitsFile, 1)(0);
				aSyncReset 	<= '0';
				syncReset 	<= readSLV(bitsFile, 1)(0);
				aSyncLoad 	<= readSLV(bitsFile, 1)(0);
				syncLoad 	<= readSLV(bitsFile, 1)(0);
				aSyncData 	<= readSLV(bitsFile, 1)(0);
				syncData 	<= readSLV(bitsFile, 1)(0);
				input 		<= readSLV(bitsFile, 1)(0);
				wait for clkTime;
		end case;
	end procedure;
	
	procedure setOutputTo1 (
		signal clkEn : out std_logic;
		signal aSyncReset : out std_logic;
		signal syncReset : out std_logic;
		signal aSyncLoad : out std_logic;
		signal syncLoad : out std_logic;
		signal aSyncData : out std_logic;
		signal syncData : out std_logic;
		signal input : out std_logic
	) is
	begin
		clkEn 		<= '1';
		aSyncReset 	<= '1';
		syncReset 	<= '1';
		aSyncLoad 	<= '0';
		syncLoad 	<= '1';
		aSyncData 	<= readSLV(bitsFile, 1)(0);
		syncData 	<= '1';
		input 		<= readSLV(bitsFile, 1)(0);
		wait for clkTime;
	end procedure;
end TBCases_FullFeatutedPositiveEdgeRegisterWithAllSecondarySignals;

