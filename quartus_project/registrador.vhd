LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.ALL;


entity registrador is
generic (N : integer:= 32);
	PORT (
			clk,load : in std_logic;
			D : in std_logic_vector (N-1 downto 0);
			Q : out std_logic_vector(N-1 downto 0)
			);
END registrador;

architecture comportamento of registrador is
begin
	process (clk)
	begin
		if (rising_edge(clk)) then
			if (load = '1') then
				Q <= D;
			end if;
		end if;
	end process;
end comportamento;