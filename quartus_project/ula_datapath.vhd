LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

entity ula_datapath is 
	port (
			in_1,in_2: in std_logic_vector(31 downto 0);
			controle: in std_logic_vector(3 downto 0);
			clk,shift,cA,cB,cc,cca,zcarry,zcount,cACC,cQ,cM,zacc,cS,cSL,cSH: in std_logic;
			zero_out,setonlessthen,iniszero,q0,endloop: out std_logic;
			SL: out std_logic_vector(31 downto 0);
			SH: out std_logic_vector(31 downto 0)
			);
end ula_datapath;

architecture rtl of ula_datapath is

signal A,B,M,Q,ACC,partial_sum,multisum,SH_t,SL_t: std_logic_vector(31 downto 0);
signal zero: std_logic_vector(31 downto 0) := (others => '0');
signal plus_minus,and_or,after_mux,partial,S: std_logic_vector(63 downto 0);
signal zero_64: std_logic_vector(62 downto 0) := (others => '0');
signal seton,isin,acc0,q_0,carrys,sscarry: std_logic;
signal counter,pcounter,mux_counter: std_logic_vector(5 downto 0);
signal mux_carry,scarry,carry: std_logic;

	component mux_2_1_32bit_zero
	generic (N : integer := 32);
			  port (
						 A: in std_logic_vector(N - 1 downto 0);
						 sel : in std_logic;
						y : out std_logic_vector(N - 1 downto 0)
					  );
	end component;
	
	component mux_2_1_64bit is
	generic (N : integer := 64);
     port (
             A: in std_logic_vector(N - 1 downto 0);
				 B: in std_logic_vector(N - 1 downto 0);
             sel : in std_logic;
            y : out std_logic_vector(N - 1 downto 0)
           );
	end component;
	
	component mux_2_1_6bit is
	generic (N : integer := 6);
     port (
            A: in std_logic_vector(N - 1 downto 0);
            sel : in std_logic;
            y : out std_logic_vector (N - 1 downto 0)
           );
	end component;
	
	component mux_4_1_64bit is
	generic (N : integer := 64);
     port (
             A: in std_logic_vector(N - 1 downto 0);
				 B: in std_logic_vector(N - 1 downto 0);
             sel : in std_logic_vector(1 downto 0);
             y : out std_logic_vector (N - 1 downto 0)
           );
	end component;

	component new_reg is
	generic (N : integer:= 32);
	PORT (
			clk,load,shift,Cacc : in std_logic;
			A : in std_logic_vector (N-1 downto 0);
			M : out std_logic_vector (N-1 downto 0);
			Q : out std_logic
			);
	END component;

	component u_sum is
	generic ( N : INTEGER := 32 );
	port (
			add1 : in std_logic_vector(N - 1 downto 0);
			add2 : in std_logic_vector(N - 1 downto 0);
			carry: out std_logic;
			sum : out std_logic_vector(N - 1 downto 0)
			);
	end component;
	
	component subadd is
	generic ( N : INTEGER := 64 );
	port (
			add1 : in std_logic_vector(N - 1 downto 0);
			add2 : in std_logic_vector(N - 1 downto 0);
			op: in std_logic;
			sumsub : out std_logic_vector(N - 1 downto 0)
			);
	end component;
	
	component registrador is
	generic (N : integer:= 32);
	PORT (
			clk,load : in std_logic;
			D : in std_logic_vector (N-1 downto 0);
			Q : out std_logic_vector(N-1 downto 0)
			);
	END component;
	
	component bitwise is
	generic ( N : INTEGER := 64 );
	port (
			in1 : in std_logic_vector(N - 1 downto 0);
			in2 : in std_logic_vector(N - 1 downto 0);
			op: in std_logic;
			result : out std_logic_vector(N - 1 downto 0)
			);
	end component;
	
	component multiplexador is
     port (
             A: in std_logic;
             sel : in std_logic;
            y : out std_logic
           );
	end component;
	
	component mux_2_1_32bit is
	generic (N : integer := 32);
     port (
             A: in std_logic_vector(N - 1 downto 0);
				 B: in std_logic_vector(N - 1 downto 0);
             sel : in std_logic;
            y : out std_logic_vector(N - 1 downto 0)
           );
	end component;

	component reg_carry is
	PORT (
			clk,load : in std_logic;
			D : in std_logic;
			Q : out std_logic
			);
	END component;
	
	begin 
	
	IA: registrador
	generic map(N => 32)
	port map(clk,cA,in_1,A);
	
	IB: registrador
	generic map(N => 32)
	port map(clk,cB,in_2,B);
	
	Isumsub: subadd
	generic map(N => 64)
	port map(zero&A,zero&B,controle(2),plus_minus);
	
	Ibitwise: bitwise 
	generic map(N => 64)
	port map(zero&A,zero&B,controle(0),and_or);
	
	Imux_2_1_64bit: mux_2_1_64bit
	generic map(N => 64)
	port map(and_or,plus_minus,controle(1),after_mux);
	
	Imux_4_1_64bit: mux_4_1_64bit
	generic map(N => 64)
	port map(after_mux,zero_64&seton,((controle(3) and isin) & (controle(2) and controle(1) and controle(0))),partial);
	
	Imux_2_1_6bit: mux_2_1_6bit
	generic map(N => 6)
	port map(counter,zcount,mux_counter);
	
	Icount: registrador
	generic map(N => 6)
	port map(clk,cc,mux_counter,pcounter);
	
	Isumsubcount: subadd
	generic map(N => 6)
	port map(pcounter,"000001",'1',counter);
	
	IM: registrador
	generic map(N => 32)
	port map(clk,cM,A,M);
	
	Icarrymux: multiplexador
	port map(carry,zcarry,mux_carry);
	
	IC: reg_carry
	port map(clk,cca,mux_carry,scarry);
	
	Isum: u_sum
	generic map(N => 32)
	port map(ACC,M,carrys,partial_sum);
	
	Imux_2_1_32bit_zero: mux_2_1_32bit_zero
	generic map(N => 32)
	port map(partial_sum,zacc,multisum);
	
	IACC: new_reg
	generic map(N => 32)
	port map(clk,cACC,shift,scarry,multisum,ACC,acc0);
	
	IQ: new_reg
	generic map(N => 32)
	port map(clk,cQ,shift,acc0,B,Q,q_0);
	
	Imux_2_1_32bit_SH: mux_2_1_32bit
	generic map(N => 32)
	port map(ACC,S(63 downto 32),(not controle(3)),SH_t);
	
	Imux_2_1_32bit_SL: mux_2_1_32bit
	generic map(N => 32)
	port map(Q,S(31 downto 0),(not controle(3)),SL_t);
	
	ISS: registrador
	generic map(N => 64)
	port map(clk,cS,partial,S);
	
	ISH: registrador
	generic map(N => 32)
	port map(clk,cSH,SH_t,SH);
	
	ISL: registrador
	generic map(N => 32)
	port map(clk,cSL,SL_t,SL);
	
	setonlessthen <= '1' when(A < B) else '0';
	zero_out <= '1' when (A = B) else '0';
	q0 <= q_0;
	iniszero <= '1' when ((A = zero) or (B = zero)) else '0';
	endloop <= '1' when (pcounter = "000000") else '0';
	
	
end rtl;
