LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY enumsmch IS
   PORT 
   (
      updown    : IN STD_LOGIC;
      clock     : IN STD_LOGIC;
      lsb       : OUT STD_LOGIC;
      msb       : OUT STD_LOGIC
   );
END enumsmch;

ARCHITECTURE firstenumsmch OF enumsmch IS
   TYPE count_state is (zero, one, two, three);
   ATTRIBUTE ENUM_ENCODING                : STRING;
   ATTRIBUTE ENUM_ENCODING OF count_state : TYPE IS "11 01 10 00";
   SIGNAL present_state, next_state       : count_state;
BEGIN

   PROCESS (present_state, updown)
   BEGIN
      CASE present_state IS
         WHEN zero =>
            IF (updown = '0') THEN
               next_state <= one;
               lsb <= '0';
               msb <= '0';
            ELSE
               next_state <= three;
               lsb <= '1';
               msb <= '1';
            END IF;
         WHEN one =>
            IF (updown = '0') THEN
               next_state <= two;
               lsb <= '1';
               msb <= '0';
            ELSE
               next_state <= zero;
               lsb <= '0';
               msb <= '0';
            END IF;
         WHEN two =>
            IF (updown = '0') THEN
               next_state <= three;
               lsb <= '0';
               msb <= '1';
            ELSE
               next_state <= one;
               lsb <= '1';
               msb <= '0';
            END IF;
         WHEN three =>
            IF (updown = '0') THEN
               next_state <= zero;
               lsb <= '1';
               msb <= '1';
            ELSE
               next_state <= two;
               lsb <= '0';
               msb <= '1';
            END IF;
      END CASE;
   END PROCESS;
   
   PROCESS
   BEGIN
      WAIT UNTIL clock'EVENT and clock = '1';
      present_state <= next_state;
   END PROCESS;
   
END firstenumsmch;