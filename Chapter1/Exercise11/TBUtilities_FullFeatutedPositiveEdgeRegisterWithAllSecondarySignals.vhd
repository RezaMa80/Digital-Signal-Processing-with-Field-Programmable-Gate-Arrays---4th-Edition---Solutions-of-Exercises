library IEEE;
use IEEE.STD_LOGIC_1164.all;
use std.textio.all;

package TBUtilities_FullFeatutedPositiveEdgeRegisterWithAllSecondarySignals is 
	type cases_T is (TestLoadingInput, TestSyncLoad, TestSyncReset, TestAsyncLoad, TestNoLoad, TestAsyncReset);
	constant sampleCount : positive := 10;
	constant testCount : positive := 5;
	constant stepTime : time := 10 ns;
	constant clkTime : time := 10*stepTime;
	
	file bitsFile : text open read_mode is "random01.txt";
end TBUtilities_FullFeatutedPositiveEdgeRegisterWithAllSecondarySignals;

package body TBUtilities_FullFeatutedPositiveEdgeRegisterWithAllSecondarySignals is
end TBUtilities_FullFeatutedPositiveEdgeRegisterWithAllSecondarySignals;
