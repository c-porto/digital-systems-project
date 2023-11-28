library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all; 

entity ula_mips is
	port (controle: in std_logic_vector(3 downto 0);
			IN_1: in std_logic_vector(31 downto 0);
			IN_2: in std_logic_vector(31 downto 0);
			SL: out std_logic_vector(31 downto 0);
			SH: out std_logic_vector(31 downto 0);
			clk,iniciar: in std_logic;
			pronto: out std_logic
			);
end ula_mips;

architecture ordem of ula_mips is

--signals
	signal zero_sig,zcount,cc,cca,endloop,cA,cB,c2,c0,c1,c_and,cs,cSL,cSH,c3,zacc,zcarry,cACC,shift,cQ,q0,In_ls_Zero,cM,setonlessthen: std_logic;
	
--component

	component ula_control is
	port (
			clk, iniciar, setonlessthen,iniszero,q0,endloop: in std_logic;
			control : in std_logic_vector(3 downto 0);
			pronto,shift,cA,cB,cc,cca,zcount,cACC,cQ,cM,zacc,zcarry,cS,cSL,cSH: out std_logic
			);
	end component;
	
	component ula_datapath is
	port (IN_1:  in std_logic_vector(31 downto 0);
			IN_2:  in std_logic_vector(31 downto 0);
			controle: in std_logic_vector(3 downto 0);
			clk,shift,cA,cB,cc,cca,zcarry,zcount,cACC,cQ,cM,zacc,cS,cSL,cSH: in std_logic;
			zero_out,setonlessthen,iniszero,q0,endloop: out std_logic;
			SL: out std_logic_vector(31 downto 0);
			SH: out std_logic_vector(31 downto 0)
			);
	end component;
	
--port map
begin 

	BC: ula_control port map(clk, iniciar, setonlessthen,In_ls_Zero,q0,endloop, controle,pronto,shift,cA,cB,cc,cca,zcount,cACC,cQ,cM,zacc,zcarry,cS,cSL,cSH);
	
	BO: ula_datapath port map(IN_1, IN_2, controle, clk, shift, cA, cB, cc, cca, zcarry, zcount, cACC, cQ, cM, zacc, cS, cSL, cSH,zero_sig,setonlessthen,In_ls_Zero,q0,endloop,SL,SH);

end ordem;
