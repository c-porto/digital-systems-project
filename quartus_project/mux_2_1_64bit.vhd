LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

entity mux_2_1_64bit is
generic (N : integer := 64);
     port (
             A: in std_logic_vector(N - 1 downto 0);
				 B: in std_logic_vector(N - 1 downto 0);
             sel : in std_logic;
            y : out std_logic_vector(N - 1 downto 0)
           );
end mux_2_1_64bit;

architecture arch of mux_2_1_64bit is
begin
    with sel select
        y <= A when '0',
            B when '1';       
 end arch;
