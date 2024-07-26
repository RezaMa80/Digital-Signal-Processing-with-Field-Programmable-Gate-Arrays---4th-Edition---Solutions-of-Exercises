LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY latchinf IS
   PORT
   (
      enable, data    : IN STD_LOGIC;
      q               : OUT STD_LOGIC
   );
END latchinf;

ARCHITECTURE maxpld OF latchinf IS
BEGIN

latch :	PROCESS (enable, data)
      BEGIN
         IF (enable = '1') THEN
            q <= data;
         END IF;
      END PROCESS latch;

END maxpld;