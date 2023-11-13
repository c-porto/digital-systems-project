LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

entity subadd is
generic ( N : INTEGER := 8 );
	port (
			add1 : in unsigned(N - 1 downto 0);
			add2 : in unsigned(N - 1 downto 0);
			op: in std_logic;
			sumsub : out unsigned(N - 1 downto 0)
			);
end subadd;

architecture rtl of subadd is
signal diff: signed(N downto 0);
begin
	diff <= signed('0'&add1) - signed('0'&add2);
	sumsub <= add1 + add2 when op = '0' else
					unsigned(diff(N-1 downto 0));
END rtl;