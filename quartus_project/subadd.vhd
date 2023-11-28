LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
use ieee.std_logic_unsigned.all;

entity subadd is
generic ( N : INTEGER := 64 );
	port (
			add1 : in std_logic_vector(N - 1 downto 0);
			add2 : in std_logic_vector(N - 1 downto 0);
			op: in std_logic;
			sumsub : out std_logic_vector(N - 1 downto 0)
			);
end subadd;

architecture rtl of subadd is
signal sum: std_logic_vector(N - 1 downto 0);
signal sub: std_logic_vector(N - 1 downto 0);

begin
	sum <= add1 + add2;
	sub <= add1 - add2;
	WITH op SELECT
		sumsub <= sum WHEN '0',
					 sub WHEN OTHERS;	
END rtl;