LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY and1 IS
PORT (a, b : IN STD_LOGIC_VECTOR(31 downto 0);
s : OUT STD_LOGIC_VECTOR(31 downto 0));
END and1 ;

ARCHITECTURE comportamento OF and1 IS

BEGIN

s(0) <= a(0) and b(0);
s(1) <= a(1) and b(1);
s(2) <= a(2) and b(2);
s(3) <= a(3) and b(3);
s(4) <= a(4) and b(4);
s(5) <= a(5) and b(5);
s(6) <= a(6) and b(6);
s(7) <= a(7) and b(7);
s(8) <= a(8) and b(8);
s(9) <= a(9) and b(9);
s(10) <= a(10) and b(10);
s(11) <= a(11) and b(11);
s(12) <= a(12) and b(12);
s(13) <= a(13) and b(13);
s(14) <= a(14) and b(14);
s(15) <= a(15) and b(15);
s(16) <= a(16) and b(16);
s(17) <= a(17) and b(17);
s(18) <= a(18) and b(18);
s(19) <= a(19) and b(19);
s(20) <= a(20) and b(20);
s(21) <= a(21) and b(21);
s(22) <= a(22) and b(22);
s(23) <= a(23) and b(23);
s(24) <= a(24) and b(24);
s(25) <= a(25) and b(25);
s(26) <= a(26) and b(26);
s(27) <= a(27) and b(27);
s(28) <= a(28) and b(28);
s(29) <= a(29) and b(29);
s(30) <= a(30) and b(30);
s(31) <= a(31) and b(31);

END comportamento;