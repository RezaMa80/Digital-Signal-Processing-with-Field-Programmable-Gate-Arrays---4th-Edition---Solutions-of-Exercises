LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY PREPBenchmark1 IS
	PORT (
		clk :  IN STD_LOGIC;
		rst :  IN STD_LOGIC;
		
		idp : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		id  :  IN STD_LOGIC_VECTOR(23 DOWNTO 0);
		s   :  IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		sl   :  IN STD_LOGIC;
		
		q :  OUT STD_LOGIC_VECTOR(7 DOWNTO 0) := (others => 'X')
	);
END PREPBenchmark1;

ARCHITECTURE fpga OF PREPBenchmark1 IS
	signal muxOut : std_logic_vector(7 downto 0);
	signal muxOut_r : std_logic_vector(7 downto 0);
	signal shiftReg : std_logic_vector(7 downto 0);
BEGIN
	q <= shiftReg;
	
	muxOut <= 	idp 					when s = "00" else
					id(7 downto 0) 	when s = "01" else
					id(15 downto 8) 	when s = "10" else
					id(23 downto 16) 	when s = "11" else
					(others => 'X');
			
	process (rst, clk) is
	begin
		if (rst = '0') then
			muxOut_r <= (others => '0');
			shiftReg <= (others => '0');
		elsif (rising_edge(clk)) then
			muxOut_r <= muxOut;
			
			if (sl = '1') then
				shiftReg <=  shiftReg(shiftReg'LEFT-1 downto shiftReg'RIGHT) & shiftReg(shiftReg'LEFT);
			else
				shiftReg <=  muxOut_r;
			end if;
		end if;
	end process;
END fpga;
