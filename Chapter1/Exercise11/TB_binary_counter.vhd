LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
use work.Utilities.ALL;
 
ENTITY TB_binary_counter IS
END TB_binary_counter;
 
ARCHITECTURE sim OF TB_binary_counter IS 	
	constant stepTime : time := 10 ns;
	constant clkTime : time := 10*stepTime;
	constant initSL : STD_LOGIC := '0';	
	
	-- Component Declaration for the Unit Under Test (UUT)
	component binary_counter is
		generic (
			MIN_COUNT : natural := 0;
			MAX_COUNT : natural := 255
		);
		port (
			clk		: in std_logic;
			reset	: in std_logic;
			enable	: in std_logic;
			count 	: out integer range MIN_COUNT to MAX_COUNT
		);
	end component;
	
	-- Generics
	constant MIN_COUNT : natural := 0;
	constant MAX_COUNT : natural := 255;
	
	--Inputs
	signal clk : STD_LOGIC := '0';
	signal reset : STD_LOGIC;
	signal enable : STD_LOGIC;

	--Outputs
	signal count : integer range MIN_COUNT to MAX_COUNT;
	
	signal errorCount : natural := 0;
BEGIN
	uut: binary_counter
	GENERIC MAP (
		MIN_COUNT => MIN_COUNT,
		MAX_COUNT => MAX_COUNT
	)
	PORT MAP (
		clk 	=> clk,
		reset 	=> reset,
		enable 	=> enable,
		count	=> count
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
	
	-- Cannot test overflowing, because the binary counter language template uses integer type for counter port and simulation leads to an error
	-- when overflowing an integer
	driveInputs_proc:
	process
	begin
		reset <= '1';
		enable <= '0';
		wait for clkTime/2;
		
		report "Case started: Test Enable";
		reset <= '0';
		enable <= '1';
		wait for (MAX_COUNT-MIN_COUNT)/2*clkTime;
		report "Case finished: Test Enable";
		
		report "Case started: Test Reset";
		reset <= '1';
		enable <= '1';
		wait for clkTime;
		report "Case finished: Test Reset";
		
		report "Case started: Test ALl Numbers";
		reset <= '0';
		enable <= '1';
		wait for (MAX_COUNT-MIN_COUNT)*clkTime;
		report "Case finished: Test ALl Numbers";
		
		report "Number of invalid results: " & tostr(errorCount);
		EndSim;
	end process;

	checkOutputs_proc:
	process		
		variable calculatedCount : integer range MIN_COUNT to MAX_COUNT;
	begin
		wait for stepTime/2;
		
		loop
			wait on clk;
			
			if (rising_edge(clk)) then
				if reset = '1' then
					calculatedCount := 0;
				elsif enable = '1' then
					calculatedCount := calculatedCount + 1;
				end if;
			end if;
			
			wait for stepTime;
					
			if calculatedCount /= count then
				report "Invalid result: <-{reset=" & tostr(reset) & "}, <-{enable=" & tostr(enable) & "}, ->{[count=" & tostr(count)  & "], [Expected count=" & tostr(calculatedCount) & "]}" severity warning;
				errorCount <= errorCount + 1;
			end if;
		end loop;
	end process;
END;


