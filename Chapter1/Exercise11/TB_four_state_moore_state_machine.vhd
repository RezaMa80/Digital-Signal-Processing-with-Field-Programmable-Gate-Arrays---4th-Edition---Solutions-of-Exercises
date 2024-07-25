LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
use work.Utilities.ALL;
use std.textio.all;

ENTITY TB_four_state_moore_state_machine IS
END TB_four_state_moore_state_machine;
 
ARCHITECTURE sim OF TB_four_state_moore_state_machine IS 	
	constant sampleCount : positive := 10;
	
	constant stepTime : time := 10 ns;
	constant clkTime : time := 10*stepTime;
	constant initSL : STD_LOGIC := '0';	
	
	-- Component Declaration for the Unit Under Test (UUT)
	component four_state_moore_state_machine is
		port (
			clk		 : in	std_logic;
			input	 : in	std_logic;
			reset	 : in	std_logic;
			output	 : out	std_logic_vector(1 downto 0)
		);
	end component;
	
	file bitsFile : text open read_mode is "random01.txt";
	
	--Inputs
	signal clk : STD_LOGIC := '0';
	signal input : STD_LOGIC;
	signal reset : STD_LOGIC;

	--Outputs
	signal output : std_logic_vector(1 downto 0);
	
	signal errorCount : natural := 0;
BEGIN
	uut: four_state_moore_state_machine
	PORT MAP (
		clk 	=> clk,
		reset 	=> reset,
		input 	=> input,
		output	=> output
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
		variable sampleCounter : natural := 1;
	begin
		reset <= '1';
		input <= '0';
		wait for clkTime/2;
		
		reset <= '0';
		while sampleCounter <= sampleCount loop
			input <= readSLV(bitsFile, 1)(0);
			
			sampleCounter := sampleCounter + 1;
			wait for clkTime;
		end loop;
		
		reset <= '1';
		wait for clkTime;
		
		report "Number of invalid results: " & tostr(errorCount);
		EndSim;
	end process;

	checkOutputs_proc:
	process		
		variable calculatedOutput : std_logic_vector(1 downto 0) := (others => '0');
	begin
		wait for stepTime/2;
		
		loop
			wait on clk;
			
			if (rising_edge(clk)) then
				if reset = '1' then
					calculatedOutput := (others => '0');
				elsif input = '1' then
					calculatedOutput := STD_LOGIC_VECTOR(unsigned(calculatedOutput) + 1);
				end if;
			
				wait for stepTime;
						
				if calculatedOutput /= output then
					report "Invalid result: <-{reset=" & tostr(reset) & "}, <-{input=" & tostr(input) & "}, ->{[output=" & tostr(output)  & "], [Expected output=" & tostr(calculatedOutput) & "]}" severity warning;
					errorCount <= errorCount + 1;
				end if;
			end if;
		end loop;
	end process;
END;


