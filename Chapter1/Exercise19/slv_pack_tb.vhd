library ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_signed.ALL;

library work;
use work.slv_pack.ALL;

entity slv_pack_tb is
	port (
		a : in std_logic_vector(7 downto 0);
		zlong, slong : out std_logic_vector(31 downto 0);
		zshort, sshort : out std_logic_vector(15 downto 0);
		a2, a6, aDIV2, aDIV4, a3DIV4 : out std_logic_vector(7 downto 0)
	);
end slv_pack_tb;
architecture fpga of slv_pack_tb is
begin
	zlong <= ZERO_EXT(a, 32);
	zshort <= ZERO_EXT(a, 16);
	
	slong <= SIGN_EXT(a, 32);
	sshort <= SIGN_EXT(a, 16);
	
	a2 <= a * 2;
	a6 <= a * 2 + a * 4;
	aDIV2 <= a / 2;
	
	aDIV4 <= a / 4;
	a3DIV4 <= a / 2 + a / 4;
end;