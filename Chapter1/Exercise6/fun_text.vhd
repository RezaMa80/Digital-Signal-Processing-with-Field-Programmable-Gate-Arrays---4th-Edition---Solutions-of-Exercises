--  A 32 bit function generator using accumulator and ROM
LIBRARY ieee;
USE ieee.STD_LOGIC_1164.ALL;
USE ieee.STD_LOGIC_arith.ALL;
USE ieee.STD_LOGIC_signed.ALL;
LIBRARY lpm;
USE lpm.lpm_components.all;

-- --------------------------------------------------------
ENTITY fun_text IS
  GENERIC ( WIDTH   : INTEGER := 32);    -- Bit width
  PORT (clk   : IN  STD_LOGIC; -- System clock
        reset : IN  STD_LOGIC; -- Asynchronous reset
        M     : IN  STD_LOGIC_VECTOR(WIDTH-1 DOWNTO 0);
                                   -- Accumulator increment
        acc   : OUT STD_LOGIC_VECTOR(7 DOWNTO 0); 
                                        -- Accumulator MSBs
        sin   : OUT STD_LOGIC_VECTOR(7 DOWNTO 0));
END fun_text;                         -- System sine output
-- --------------------------------------------------------
ARCHITECTURE fpga OF fun_text IS

	COMPONENT lpm_rom
		GENERIC (
			LPM_WIDTH: POSITIVE;
			LPM_WIDTHAD: POSITIVE;
			LPM_NUMWORDS: NATURAL := 0;
			LPM_ADDRESS_CONTROL: STRING := "UNREGISTERED";
			LPM_OUTDATA: STRING := "REGISTERED";
			LPM_FILE: STRING;
			LPM_TYPE: STRING := "LPM_ROM";
			LPM_HINT: STRING := "UNUSED"
		);
		PORT (
			address: IN STD_LOGIC_VECTOR(LPM_WIDTHAD-1 DOWNTO 0);
			inclock, outclock: IN STD_LOGIC := '0';
			memenab: IN STD_LOGIC := '1';
			q: OUT STD_LOGIC_VECTOR(LPM_WIDTH-1 DOWNTO 0)
		);
	END COMPONENT;

  SIGNAL acc32 : STD_LOGIC_VECTOR(WIDTH-1 DOWNTO 0);
  SIGNAL msbs  : STD_LOGIC_VECTOR(7 DOWNTO 0);
                                       -- Auxiliary vectors
BEGIN
   
  PROCESS (reset, clk, acc32)
  BEGIN
    IF reset = '1' THEN
      acc32 <= (OTHERS => '0');
    ELSIF rising_edge(clk) THEN
      acc32 <= acc32 + M; -- Add M to acc32 and 
    END IF;               -- store in register
    
  END PROCESS;
  
  msbs <= acc32(31 DOWNTO 24); -- Select MSBs        
  acc <= msbs;

	-- Instantiate the ROM
	ROM: lpm_rom
	GENERIC MAP (
		LPM_WIDTH => 8,
		LPM_WIDTHAD => 8,
		LPM_NUMWORDS => 256,
		LPM_ADDRESS_CONTROL => "UNREGISTERED",
		LPM_OUTDATA => "REGISTERED",
		LPM_FILE => "sine.hex",
		LPM_TYPE => "LPM_ROM",
		LPM_HINT => "UNUSED"
	)
	PORT MAP (
		address => msbs,
		-- inclock => '0', -- When address is unregistered, it must be unconnected
		outclock => clk,
		memenab => '1',
		q => sin
	);
            
END fpga;
