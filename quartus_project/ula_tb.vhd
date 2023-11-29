Library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.math_real.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_textio.all;
use std.textio.all;
use ieee.std_logic_unsigned.all;

entity ula_tb is
end ula_tb;

architecture tb of ula_tb is
	
--	testbench signals	
	signal clock: std_logic := '0';
	signal inputA: std_logic_vector(31 downto 0) := "00000000000000000000000000000000" ;
	signal inputB: std_logic_vector(31 downto 0)  := "00000000000000000000000000000000" ;
	signal outputHIGH: std_logic_vector(31 downto 0);
	signal outputLOW: std_logic_vector(31 downto 0);
	signal control: std_logic_vector(3 downto 0) := "0000";
   signal rst: std_logic := '0';
	signal finished: std_logic := '0';	
	signal pronto: std_logic;
	signal iniciar: std_logic := '0';
	signal saidaA: std_logic_vector(31 downto 0);
	signal saidaB: std_logic_vector(31 downto 0);
	signal saidaS: std_logic_vector(63 downto 0);
	signal saidaM: std_logic_vector(31 downto 0);
	signal saidaQ: std_logic_vector(31 downto 0);
	
-- ULA signals
--	signal controle: std_logic_vector(3 downto 0);
--	signal IN_1, IN_2, SL, SH: std_logic_vector(31 downto 0);
--	signal clk, rst, iniciar, pronto: std_logic := '0';
	
	CONSTANT period : TIME := 100 ns;
	
	begin

--connect DUV
		DUV: entity work.ula_mips
			port map(controle => control,
						IN_1     => inputA,
						IN_2     => inputB,
						SL		   => outputLOW,
						SH       => outputHIGH,
						clk      => clock,
						rst      => rst,
						iniciar  => iniciar,
						pronto   => pronto,
						saidaA	=> saidaA,
						saidaB	=> saidaB,
						saidaS	=> saidaS,
						saidaM	=> saidaM,
						saidaQ	=> saidaQ
						);

		clock <= not clock after period/2 when finished /= '1' else '0';
	
		process
		begin
		
--	teste se o reset está funcionando		
			rst <= '1'; iniciar <= '0';
			wait for 1 us;
			assert(pronto='1')
			report "Reset test error" severity error;
			
------------------------------------------------------------------------------------------------------------------------------			
------------------------------------------------------------------------------------------------------------------------------			
			
--	teste se o iniciar está funcionando
			rst <= '0'; iniciar <= '1';
			wait for 1 us;
			assert(pronto='0')
			report "Iniciate test error" severity error;
			
			rst <= '1'; iniciar <= '0';
			wait for period;

------------------------------------------------------------------------------------------------------------------------------			
------------------------------------------------------------------------------------------------------------------------------
	
--	teste se a SOMA está funcionando
			rst <= '0'; iniciar <= '1';
			inputA <= std_logic_vector(to_unsigned(2147483646, inputA'length));
			inputB <= std_logic_vector(to_unsigned(0000000000, inputB'length));
			control <= "0010";
			wait until pronto = '1';
			wait for 10	us;
			assert outputHIGH="00000000000000000000000000000000"
			report "Sum 1 HIGH error" severity error;
			assert outputLOW="01111111111111111111111111111110"
			report "Sum 1 LOW error" severity error;
			
-- novos valores
			inputA <= std_logic_vector(to_unsigned(0, inputA'length));
			inputB <= std_logic_vector(to_unsigned(0, inputB'length));			
			rst <= '1'; iniciar <= '0';
			wait for period;
			
			
------------------------------------------------------------------------------------------------------------------------------			
------------------------------------------------------------------------------------------------------------------------------						
			
			
--	teste se a SUBTRAÇÃO está funcionando
			rst <= '0'; iniciar <= '1';
			inputA <= std_logic_vector(to_unsigned(2147483646, inputA'length));
			inputB <= std_logic_vector(to_unsigned(0, inputB'length));
			control <= "0110";
			wait for 10 us;
			assert((outputHIGH="00000000000000000000000000000000") and (outputLOW="11111111111111111111111111111110"))
			report "Sub 1 error" severity error;
			
-- novos valores
			inputA <= std_logic_vector(to_unsigned(0, inputA'length));
			inputB <= std_logic_vector(to_unsigned(0, inputB'length));			
			rst <= '1'; iniciar <= '0';
			wait for period;
			
--	teste se a SUBTRAÇÃO está funcionando
			rst <= '0'; iniciar <= '1';
			inputA <= std_logic_vector(to_unsigned(2147483646, inputA'length));
			inputB <= std_logic_vector(to_unsigned(2147483646, inputB'length));
			control <= "0110";
			wait for 10 us;
			assert((outputHIGH="00000000000000000000000000000000") and (outputLOW="00000000000000000000000000000000"))
			report "Sub 2 error" severity error;

-- novos valores
			inputA <= std_logic_vector(to_unsigned(0, inputA'length));
			inputB <= std_logic_vector(to_unsigned(0, inputB'length));			
			rst <= '1'; iniciar <= '0';
			wait for period;
			
--	teste se a SUBTRAÇÃO está funcionando
			rst <= '0'; iniciar <= '1';
			inputA <= std_logic_vector(to_unsigned(0, inputA'length));
			inputB <= std_logic_vector(to_unsigned(0, inputB'length));
			control <= "0110";
			wait for 10 us;
			assert((outputHIGH="00000000000000000000000000000000") and (outputLOW="00000000000000000000000000000000"))
			report "Sub 3 error" severity error;

-- novos valores
			inputA <= std_logic_vector(to_unsigned(0, inputA'length));
			inputB <= std_logic_vector(to_unsigned(0, inputB'length));			
			rst <= '1'; iniciar <= '0';
			wait for period;
			
--	teste se a SUBTRAÇÃO está funcionando
			rst <= '0'; iniciar <= '1';
			inputA <= std_logic_vector(to_unsigned(2147483647, inputA'length));
			inputB <= std_logic_vector(to_unsigned(1234567891, inputB'length));
			control <= "0110";
			wait for 10 us;
			assert((outputHIGH="00000000000000000000000000000000") and (outputLOW="10110110011010011111110100101100"))
			report "Sub 4 error" severity error;

			inputA <= std_logic_vector(to_unsigned(0, inputA'length));
			inputB <= std_logic_vector(to_unsigned(0, inputB'length));			
			rst <= '1'; iniciar <= '0';
			wait for period;
			
			
			
------------------------------------------------------------------------------------------------------------------------------			
------------------------------------------------------------------------------------------------------------------------------			
			
			
			
--	teste se o OR BIT A BIT está funcionando
			rst <= '0'; iniciar <= '1';
			inputA <= "00000000000000000000000000000000";
			inputB <= "10101010101010101010101010101010";
			control <= "0001";
			wait for 10 us;
			assert((outputHIGH="00000000000000000000000000000000") and (outputLOW="10101010101010101010101010101010"))
			report "TESTE 1 OR BIT A BIT" severity error;
			
-- novos valores			
			inputA <= std_logic_vector(to_unsigned(0, inputA'length));
			inputB <= std_logic_vector(to_unsigned(0, inputB'length));
			rst <= '1'; iniciar <= '0';
			wait for period;
			
			
--	teste se o OR BIT A BIT está funcionando
			rst <= '0'; iniciar <= '1';
			inputA <= "01010101010101010101010101010101";
			inputB <= "10101010101010101010101010101010";
			control <= "0001";
			wait for 10 us;
			assert((outputHIGH="00000000000000000000000000000000") and (outputLOW="11111111111111111111111111111111"))
			report "TESTE 2 OR BIT A BIT" severity error;
			
-- novos valores			
			inputA <= std_logic_vector(to_unsigned(0, inputA'length));
			inputB <= std_logic_vector(to_unsigned(0, inputB'length));
			rst <= '1'; iniciar <= '0';
			wait for period;
			
--	teste se o OR BIT A BIT está funcionando
			rst <= '0'; iniciar <= '1';
			inputA <= "11100011100011100011100011100011";
			inputB <= "11001100110011001100110011001100";
			control <= "0001";
			wait for 10 us;
			assert((outputHIGH="00000000000000000000000000000000") and (outputLOW="11101111110011101111110011101111"))
			report "TESTE 3 OR BIT A BIT" severity error;
			
-- novos valores			
			inputA <= std_logic_vector(to_unsigned(0, inputA'length));
			inputB <= std_logic_vector(to_unsigned(0, inputB'length));
			rst <= '1'; iniciar <= '0';
			wait for period;
			
			
------------------------------------------------------------------------------------------------------------------------------			
------------------------------------------------------------------------------------------------------------------------------
			
			
--	teste se o AND BIT A BIT está funcionando
			rst <= '0'; iniciar <= '1';
			inputA <= "00000000000000000000000000000000";
			inputB <= "10101010101010101010101010101010";
			control <= "0000";
			wait for 10 us;
			assert((outputHIGH="00000000000000000000000000000000") and (outputLOW="00000000000000000000000000000000"))
			report "TESTE 1 AND BIT A BIT" severity error;
			
-- novos valores			
			inputA <= std_logic_vector(to_unsigned(0, inputA'length));
			inputB <= std_logic_vector(to_unsigned(0, inputB'length));
			rst <= '1'; iniciar <= '0';
			wait for period;
			
			
--	teste se o AND BIT A BIT está funcionando
			rst <= '0'; iniciar <= '1';
			inputA <= "01010101010101010101010101010101";
			inputB <= "10101010101010101010101010101010";
			control <= "0000";
			wait for 10 us;
			assert((outputHIGH="00000000000000000000000000000000") and (outputLOW="00000000000000000000000000000000"))
			report "TESTE 2 AND BIT A BIT" severity error;
			
-- novos valores			
			inputA <= std_logic_vector(to_unsigned(0, inputA'length));
			inputB <= std_logic_vector(to_unsigned(0, inputB'length));
			rst <= '1'; iniciar <= '0';
			wait for period;
			
--	teste se o AND BIT A BIT está funcionando
			rst <= '0'; iniciar <= '1';
			inputA <= "11100011100011100011100011100011";
			inputB <= "11001100110011001100110011001100";
			control <= "0000";
			wait for 10 us;
			assert((outputHIGH="00000000000000000000000000000000") and (outputLOW="1100000010001100000100011000000"))
			report "TESTE 3 AND BIT A BIT" severity error;
			
-- novos valores			
			inputA <= std_logic_vector(to_unsigned(0, inputA'length));
			inputB <= std_logic_vector(to_unsigned(0, inputB'length));
			rst <= '1'; iniciar <= '0';
			wait for period;
			
------------------------------------------------------------------------------------------------------------------------------			
------------------------------------------------------------------------------------------------------------------------------		
			
			
--	teste se o A LESS THAN B está funcionando
			rst <= '0'; iniciar <= '1';
			inputA <= std_logic_vector(to_unsigned(159293040, inputA'length));
			inputB <= std_logic_vector(to_unsigned(218947128, inputB'length));
			control <= "0111";
			wait for 10 us;
			assert((outputHIGH="00000000000000000000000000000000") and (outputLOW="00000000000000000000000000000001"))
			report "TESTE 1 A LESS THAN B" severity error;
			
-- novos valores			
			inputA <= std_logic_vector(to_unsigned(0, inputA'length));
			inputB <= std_logic_vector(to_unsigned(0, inputB'length));
			rst <= '1'; iniciar <= '0';
			wait for period;
			
--	teste se o A LESS THAN B está funcionando
			rst <= '0'; iniciar <= '1';
			inputA <= std_logic_vector(to_unsigned(300, inputA'length));
			inputB <= std_logic_vector(to_unsigned(300, inputB'length));
			control <= "0111";
			wait for 10 us;
			assert((outputHIGH="00000000000000000000000000000000") and (outputLOW="00000000000000000000000000000000"))
			report "TESTE 2 A LESS THAN B" severity error;
			
-- novos valores			
			inputA <= std_logic_vector(to_unsigned(0, inputA'length));
			inputB <= std_logic_vector(to_unsigned(0, inputB'length));
			rst <= '1'; iniciar <= '0';
			wait for period;
--	teste se o A LESS THAN B está funcionando
			rst <= '0'; iniciar <= '1';
			inputA <= std_logic_vector(to_unsigned(1203012491, inputA'length));
			inputB <= std_logic_vector(to_unsigned(300, inputB'length));
			control <= "0111";
			wait for 10 us;
			assert((outputHIGH="00000000000000000000000000000000") and (outputLOW="00000000000000000000000000000000"))
			report "TESTE 3 A LESS THAN B" severity error;
			
-- novos valores			
			inputA <= std_logic_vector(to_unsigned(0, inputA'length));
			inputB <= std_logic_vector(to_unsigned(0, inputB'length));
			rst <= '1'; iniciar <= '0';
			wait for period;
			
------------------------------------------------------------------------------------------------------------------------------			
------------------------------------------------------------------------------------------------------------------------------
			
--	teste se a MULTIPLICAÇÃO está funcionando
			rst <= '0'; iniciar <= '1';
			inputA <= std_logic_vector(to_unsigned(1500, inputA'length));
			inputB <= std_logic_vector(to_unsigned(123456789, inputB'length));
			control <= "1000";
			wait for 10 us;
			assert((outputHIGH="00000000000000000000000000000100") and (outputLOW="01001111110011001010111101101100"))
			report "Multi 1 error" severity error;
			
-- novos valores			
			inputA <= std_logic_vector(to_unsigned(0, inputA'length));
			inputB <= std_logic_vector(to_unsigned(0, inputB'length));
			rst <= '1'; iniciar <= '0';
			wait for period;
			
--	teste se a MULTIPLICAÇÃO está funcionando
			rst <= '0'; iniciar <= '1';
			inputA <= std_logic_vector(to_unsigned(2147483646, inputA'length));
			inputB <= std_logic_vector(to_unsigned(0, inputB'length));
			control <= "1000";
			wait for 10 us;
			assert((outputHIGH="00000000000000000000000000000000") and (outputLOW="00000000000000000000000000000000"))
			report "Multi 2 error" severity error;
			
-- novos valores			
			inputA <= std_logic_vector(to_unsigned(0, inputA'length));
			inputB <= std_logic_vector(to_unsigned(0, inputB'length));
			rst <= '1'; iniciar <= '0';
			wait for period;
			
--	teste se a MULTIPLICAÇÃO está funcionando
			rst <= '0'; iniciar <= '1';
			inputA <= std_logic_vector(to_unsigned(2147483646, inputA'length));
			inputB <= std_logic_vector(to_unsigned(32, inputB'length));
			control <= "1000";
			wait for 10 us;
			assert((outputHIGH="00000000000000000000000000011111") and (outputLOW="11111111111111111111111111100000"))
			report "Multi 3 error" severity error;
			
-- novos valores			
			inputA <= std_logic_vector(to_unsigned(0, inputA'length));
			inputB <= std_logic_vector(to_unsigned(0, inputB'length));
			rst <= '1'; iniciar <= '0';
			wait for period;
			
--	teste se a MULTIPLICAÇÃO está funcionando
			rst <= '0'; iniciar <= '1';
			inputA <= std_logic_vector(to_unsigned(2147483646, inputA'length));
			inputB <= std_logic_vector(to_unsigned(2147483646, inputB'length));
			control <= "1000";
			wait for 10 us;
			assert((outputHIGH="01111111111111111111111111111111") and (outputLOW="10000000000000000000000000000000"))
			report "TESTE 4 MULTI TALVEZ A CONTA ESTEJA ERRADA" severity error;
			
-- novos valores			
			inputA <= std_logic_vector(to_unsigned(0, inputA'length));
			inputB <= std_logic_vector(to_unsigned(0, inputB'length));
			rst <= '1'; iniciar <= '0';
			wait for period;
			
--	teste se a MULTIPLICAÇÃO está funcionando
			rst <= '0'; iniciar <= '1';
			inputA <= std_logic_vector(to_unsigned(0, inputA'length));
			inputB <= std_logic_vector(to_unsigned(0, inputB'length));
			control <= "1000";
			wait for 10 us;
			assert((outputHIGH="00000000000000000000000000000000") and (outputLOW="00000000000000000000000000000000"))
			report "TESTE 5 MULTI ZERO X ZERO" severity error;
			
-- novos valores			
--			inputA <= std_logic_vector(to_unsigned(0, inputA'length));
--			inputB <= std_logic_vector(to_unsigned(0, inputB'length));
--			rst <= '1'; iniciar <= '0';
--			wait for period;
			
			wait for period;
			assert false report "Test finished, good work!" severity note;
			finished <= '1';
			wait;
		end process;
end tb;
