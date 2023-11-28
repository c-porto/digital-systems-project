library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity bitwise is
generic ( N : INTEGER := 64 );
	port (
			in1 : in std_logic_vector(N - 1 downto 0);
			in2 : in std_logic_vector(N - 1 downto 0);
			op: in std_logic;
			result : out std_logic_vector(N - 1 downto 0)
			);
end bitwise;

architecture rtl of bitwise is
signal and_op: std_logic_vector(N - 1 downto 0);
signal or_op: std_logic_vector(N - 1 downto 0);

begin
	and_op <= in1 and in2;
	or_op <= in1 or in2;
	WITH op SELECT
		result <= and_op WHEN '0',
					 or_op WHEN OTHERS;	
END rtl;