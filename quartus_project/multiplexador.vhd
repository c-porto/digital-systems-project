LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

entity multiplexador is

     port (
             A: in std_logic;
             sel : in std_logic;
            y : out std_logic
           );
end multiplexador;

architecture arch of multiplexador is
begin
    with sel select
        y <= A when '0',
            '0' when others;       
 end arch;
