library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

ENTITY counters IS

   PORT
   (
      d         : IN    INTEGER RANGE 0 TO 255;
      clk       : IN  STD_LOGIC;
      clear     : IN  STD_LOGIC;
      ld        : IN  STD_LOGIC;
      enable    : IN  STD_LOGIC;
      up_down   : IN  STD_LOGIC;
      qa        : OUT INTEGER RANGE 0 TO 255;
      qb        : OUT INTEGER RANGE 0 TO 255;
      qc        : OUT INTEGER RANGE 0 TO 255;
      qd        : OUT INTEGER RANGE 0 TO 255;
      qe        : OUT INTEGER RANGE 0 TO 255;
      qf        : OUT INTEGER RANGE 0 TO 255;
      qg        : OUT INTEGER RANGE 0 TO 255;
      qh        : OUT INTEGER RANGE 0 TO 255;
      qi        : OUT INTEGER RANGE 0 TO 255;
      qj        : OUT INTEGER RANGE 0 TO 255;
      qk        : OUT INTEGER RANGE 0 TO 255;
      ql        : OUT INTEGER RANGE 0 TO 255;
      qm        : OUT INTEGER RANGE 0 TO 255;
      qn        : OUT INTEGER RANGE 0 TO 255
   );
   
END counters;

ARCHITECTURE a OF counters IS
BEGIN
   -- An enable counter
   PROCESS (clk)
      VARIABLE   cnt         : INTEGER RANGE 0 TO 255;
   BEGIN
      IF (clk'EVENT AND clk = '1') THEN
         IF enable = '1' THEN
            cnt := cnt + 1;
         END IF;
      END IF;
      
      qa <= cnt;

   END PROCESS;

   -- A synchronous load counter
   PROCESS (clk)
      VARIABLE   cnt         : INTEGER RANGE 0 TO 255;
   BEGIN
      IF (clk'EVENT AND clk = '1') THEN
         IF ld = '0' THEN
            cnt := d;
         ELSE
            cnt := cnt + 1;
         END IF;
      END IF;

      qb <= cnt;

   END PROCESS;

   -- A synchronous clear counter
   PROCESS (clk)
      VARIABLE   cnt         : INTEGER RANGE 0 TO 255;
   BEGIN
      IF (clk'EVENT AND clk = '1') THEN
         IF clear = '0' THEN
            cnt := 0;
         ELSE
            cnt := cnt + 1;
         END IF;
      END IF;

      qc <= cnt;
   
   END PROCESS;

   -- An up/down counter
   PROCESS (clk)
      VARIABLE   cnt         : INTEGER RANGE 0 TO 255;
      VARIABLE   direction    : INTEGER;
   BEGIN
      IF (up_down = '1') THEN
         direction := 1;
      ELSE
         direction := -1;
      END IF;
      
      IF (clk'EVENT AND clk = '1') THEN
         cnt := cnt + direction;
      END IF;

      qd <= cnt;
   
   END PROCESS;

   -- A synchronous load enable counter
   PROCESS (clk)
      VARIABLE   cnt         : INTEGER RANGE 0 TO 255;
   BEGIN
      IF (clk'EVENT AND clk = '1') THEN
         IF ld = '0' THEN
            cnt := d;
         ELSE
            IF enable = '1' THEN
               cnt := cnt + 1;
            END IF;
         END IF;
      END IF;

      qe <= cnt;
   
   END PROCESS;

   -- An enable up/down counter
   PROCESS (clk)
      VARIABLE   cnt                                  : INTEGER RANGE 0 TO 255;
      VARIABLE   direction    : INTEGER;
   BEGIN
      IF (up_down = '1') THEN
         direction := 1;
      ELSE
         direction := -1;
      END IF;
      
      IF (clk'EVENT AND clk = '1') THEN
         IF enable = '1' THEN
            cnt := cnt + direction;
         END IF;
      END IF;

      qf <= cnt;
   
   END PROCESS;

   -- A synchronous clear enable counter
   PROCESS (clk)
      VARIABLE   cnt         : INTEGER RANGE 0 TO 255;
   BEGIN
      IF (clk'EVENT AND clk = '1') THEN
         IF clear = '0' THEN
            cnt := 0;
         ELSE
            IF enable = '1' THEN
               cnt := cnt + 1;
            END IF;
         END IF;
      END IF;

      qg <= cnt;
   
   END PROCESS;

   -- A synchronous load clear counter
   PROCESS (clk)
      VARIABLE   cnt         : INTEGER RANGE 0 TO 255;
   BEGIN
      IF (clk'EVENT AND clk = '1') THEN
         IF clear = '0' THEN
            cnt := 0;
         ELSE
            IF ld = '0' THEN
               cnt := d;
            ELSE
               cnt := cnt + 1;
            END IF;
         END IF;
      END IF;

      qh <= cnt;
   
   END PROCESS;

   -- A synchronous load up/down counter
   PROCESS (clk)
      VARIABLE   cnt         : INTEGER RANGE 0 TO 255;
      VARIABLE   direction    : INTEGER;
   BEGIN
      IF (up_down = '1') THEN
         direction := 1;
      ELSE
         direction := -1;
      END IF;
      
      IF (clk'EVENT AND clk = '1') THEN
         IF ld = '0' THEN
            cnt := d;
         ELSE
            cnt := cnt + direction;
         END IF;
      END IF;

      qi <= cnt;
   
   END PROCESS;

   -- A synchronous load enable up/down counter
   PROCESS (clk)
      VARIABLE   cnt          : INTEGER RANGE 0 TO 255;
      VARIABLE   direction    : INTEGER;
   BEGIN
      IF (up_down = '1') THEN
         direction := 1;
      ELSE
         direction := -1;
      END IF;
      
      IF (clk'EVENT AND clk = '1') THEN
         IF ld = '0' THEN
            cnt := d;
         ELSE
            IF enable = '1' THEN
               cnt := cnt + direction;
            END IF;
         END IF;
      END IF;

      qj <= cnt;

   END PROCESS;

   -- A synchronous clear load enable counter
   PROCESS (clk)
      VARIABLE   cnt         : INTEGER RANGE 0 TO 255;
   BEGIN
      IF (clk'EVENT AND clk = '1') THEN
         IF clear = '0' THEN
            cnt := 0;
         ELSE
            IF ld = '0' THEN
               cnt := d;
            ELSE
               IF enable = '1' THEN
                  cnt := cnt + 1;
               END IF;
            END IF;
         END IF;
      END IF;
      
      qk <= cnt;
   
   END PROCESS;

   -- A synchronous clear up/down counter
   PROCESS (clk)
      VARIABLE   cnt          : INTEGER RANGE 0 TO 255;
      VARIABLE   direction    : INTEGER;
   BEGIN
      IF (up_down = '1') THEN
         direction := 1;
      ELSE
         direction := -1;
      END IF;
      
      IF (clk'EVENT AND clk = '1') THEN
         IF clear = '0' THEN
            cnt := 0;
         ELSE
            cnt := cnt + direction;
         END IF;
      END IF;

      ql <= cnt;
   
   END PROCESS;

   -- A synchronous clear enable up/down counter
   PROCESS (clk)
      VARIABLE   cnt          : INTEGER RANGE 0 TO 255;
      VARIABLE   direction    : INTEGER;
   BEGIN
      IF (up_down = '1') THEN
         direction := 1;
      ELSE
         direction := -1;
      END IF;
      
      IF (clk'EVENT AND clk = '1') THEN
         IF clear = '0' THEN
            cnt := 0;
         ELSE
            IF enable = '1' THEN
               cnt := cnt + direction;
            END IF;
         END IF;
      END IF;

      qm <= cnt;
   
   END PROCESS;

   -- A modulus 200 up counter
   PROCESS (clk)
      VARIABLE   cnt        : INTEGER RANGE 0 TO 255;
      CONSTANT modulus      : INTEGER := 200;
   BEGIN
      IF (clk'EVENT AND clk = '1') THEN
         IF cnt = modulus THEN
            cnt := 0;
         ELSE
            cnt := cnt + 1;
         END IF;
      END IF;

      qn <= cnt;
   
   END PROCESS;
END a;