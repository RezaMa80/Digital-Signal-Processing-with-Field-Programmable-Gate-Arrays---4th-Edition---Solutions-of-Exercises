LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY FullFeatutedPositiveEdgeRegisterWithAllSecondarySignals IS
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
END FullFeatutedPositiveEdgeRegisterWithAllSecondarySignals;

ARCHITECTURE fpga OF FullFeatutedPositiveEdgeRegisterWithAllSecondarySignals IS
BEGIN
	process(aSyncReset, aSyncLoad, aSyncData, clk)
	begin
		if (aSyncReset = '0') then
			output <= '0';
		elsif (aSyncLoad = '1') then
			output <= aSyncData;
		else 
			if (rising_edge(clk)) then
				if (clkEn = '1') then
					if (syncReset = '0') then
						output <= '0';
					elsif (syncLoad = '1') then
						output <= syncData;
					else
						output <= input;
					end if;
				end if;
			end if;
		end if;
	end process;
END fpga;
