LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY or1 IS
PORT (a, b : IN STD_LOGIC_VECTOR(31 downto 0);
s : OUT STD_LOGIC_VECTOR(31 downto 0));
END or1 ;

ARCHITECTURE comportamento OF and1 IS

BEGIN

s(0) <= a(0) or b(0);
s(1) <= a(1) or b(1);
s(2) <= a(2) or b(2);
s(3) <= a(3) or b(3);
s(4) <= a(4) or b(4);
s(5) <= a(5) or b(5);
s(6) <= a(6) or b(6);
s(7) <= a(7) or b(7);
s(8) <= a(8) or b(8);
s(9) <= a(9) or b(9);
s(10) <= a(10) or b(10);
s(11) <= a(11) or b(11);
s(12) <= a(12) or b(12);
s(13) <= a(13) or b(13);
s(14) <= a(14) or b(14);
s(15) <= a(15) or b(15);
s(16) <= a(16) or b(16);
s(17) <= a(17) or b(17);
s(18) <= a(18) or b(18);
s(19) <= a(19) or b(19);
s(20) <= a(20) or b(20);
s(21) <= a(21) or b(21);
s(22) <= a(22) or b(22);
s(23) <= a(23) or b(23);
s(24) <= a(24) or b(24);
s(25) <= a(25) or b(25);
s(26) <= a(26) or b(26);
s(27) <= a(27) or b(27);
s(28) <= a(28) or b(28);
s(29) <= a(29) or b(29);
s(30) <= a(30) or b(30);
s(31) <= a(31) or b(31);

END comportamento;