LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY IORegisteredAdder IS
	GENERIC (
		WIDTH : positive := 32
	);
	PORT (
		clk   :  IN STD_LOGIC;
		a, b  : IN STD_LOGIC_VECTOR(WIDTH-1 DOWNTO 0);
		sum   :  OUT STD_LOGIC_VECTOR(WIDTH-1 DOWNTO 0)
	);
END IORegisteredAdder;

ARCHITECTURE fpga OF IORegisteredAdder IS
	signal a_r, b_r : STD_LOGIC_VECTOR(WIDTH-1 DOWNTO 0);
	signal sum_r : STD_LOGIC_VECTOR(WIDTH DOWNTO 0);
BEGIN
	sum <= sum_r(WIDTH-1 downto 0);
	
	process (clk)
		variable a_r_resizedL1
	begin
		if (rising_edge(clk)) then
			a_r <= a;
			b_r <= b;
			
			sum_r <= 
				std_logic_vector(
					resize(unsigned(a_r), a_r'LENGTH+1) + 
					unsigned(b_r)
				);
		end if;
	end process;
END fpga;
