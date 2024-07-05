LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE work.Utilities.ALL;

ENTITY decoder2to4Behave IS
	PORT (
		input : in STD_LOGIC_VECTOR(1 downto 0);
		
		output : out STD_LOGIC_VECTOR(3 downto 0)
	);
END decoder2to4Behave;

ARCHITECTURE fpga OF decoder2to4Behave IS
BEGIN
	process(input)
	begin
		if metaValueDetector(input) then
			output <= (others => '0');
			output(toint(input)) <= '1';
		else
			output <= (others => 'U');
		end if;
		
	end process;
END fpga;
