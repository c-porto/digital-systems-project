LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

entity mux_2_1_6bit is
generic (N : integer := 6);
     port (
            A: in std_logic_vector(N - 1 downto 0);
            sel : in std_logic;
            y : out std_logic_vector (N - 1 downto 0)
           );
end mux_2_1_6bit;

architecture arch of mux_2_1_6bit is
signal full: std_logic_vector (N - 1 downto 0) := "100000";
begin
    with sel select
        y <= A when '1',
            full when '0';       
 end arch;
