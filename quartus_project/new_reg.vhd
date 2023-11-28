LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.ALL;



entity new_reg is
generic (N : integer:= 32);
	PORT (
			clk,load,shift,Cacc : in std_logic;
			A : in std_logic_vector (N-1 downto 0);
			M : out std_logic_vector (N-1 downto 0);
			Q : out std_logic
			);
END new_reg;

architecture comportamento of new_reg is

signal ent: std_logic_vector(N - 1 downto 0);

begin
	process (clk)
	begin
		if (rising_edge(clk)) then
			if (load = '1') then
			
				ent <= A;
			end if;
			
			if(shift = '1')then
				Q <= ent(0);
				ent <= Cacc & ent(31 downto 1);
			end if;
			
		end if;
	end process;
	M <= ent;
end comportamento;