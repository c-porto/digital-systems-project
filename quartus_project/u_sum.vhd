LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
use ieee.std_logic_unsigned.all;

entity u_sum is
generic ( N : INTEGER := 32 );
	port (
			add1 : in std_logic_vector(N - 1 downto 0);
			add2 : in std_logic_vector(N - 1 downto 0);
			carry: out std_logic;
			sum : out std_logic_vector(N - 1 downto 0)
			);
end u_sum;

architecture rtl of u_sum is
signal partial: unsigned(N downto 0);
begin
	partial <= resize(unsigned(add1), N + 1) + resize(unsigned(add2), N + 1);
	carry <= partial(N);
	sum <= std_logic_vector(partial(N - 1 downto 0));
END rtl;