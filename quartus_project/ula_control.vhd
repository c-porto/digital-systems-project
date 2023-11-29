LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY ula_control IS
	PORT
		(clk, rst, iniciar, setonlessthen,iniszero,q0,endloop : IN STD_LOGIC;
		control: in std_logic_vector(3 downto 0);
		pronto,shift,cA,cB,cc,cca,zcount,cACC,cQ,cM,zacc,zcarry,cS,cSL,cSH: OUT STD_LOGIC
		);
END ula_control;

ARCHITECTURE behavior of ula_control is
	TYPE State is (S0,S1,S2,S3,S4,S5,S6,S7,S8,S9,S10,S11,S12,S13,S14);
	SIGNAL Current_State, Next_State : State;
	Begin
		PROCESS (iniciar,setonlessthen,iniszero,q0,endloop,control)
		BEGIN
			CASE Current_State is
				WHEN S0 => 	
						IF iniciar = '0' THEN
							Next_State <= S0;
						ELSE
							Next_State <= S1;
						END IF;
				WHEN S1 => 	
						IF control(3) = '1' THEN
							Next_State <= S6;
						ELSIF control(3 downto 0) = "0010" THEN
							Next_State <= S2;
						ELSIF control(3 downto 0) = "0110" THEN
							Next_State <= S3;
						ELSIF control(3 downto 0) = "0000" THEN
							Next_State <= S5;
						ELSIF control(3 downto 0) = "0001" THEN
							Next_State <= S4;
						ELSIF control(3 downto 0) = "0111" THEN
							IF setonlessthen = '0' THEN 
								Next_State <= S13;
							ELSE 
								Next_State <= S12;
							END IF;
						ELSE 
							Next_State <= S1;
						END IF;
				WHEN S2 =>
						Next_State <= S14;
				WHEN S3 => 
						Next_State <= S14;
				WHEN S4 =>
						Next_State <= S14;
				WHEN S5 =>
						Next_State <= S14;
				WHEN S6 =>
						IF iniszero = '1' THEN
							Next_State <= S11;
						ELSE 
							Next_State <= S7;
						END IF;
				WHEN S7 =>
						IF endloop = '0' THEN
							IF q0 = '0' THEN
								Next_State <= S8;
							ELSE 
								Next_State <= S9;
							END IF;
						ELSE 
							Next_State <= S10;
						END IF;
				WHEN S8 =>
						Next_State <= S7;
				WHEN S9 => 
						Next_State <= S8;
				WHEN S12 =>
						Next_State <= S14;
				WHEN S13 =>
						Next_State <= S14;
				WHEN S11 =>
						Next_State <= S14;
				WHEN S14 =>
						Next_State <= S0;
				WHEN S10 =>
						Next_State <= S0;
			END CASE;
		END PROCESS;
		
		PROCESS (clk, rst)
		BEGIN
			IF rst = '1' THEN
					Current_State <= S0;
				ELSIF (rising_edge(clk)) THEN
					Current_State <= Next_State;
			END IF;
		END PROCESS;
		
		pronto <= '1' WHEN Current_State = S0
		ELSE '0';
		shift <= '1' WHEN Current_State = S8
		ELSE '0';
		cA <= '1' WHEN Current_State = S1
		ELSE '0';
		cB <= '1' WHEN Current_State = S1
		ELSE '0';
		zcount <= '0' WHEN Current_State = S6
		ELSE '1';
		zacc <= '0' WHEN Current_State = S6
		ELSE '1';
		zcarry <= '0' WHEN Current_State = S6
		ELSE '1';
		cM <= '1' WHEN Current_State = S6
		ELSE '0';
		cQ <= '1' WHEN Current_State = S6
		ELSE '0';
		
		
		WITH Current_State SELECT
		cACC <= 	'1' WHEN S6,
					'1' WHEN S9,
					'0' WHEN OTHERS;
		WITH Current_State SELECT
		cca <= 	'1' WHEN S6,
					'1' WHEN S9,
					'0' WHEN OTHERS;
		WITH Current_State SELECT
		cc <= 	'1' WHEN S6,
					'1' WHEN S8,
					'0' WHEN OTHERS;
		WITH Current_State SELECT
		cS <= 	'1' WHEN S2,
					'1' WHEN S3,
					'1' WHEN S4,
					'1' WHEN S5,
					'1' WHEN S11,
					'1' WHEN S12,
					'1' WHEN S13,
					'0' WHEN OTHERS;
		WITH Current_State SELECT
		cSH <= 	'1' WHEN S10,
					'1' WHEN S14,
					'0' WHEN OTHERS;
		WITH Current_State SELECT
		cSL <= 	'1' WHEN S10,
					'1' WHEN S14,
					'0' WHEN OTHERS;

END behavior;
