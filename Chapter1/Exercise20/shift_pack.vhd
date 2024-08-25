library ieee;
USE ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;

package shift_pack is
	function "sll" (
		ARG : std_logic_vector;
		COUNT : integer
	) return std_logic_vector;
	
	function "srl" (
		ARG : std_logic_vector;
		COUNT : integer
	) return std_logic_vector;
	
	function ShiftLeftArithmatic (
		ARG : std_logic_vector;
		COUNT : natural
	) return std_logic_vector;
	
	function "sla" (
		ARG : std_logic_vector;
		COUNT : integer
	) return std_logic_vector;
	
	function "sra" (
		ARG : std_logic_vector;
		COUNT : integer
	) return std_logic_vector;
end shift_pack;

package body shift_pack is
	function ShiftLeftArithmatic (
		ARG : std_logic_vector;
		COUNT : natural
	) return std_logic_vector is
		variable result : std_logic_vector(ARG'RANGE);
	begin
		result := (others => ARG(ARG'RIGHT));
		result(ARG'LEFT downto ARG'RIGHT+COUNT) := ARG(ARG'LEFT-COUNT downto ARG'RIGHT);
		
		return result;
	end ShiftLeftArithmatic;
	
	function "sla" (
		ARG : std_logic_vector;
		COUNT : integer
	) return std_logic_vector is
		variable result : std_logic_vector(ARG'RANGE);
	begin
		if count >= 0 then
			result := ShiftLeftArithmatic(ARG, COUNT);
		else
			result := std_logic_vector(SHIFT_RIGHT(signed(ARG), -COUNT));
		end if;
		
		return result;
	end "sla";
	
	function "sra" (
		ARG : std_logic_vector;
		COUNT : integer
	) return std_logic_vector is
		variable result : std_logic_vector(ARG'RANGE);
	begin
		if count >= 0 then 
			result := std_logic_vector(SHIFT_RIGHT(signed(ARG), COUNT));
		else
			result := ShiftLeftArithmatic(ARG, -COUNT);
		end if;
		
		return result;
	end "sra";
	
	function "sll" (
		ARG : std_logic_vector;
		COUNT : integer
	) return std_logic_vector is
	begin
		return std_logic_vector(unsigned(ARG) sll COUNT);
	end "sll";
	
	function "srl" (
		ARG : std_logic_vector;
		COUNT : integer
	) return std_logic_vector is
	begin
		return std_logic_vector(unsigned(ARG) srl COUNT);
	end "srl";
end shift_pack;
