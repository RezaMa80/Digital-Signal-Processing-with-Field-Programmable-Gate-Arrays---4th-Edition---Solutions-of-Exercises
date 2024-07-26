LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
LIBRARY lpm;
USE lpm.lpm_components.ALL;
LIBRARY work;
USE work.ram_constants.ALL;

ENTITY ram256x8 IS
   PORT(
      data: IN STD_LOGIC_VECTOR (DATA_WIDTH-1 DOWNTO 0);
      address: IN STD_LOGIC_VECTOR (ADDR_WIDTH-1 DOWNTO 0);
      we, inclock, outclock: IN STD_LOGIC;
      q: OUT STD_LOGIC_VECTOR (DATA_WIDTH - 1 DOWNTO 0));
END ram256x8;

ARCHITECTURE example OF ram256x8 IS

BEGIN
   inst_1: lpm_ram_dq
      GENERIC MAP (lpm_widthad => ADDR_WIDTH,
         lpm_width => DATA_WIDTH)
      PORT MAP (data => data, address => address, we => we,
         inclock => inclock, outclock => outclock, q => q);
END example;