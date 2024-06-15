LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY PREPBenchmark2 IS
	PORT (
		clk : IN STD_LOGIC;
		rst : IN STD_LOGIC;
		
		data1 	: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		data2  	: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		ldpre		: IN STD_LOGIC;
		ldcomp 	: IN STD_LOGIC;
		sel   	: IN STD_LOGIC;
		
		data0 : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END PREPBenchmark2;

ARCHITECTURE fpga OF PREPBenchmark2 IS
	signal data2Mux0_r : std_logic_vector(7 downto 0);
	signal data2Comp_r : std_logic_vector(7 downto 0);
	
	signal muxOut : std_logic_vector(7 downto 0);
	
	signal counter : std_logic_vector(7 downto 0) := (others => '0');
	
	signal ld : std_logic;
	
	-- After reset, all registers are zero and equal, so counter is loaded by mux.
	-- But we want the counter to start after reset, so we use below signal to determne if registers are equal due to de reset.
	signal justReseted : std_logic := '0';
BEGIN
	muxOut <= 	data2Mux0_r when sel = '0' else
					data1 		when sel = '1' else
					(others => 'X');
	
	ld <= '1' when (counter = data2Comp_r) and justReseted /= '1' else
			'0';
			
	process (rst, clk) is
	begin
		if (rst = '1') then
			data2Mux0_r <= (others => '0');
			data2Comp_r <= (others => '0');
			counter 		<= (others => '0');
			justReseted <= '1';
		elsif (rising_edge(clk)) then
			justReseted <= '0';
			
			if ldpre = '1' then
				data2Mux0_r <= data2;
			end if;
			
			if ldcomp = '1' then
				data2Comp_r <= data2;
			end if;
			
			if ld = '1' then
				counter <= muxOut;
			else
				counter <= std_logic_vector(unsigned(counter) + 1);
			end if;
		end if;
	end process;
	
	data0 <=	counter;
END fpga;
