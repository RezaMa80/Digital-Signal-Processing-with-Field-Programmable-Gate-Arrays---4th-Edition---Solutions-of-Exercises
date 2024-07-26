LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY proc IS
   PORT
   (
      d     : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
      q     : OUT INTEGER RANGE 0 TO 3
   );
END proc;

ARCHITECTURE maxpld OF proc IS
BEGIN

   PROCESS (d)   -- count the number of set bits with the value 1 in word d
      VARIABLE num_bits : INTEGER;
   BEGIN
      num_bits := 0;
 
      FOR i IN d'RANGE LOOP
         IF d(i) = '1' THEN
            num_bits := num_bits + 1;
         END IF;
      END LOOP;
  
      q <= num_bits;
   END PROCESS;

END maxpld;