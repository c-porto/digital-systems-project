LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

entity multiplexador is
generic (N : integer := 1);
     port (
             A: in unsigned(N - 1 downto 0);
             sel : in std_logic;
            y : out unsigned (N - 1 downto 0)
           );
end multiplexador;

architecture arch of multiplexador is
signal zero: unsigned (N - 1 downto 0) := (others => '0');
begin
    with sel select
        y <= A when '0',
            zero when others;       
 end arch;
