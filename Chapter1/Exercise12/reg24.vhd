LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
LIBRARY work;
USE work.reg24_package.ALL;

ENTITY reg24 IS
   PORT(
      d      : IN  STD_LOGIC_VECTOR(23 DOWNTO 0);
      clk    : IN  STD_LOGIC;
      q      : OUT STD_LOGIC_VECTOR(23 DOWNTO 0));
END reg24;

ARCHITECTURE a OF reg24 IS
BEGIN
   reg12a   : reg12 PORT MAP (d => d(11 DOWNTO 0), clk => clk, 
           q => q(11 DOWNTO 0));
   reg12b   : reg12 PORT MAP (d => d(23 DOWNTO 12), clk => clk, 
           q => q(23 DOWNTO 12));
END a;