LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY reg12 IS
   PORT(
      d      : IN  STD_LOGIC_VECTOR(11 DOWNTO 0);
      clk    : IN  STD_LOGIC;
      q      : OUT STD_LOGIC_VECTOR(11 DOWNTO 0));
END reg12;

ARCHITECTURE a OF reg12 IS
BEGIN
   PROCESS
   BEGIN
      WAIT UNTIL clk = '1';
      q <= d;
   END PROCESS;
END a;