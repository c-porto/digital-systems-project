LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

entity mux_2_1_32bit_zero is
generic (N : integer := 32);
     port (
             A: in std_logic_vector(N - 1 downto 0);
             sel : in std_logic;
            y : out std_logic_vector(N - 1 downto 0)
           );
end mux_2_1_32bit_zero;

architecture arch of mux_2_1_32bit_zero is
signal zero: std_logic_vector (N - 1 downto 0) := (others => '0');
begin
    with sel select
        y <= A when '0',
            zero when others;       
 end arch;
