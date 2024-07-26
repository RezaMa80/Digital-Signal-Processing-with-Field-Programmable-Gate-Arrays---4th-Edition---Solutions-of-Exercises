LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

PACKAGE reg24_package IS
   COMPONENT reg12
      PORT(
         d      : IN   STD_LOGIC_VECTOR(11 DOWNTO 0);
         clk    : IN   STD_LOGIC;
         q      : OUT   STD_LOGIC_VECTOR(11 DOWNTO 0));
   END COMPONENT;
END reg24_package;