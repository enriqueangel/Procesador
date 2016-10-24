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

Component WindowsManager is
PORT ( 
		rs1 : in  STD_LOGIC_VECTOR (4 downto 0);
      rs2 : in  STD_LOGIC_VECTOR (4 downto 0);
      rd : in  STD_LOGIC_VECTOR (4 downto 0);
      cwp : in  STD_LOGIC;
      op : in  STD_LOGIC_VECTOR (1 downto 0);
      op3 : in  STD_LOGIC_VECTOR (5 downto 0);
      ncwp : out  STD_LOGIC;
      nrs1 : out  STD_LOGIC_VECTOR (5 downto 0);
      nrs2 : out  STD_LOGIC_VECTOR (5 downto 0);
      nrd : out  STD_LOGIC_VECTOR (5 downto 0));
end component;

Component UC is
PORT( 
		Op : in  STD_LOGIC_VECTOR (1 downto 0);
      Op3 : in  STD_LOGIC_VECTOR (5 downto 0);
      Out_Aloup : out  STD_LOGIC_VECTOR (5 downto 0));
end Component;

Component RegisterFile is
PORT( 
		rs1 : in  STD_LOGIC_VECTOR (5 downto 0);
      rs2 : in  STD_LOGIC_VECTOR (5 downto 0);
      rd : in  STD_LOGIC_VECTOR (5 downto 0);
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

Component PSR_Modifier is
PORT ( 
		rs1 : in  STD_LOGIC;
      oper2 : in  STD_LOGIC;
      rst : in  STD_LOGIC;
      Aluop : in  STD_LOGIC_VECTOR (5 downto 0);
      AluResult : in  STD_LOGIC_VECTOR (31 downto 0);
      Salida : out  STD_LOGIC_VECTOR (3 downto 0));
end component;

Component PSR is
PORT ( 
		CLK : in  STD_LOGIC;
      Reset : in  STD_LOGIC;
      Out_Modifier : in  STD_LOGIC_VECTOR (3 downto 0);
      nCWP : in  STD_LOGIC;
      CWP : out  STD_LOGIC;
		icc : out  STD_LOGIC_VECTOR (3 downto 0);
		carry: out STD_LOGIC);
end component;

Component ALU is
PORT(
		Op1 : in  STD_LOGIC_VECTOR (31 downto 0);
      Op2 : in  STD_LOGIC_VECTOR (31 downto 0);
      Selector : in  STD_LOGIC_VECTOR (5 downto 0);
		Carry : in STD_LOGIC;
      Salida : out  STD_LOGIC_VECTOR (31 downto 0));
end Component;

signal In_nPC: STD_LOGIC_VECTOR (31 downto 0) := (others => '0');
signal In_Aloup,In_rs1,In_rs2,In_rd: STD_LOGIC_VECTOR (5 downto 0);
signal nzvc,siguiente: STD_LOGIC_VECTOR (3 downto 0); 
signal next_window,window,acarreo: STD_LOGIC := '0';
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
	port map( Op1 => "00000000000000000000000000000001",
				 Op2 => In_PC,
				 Salida => In_nPC
			   );
				
IM: instructionMemory
	port map( address => Direccion,
				 reset => Reset,
				 outInstruction => Instr
				);

Ventana: WindowsManager
	port map( rs1 => Instr(18 downto 14),
				 rs2 => Instr(4 downto 0),
				 rd => Instr(29 downto 25),
				 cwp => window,
				 op => Instr(31 downto 30),
				 op3 => Instr(24 downto 19),
				 ncwp => next_window,
				 nrs1 => In_rs1,
				 nrs2 => In_rs2,
				 nrd => In_rd
				);
				 
RF: RegisterFile
	port map( rs1 => In_rs1,
				 rs2 => In_rs2,
				 rd => In_rd,
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

PSR0: PSR
	port map( CLK => CLK,
				 Reset => Reset,
				 Out_Modifier => nzvc,
				 nCWP => next_window,
				 CWP => window,
				 icc => siguiente,
				 carry => acarreo
				);
				 
Mux: Multiplexor
	port map( Entrada1 => Sal2,
				 Entrada2 => Sal32,
				 Selector => Instr(13),
				 Salida => Op_Mux
				);
				
PSR_M: PSR_Modifier
   port map( rs1 => Sal1(31),
				 oper2 => Op_Mux(31),
				 rst => Reset,
				 Aluop => In_Aloup,
				 AluResult => Alu_out,
				 Salida => nzvc
				);
				
Operaciones: Alu
	port map( Op1 => Sal1,
				 Op2 => Op_Mux,
				 Selector => In_Aloup,
				 Carry => acarreo,
				 Salida => Alu_out
				);

Alup_Result <= Alu_out;
			 
end Behavioral;

