LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

entity MIPS_operativo is
	port (data1: in std_logic_vector(4 downto 0);
			data2: in std_logic_vector(4 downto 0);
			data3: in std_logic_vector(4 downto 0);
			data4: in std_logic_vector(15 downto 0);
			clk, RegDst, LerMem, MemParaReg, UlaOp, EscMem, ULAFonte, EscReg: in std_logic;
			saida: out std_logic_vector(31 downto 0)
			);
end MIPS_operativo;

architecture operation of MIPS_operativo is

--signals
signal dadoA, dadoB: unsigned(7 downto 0);
signal fsub: unsigned(7 downto 0);
signal cs, somador, smux, convertsad: unsigned(13 downto 0);
signal cout, coutfim: std_logic;
signal ziout, ciout: unsigned(6 downto 0);
signal somafim, convertfim: unsigned(5 downto 0);

signal pA, pB: unsigned(7 downto 0);

--component
	component banco_regNbits is
	generic(N : integer:= 5 );
	PORT (clk,load: in std_logic;
			D1, D2: in  unsigned(N-1 downto 0);
			Q1, Q2: out unsigned(N-1 downto 0)
			);
	END component;

	component muxNbits
	generic(N : integer := 5 );
	port (A, B: in unsigned(N - 1 downto 0);
			sel: in std_logic;
			y: out unsigned (N - 1 downto 0)
			);
	end component;
	
	component sub is
	generic(N : integer := 8 );
	port (add1: in unsigned(N - 1 downto 0);
			add2: in unsigned(N - 1 downto 0);
			result: out unsigned(N - 1 downto 0)
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
	generic(N : INTEGER := 8 );
	port (add1: in unsigned(N - 1 downto 0);
			add2: in unsigned(N - 1 downto 0);
			sum: out unsigned(N - 1 downto 0);
			carry: out std_logic
			);
	end component;

--port map
begin

	pA <= unsigned(Mem_A);
	pB <= unsigned(Mem_B);

--Instruções R e I

mux1: muxNbits --4
	generic map(N => 5)
	port map(data2, data3, RegDst, smux1);

registrador: Banco_regNbits --1
	generic map(N => 5)
	port map(clk, data1, data2, smux1, smux3, rA, rB);
	
mux2: muxNbits --4
	generic map(N => 5)
	port map(rB, ES, ULAFonte, smux2);
	
ULALA: ula
	generic map(N => 5)
	port map(cULA, rA, smux2, resultado, zero);

Mem_Dados: memNbits
	generic map(N => 5)
	port map(clk, resultado, rB, dadolido);
	
mux3: muxNbits --4
	generic map(N => 5)
	port map(resultado, dadolido, MemParaReg, smux3);

--Instrução BEQ

somador2

muxZI: muxNbits --1
	generic map(N => 7)
	port map(coutfim & somafim, zi, ziout);
	
regCI: regNbits --2
	generic map(N => 7)
	port map(clk, ci, ziout, ciout);

menor <= not ciout(6); --3
convertfim <= ciout(5 downto 0); --3

somaEND: sum --4
	generic map(N => 6)
	port map("000001", ciout(5 downto 0), somafim, coutfim);
	
	fim <= std_logic_vector(convertfim);
	sad <= std_logic_vector(convertsad);
	
--Instrução jump

mux5: muxNbits --4
	generic map(N => 32)
	port map(resultado, dadolido, MemParaReg, saida);

end operation;

