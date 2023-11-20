library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all; 

entity MIPS_main is
	port (ePC: in std_logic_vector(31 downto 0);
			sPC: out std_logic_vector(31 downto 0)
			);
end MIPS_main;

architecture ordem of MIPS_main is

--signals
	signal zi,ci,cpA,cpB,zsoma,csoma,csad_reg,menor: std_logic;
	
--component
	component Mem_Instr is
	port (Endereço: in std_logic_vector(31 downto 0);
			Instrução: out std_logic_vector(31 downto 0)
			);
	end component;

	component MIPS_fsmd is
	port (opcode : in std_logic_vector(5 downto 0);
			status : in std_logic_vector
			RegDst, DVI, DVC, LerMem, MemParaReg, ULAOp, EscMem, ULAFonte, EscReg : out std_logic
			);
	end component;
	
	component MIPS_operativo is
	port (data1: in std_logic_vector(4 downto 0);
			data2: in std_logic_vector(4 downto 0);
			data3: in std_logic_vector(4 downto 0);
			data4: in std_logic_vector(15 downto 0);
			clk, RegDst, LerMem, MemParaReg, UlaOp, EscMem, ULAFonte, EscReg: in std_logic;
			saida: out std_logic_vector(31 downto 0)
			);
	end component;
	
--port map
begin 

	MEM: Mem_Instr port map(sPC, instr);

	BC: MIPS_fsmd port map(instr(31 downto 26), status, RegDst, DVI, DVC, LerMem, MemParaReg, ULAOp, EscMem, ULAFonte, EscReg);
	
	BO: MIPS_operativo port map(instr(25 downto 21), instr(20 downto 16), instr(15 downto 11), instr(15 downto 0), clk, RegDst, LerMem, MemParaReg, UlaOp, EscMem, ULAFonte, EscReg, ePC);

end ordem;