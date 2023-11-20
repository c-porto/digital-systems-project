LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

entity MIPS_operativo is
	port (info:  in std_logic_vector(31 downto 0);
			data:  in std_logic_vector(25 downto 0);
			clk, RegDst, DVI, DVC, LerMem, MemParaReg, UlaOp, EscMem, ULAFonte, EscReg: in std_logic;
			saida: out std_logic_vector(31 downto 0)
			);
end MIPS_operativo;

architecture operation of MIPS_operativo is

--signals
signal rA, rB, m1, m2, m3, resultado, zero, dadolido: std_logic_vector(4 downto 0);
signal m4, m5: std_logic_vector(31 downto 0);
signal carryout1, carryout2: std_logic;
signal d1: std_logic_vector(27 downto 0);
signal d2: std_logic_vector(31 downto 0);
signal cULA: std_logic_vector(2 downto 0);

--component
	component banco_regNbits is
	generic(N : integer:= 5 );
	PORT (clk,load: in std_logic;
			D1, D2: in  unsigned(N-1 downto 0);
			Q1, Q2: out unsigned(N-1 downto 0)
			);
	END component;

	component muxNbits is
	generic(N : integer := 5 );
	port (A, B: in unsigned(N - 1 downto 0);
			sel: in std_logic;
			y: out unsigned (N - 1 downto 0)
			);
	end component;
	
	component ula is
	generic(N : integer := 5 );
	port (cntrl: in unsigned (3 downto 0);
			A, B: in unsigned (N - 1 downto 0);
			S: out unsigned (N - 1 downto 0);
			cout:	out std_logic
			);
			
	component memNbits is
	generic(N : integer := 5 );
	port (clk: in std_logic;
			endereço: in unsigned(N - 1 downto 0);
			mein: in unsigned(N - 1 downto 0);
			meout: out unsigned(N - 1 downto 0)
			);
	end component;			
	
	component sum is
	generic(N : INTEGER := 32 );
	port (add1: in unsigned(N - 1 downto 0);
			add2: in unsigned(N - 1 downto 0);
			sum: out unsigned(N - 1 downto 0);
			carry: out std_logic
			);
	end component;
	
	component ctrlULA is
	port (ulaIN:  in std_logic_vector(5 downto 0);
			ulaS:   in std_logic_vector(1 downto 0);
			ulaOUT: out std_logic_vector(2 downto 0)
			);
	end component;

--port map
begin

d1 <= data & "00";

d2 <= ES & "00";

ES <= ????

--Instruções R e I

mux1: muxNbits
	generic map(N => 5)
	port map(data(20 downto 16), data(15 downto 11), RegDst, m1);

registrador: Banco_regNbits
	generic map(N => 5)
	port map(clk, data(25 downto 21), data(20 downto 16), m1, m3, rA, rB);
	
mux2: muxNbits
	generic map(N => 5)
	port map(rB, ES, ULAFonte, m2);
	
controleULA: ctrlULA
	port map(data(5 downto 0), ULAOp, cULA);
	
ULALA: ula
	generic map(N => 5)
	port map(cULA, rA, m2, resultado, zero);

Mem_Dados: memNbits
	generic map(N => 5)
	port map(clk, resultado, rB, dadolido);
	
mux3: muxNbits
	generic map(N => 5)
	port map(resultado, dadolido, MemParaReg, m3);

--Instrução BEQ & jump

somador1: sum
	generic map(N => 32)
	port map(info, "100", s1, carryout1);
	
somador2: sum
	generic map(N => 32)
	port map(s1, d2, s2, carryout2);
	
mux4: muxNbits --1
	generic map(N => 32)
	port map(s1, s2, (DVC and zero), m4);
	
mux5: muxNbits --1
	generic map(N => 32)
	port map(m4, d1 & s1(31 downto 28), DVI, saida);
	
end operation;

