LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.ALL;


entity reg_carry is
	PORT (
			clk,load : in std_logic;
			D : in std_logic;
			Q : out std_logic
			);
END reg_carry;

architecture comportamento of reg_carry is
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