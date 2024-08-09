library ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

package slv_pack is
	function ZERO_EXT (
		ARG : std_logic_vector;
		SIZE : positive
	) return std_logic_vector;
	
	function SIGN_EXT (
		ARG : std_logic_vector;
		SIZE : positive
	) return std_logic_vector;
	
	function "*" (
		L : std_logic_vector;
		R: integer
	) return std_logic_vector;
	
	function "/" (
		L : std_logic_vector;
		R: natural
	) return std_logic_vector;
end slv_pack;

package body slv_pack is
	function ZERO_EXT(
		ARG : std_logic_vector;
		SIZE : positive
	) return std_logic_vector is
		variable result : std_logic_vector(SIZE-ARG'LENGTH+ARG'LEFT downto ARG'RIGHT);
	begin
		result := (others => '0');
		result(ARG'RANGE) := ARG;
		
		return result;
	end ZERO_EXT;
	
	function SIGN_EXT(
		ARG : std_logic_vector;
		SIZE : positive
	) return std_logic_vector is
		variable result : std_logic_vector(SIZE-ARG'LENGTH+ARG'LEFT downto ARG'RIGHT);
	begin
		result := (others => ARG(ARG'LEFT));
		result(ARG'RANGE) := ARG;
		
		return result;
	end SIGN_EXT;
	
	function "*" (
		L : std_logic_vector;
		R: integer
	) return std_logic_vector is
		variable multiplyResult : std_logic_vector(L'LENGTH+L'LEFT downto L'RIGHT);
		variable result : std_logic_vector(L'RANGE);
	begin
		multiplyResult := std_logic_vector(signed(L)*R);
		result := multiplyResult(L'RANGE);
		
		return result;
	end "*";
	
	function "/" (
		L : std_logic_vector;
		R: natural
	) return std_logic_vector is
		variable divideResult : std_logic_vector(L'RANGE);
		variable result : std_logic_vector(L'RANGE);
	begin
		divideResult := std_logic_vector(unsigned(L)/R);
		
		-- Fill sign bits
		for i in divideResult'RANGE loop
			if divideResult(i) = '1' then
				exit;
			end if;
			divideResult(i) :=  L(L'LEFT);
		end loop;
			
		result := divideResult(L'RANGE);
		
		return result;
	end "/";
end slv_pack;
