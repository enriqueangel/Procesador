library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ProcesadorMonociclo is
    Port ( CLK : in  STD_LOGIC;
           Reset : in  STD_LOGIC;
           Alup_Result : out  STD_LOGIC_VECTOR (31 downto 0));
end ProcesadorMonociclo;

architecture Behavioral of ProcesadorMonociclo is

Component Sumador
PORT(
		Op1 : in  STD_LOGIC_VECTOR (31 downto 0);
      Op2 : in  STD_LOGIC_VECTOR (31 downto 0);
      Salida : out  STD_LOGIC_VECTOR (31 downto 0));
end Component;

Component Program_Counter
PORT(
		CLK: in STD_LOGIC;
		Entrada : in  STD_LOGIC_VECTOR (31 downto 0);
		reset: in STD_LOGIC;
      Salida : out  STD_LOGIC_VECTOR (31 downto 0));
end Component;

Component instructionMemory is
PORT(
		address : in  STD_LOGIC_VECTOR (31 downto 0);
      reset : in  STD_LOGIC;
      outInstruction : out  STD_LOGIC_VECTOR (31 downto 0));
end Component;

Component UC is
PORT( 
		Op : in  STD_LOGIC_VECTOR (1 downto 0);
      Op3 : in  STD_LOGIC_VECTOR (5 downto 0);
      Out_Aloup : out  STD_LOGIC_VECTOR (5 downto 0));
end Component;

Component RegisterFile is
PORT( 
		rs1 : in  STD_LOGIC_VECTOR (4 downto 0);
      rs2 : in  STD_LOGIC_VECTOR (4 downto 0);
      rd : in  STD_LOGIC_VECTOR (4 downto 0);
      DataWrite : in  STD_LOGIC_VECTOR (31 downto 0);
		rst : in  STD_LOGIC;
      Crs1 : out  STD_LOGIC_VECTOR (31 downto 0);
      Crs2 : out  STD_LOGIC_VECTOR (31 downto 0));
end Component;

Component Expansion is
PORT(
		Imm13 : in  STD_LOGIC_VECTOR (12 downto 0);
      Out_Imm32 : out  STD_LOGIC_VECTOR (31 downto 0));
end Component;

Component Multiplexor is
PORT(
		Entrada1 : in  STD_LOGIC_VECTOR (31 downto 0);
      Entrada2 : in  STD_LOGIC_VECTOR (31 downto 0);
      Selector : in  STD_LOGIC;
      Salida : out  STD_LOGIC_VECTOR (31 downto 0));
end Component;

Component ALU is
PORT(
		Op1 : in  STD_LOGIC_VECTOR (31 downto 0);
      Op2 : in  STD_LOGIC_VECTOR (31 downto 0);
      Selector : in  STD_LOGIC_VECTOR (5 downto 0);
      Salida : out  STD_LOGIC_VECTOR (31 downto 0));
end Component;

signal In_nPC: STD_LOGIC_VECTOR (31 downto 0) := (others => '0');
signal In_Aloup: STD_LOGIC_VECTOR (5 downto 0);
signal In_PC,Direccion,Instr,Alu_out,Sal1,Sal2,Sal32,Op_Mux : STD_LOGIC_VECTOR (31 downto 0);

begin

nPC: Program_Counter
	port map( CLK => CLK,
				 Entrada => In_nPC,
				 reset => Reset,
				 Salida => In_PC
				);

Pc: Program_Counter
	port map( CLK => CLK,
				 Entrada => In_PC,
				 reset => Reset,
				 Salida => Direccion
				);
				
Sum: Sumador
	port map( Op1 => x"00000004",
				 Op2 => In_PC,
				 Salida => In_nPC
			   );
				
IM: instructionMemory
	port map( address => Direccion,
				 reset => Reset,
				 outInstruction => Instr
				);

RF: RegisterFile
	port map( rs1 => Instr(18 downto 14),
				 rs2 => Instr(4 downto 0),
				 rd => Instr(29 downto 25),
				 DataWrite => Alu_out,
				 rst => Reset,
				 Crs1 => Sal1,
				 Crs2 => Sal2
				);

UnidadControl: UC
	port map( Op => Instr(31 downto 30),
				 Op3 => Instr(24 downto 19),
				 Out_Aloup => In_Aloup
				);

SEU: Expansion
	port map( Imm13 => Instr(12 downto 0),
				 Out_Imm32 => Sal32
				);

Mux: Multiplexor
	port map( Entrada1 => Sal2,
				 Entrada2 => Sal32,
				 Selector => Instr(13),
				 Salida => Op_Mux
				);
				
Operaciones: Alu
	port map( Op1 => Sal1,
				 Op2 => Op_Mux,
				 Selector => In_Aloup,
				 Salida => Alu_out
				);

Alup_Result <= Alu_out;
			 
end Behavioral;

