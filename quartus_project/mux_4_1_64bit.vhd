LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

entity mux_4_1_64bit is
generic (N : integer := 64);
     port (
             A: in std_logic_vector(N - 1 downto 0);
				 B: in std_logic_vector(N - 1 downto 0);
             sel : in std_logic_vector(1 downto 0);
             y : out std_logic_vector (N - 1 downto 0)
           );
end mux_4_1_64bit;

architecture arch of mux_4_1_64bit is
signal zero: std_logic_vector (N - 1 downto 0) := (others => '0');
signal saida: std_logic_vector (N - 1 downto 0);
begin
		saida <= A when sel = "00" else
				   B when sel = "01" else
				   zero;
		  
			y <= saida;
 end arch;
