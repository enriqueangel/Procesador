library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ProcesadorMonociclo is
    Port ( CLK : in  STD_LOGIC;
           Reset : in  STD_LOGIC;
           Alup_Result : out  STD_LOGIC_VECTOR (31 downto 0));
end ProcesadorMonociclo;

architecture Behavioral of ProcesadorMonociclo is

Component Sumador is
    Port ( Op1 : in  STD_LOGIC_VECTOR (31 downto 0);
           Op2 : in  STD_LOGIC_VECTOR (31 downto 0);
           Salida : out  STD_LOGIC_VECTOR (31 downto 0));
end Component;

Component Program_Counter is
    Port ( CLK: in STD_LOGIC;
		     Entrada : in  STD_LOGIC_VECTOR (31 downto 0);
			  reset: in STD_LOGIC;
           Salida : out  STD_LOGIC_VECTOR (31 downto 0));
end Component;

Component InstructionMemory is
    Port ( address : in  STD_LOGIC_VECTOR (31 downto 0);
           reset : in  STD_LOGIC;
           outInstruction : out  STD_LOGIC_VECTOR (31 downto 0));
end Component;

Component WindowsManager is
    Port ( rs1 : in  STD_LOGIC_VECTOR (4 downto 0);
           rs2 : in  STD_LOGIC_VECTOR (4 downto 0);
           rd : in  STD_LOGIC_VECTOR (4 downto 0);
           cwp : in  STD_LOGIC;
           op : in  STD_LOGIC_VECTOR (1 downto 0);
           op3 : in  STD_LOGIC_VECTOR (5 downto 0);
           ncwp : out  STD_LOGIC;
           nrs1 : out  STD_LOGIC_VECTOR (5 downto 0);
           nrs2 : out  STD_LOGIC_VECTOR (5 downto 0);
           nrd : out  STD_LOGIC_VECTOR (5 downto 0);
           ro7 : out  STD_LOGIC_VECTOR (5 downto 0));
end Component;

Component SEU_22B is
    Port ( Imm22 : in  STD_LOGIC_VECTOR (21 downto 0);
           Out_Imm32 : out  STD_LOGIC_VECTOR (31 downto 0));
end Component;

Component SEU_30 is
    Port ( Imm30 : in  STD_LOGIC_VECTOR (29 downto 0);
           Out_Imm32 : out  STD_LOGIC_VECTOR (31 downto 0));
end Component;

Component Mux_RF is
    Port ( Rd : in  STD_LOGIC_VECTOR (5 downto 0);
           Ro7 : in  STD_LOGIC_VECTOR (5 downto 0);
           Rfdest : in  STD_LOGIC;
           mRd : out  STD_LOGIC_VECTOR (5 downto 0));
end Component;

Component UnidadControl is
    Port ( op : in  STD_LOGIC_VECTOR (1 downto 0);
           op3 : in  STD_LOGIC_VECTOR (5 downto 0);
           op2 : in  STD_LOGIC_VECTOR (2 downto 0);
           cond : in  STD_LOGIC_VECTOR (3 downto 0);
           icc : in  STD_LOGIC_VECTOR (3 downto 0);
           HabilitadorMemoria : out  STD_LOGIC;
           Rfdest : out  STD_LOGIC;
           Rfsource : out  STD_LOGIC_VECTOR (1 downto 0);
           Pcsource : out  STD_LOGIC_VECTOR (1 downto 0);
           EscrituraMem : out  STD_LOGIC;
           EscrituraRF : out  STD_LOGIC;
           Aluop : out  STD_LOGIC_VECTOR (5 downto 0));
end Component;

Component RegisterFile is
    Port ( Reset : in  STD_LOGIC;
           Rs1 : in  STD_LOGIC_VECTOR (5 downto 0);
           Rs2 : in  STD_LOGIC_VECTOR (5 downto 0);
           Rd : in  STD_LOGIC_VECTOR (5 downto 0);
           Escritura : in  STD_LOGIC;
           DatoEscritura : in  STD_LOGIC_VECTOR (31 downto 0);
           Crs1 : out  STD_LOGIC_VECTOR (31 downto 0);
           Crs2 : out  STD_LOGIC_VECTOR (31 downto 0);
           Crd : out  STD_LOGIC_VECTOR (31 downto 0));
end Component;

Component SEU_13 is
    Port ( Imm13 : in  STD_LOGIC_VECTOR (12 downto 0);
           Out_Imm32 : out  STD_LOGIC_VECTOR (31 downto 0));
end Component;

Component MultiplexorAlu is
    Port ( Entrada1 : in  STD_LOGIC_VECTOR (31 downto 0);
           Entrada2 : in  STD_LOGIC_VECTOR (31 downto 0);
           Selector : in  STD_LOGIC;
           Salida : out  STD_LOGIC_VECTOR (31 downto 0));
end Component;

Component Alu is
    Port ( Op1 : in  STD_LOGIC_VECTOR (31 downto 0);
           Op2 : in  STD_LOGIC_VECTOR (31 downto 0);
           Selector : in  STD_LOGIC_VECTOR (5 downto 0);
           Carry : in  STD_LOGIC;
           Salida : out  STD_LOGIC_VECTOR (31 downto 0));
end Component;

Component PSR_Modifier is
    Port ( rs1 : in  STD_LOGIC;
           oper2 : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           Aluop : in  STD_LOGIC_VECTOR (5 downto 0);
           AluResult : in  STD_LOGIC_VECTOR (31 downto 0);
           Salida : out  STD_LOGIC_VECTOR (3 downto 0));
end Component;

Component PSR is
    Port ( CLK : in  STD_LOGIC;
           Reset : in  STD_LOGIC;
           Out_Modifier : in  STD_LOGIC_VECTOR (3 downto 0);
           nCWP : in  STD_LOGIC;
           CWP : out  STD_LOGIC;
			  icc : out  STD_LOGIC_VECTOR (3 downto 0);
			  carry: out STD_LOGIC);
end Component;

Component MultiplexorPC is
    Port ( Disp30 : in  STD_LOGIC_VECTOR (31 downto 0);
           Disp22 : in  STD_LOGIC_VECTOR (31 downto 0);
           PC1 : in  STD_LOGIC_VECTOR (31 downto 0);
           Direccion : in  STD_LOGIC_VECTOR (31 downto 0);
           Selector : in  STD_LOGIC_VECTOR (1 downto 0);
			  Direccion_Out : out  STD_LOGIC_VECTOR (31 downto 0));
end Component;

Component DataMemory is
    Port ( CLK : in  STD_LOGIC;
           HabilitadorMem : in  STD_LOGIC;
           Reset : in  STD_LOGIC;
           Crd : in  STD_LOGIC_VECTOR (31 downto 0);
           Direccion : in  STD_LOGIC_VECTOR (31 downto 0);
           HabilitadorEscritura : in  STD_LOGIC;
           DatoMemoria : out  STD_LOGIC_VECTOR (31 downto 0));
end Component;

Component Multiplexor_Register is
    Port ( DatoMemoria_Out : in  STD_LOGIC_VECTOR (31 downto 0);
           Alu_Out : in  STD_LOGIC_VECTOR (31 downto 0);
           Pc_Out : in  STD_LOGIC_VECTOR (31 downto 0);
           Selector : in  STD_LOGIC_VECTOR (1 downto 0);
           DataToreg : out  STD_LOGIC_VECTOR (31 downto 0));
end Component;

signal In_nPC: STD_LOGIC_VECTOR (31 downto 0) := (others => '0');
signal In_PC, Direccion, Sum0_Out, Instr, Out_Mux3, Out_R1, Out_R2, Out_RD, Sum1_Out: STD_LOGIC_VECTOR (31 downto 0);
signal Exp13, Exp22, Exp30, Out_Mux1, Sum2_Out, Alu_Out, DatoMem: STD_LOGIC_VECTOR (31 downto 0);
signal window, next_window, Select_Mux0, HabMem, WriteMem, WriteRF, acarreo: STD_LOGIC:= '0';
signal In_rs1, In_rs2, In_rd, Out_o7, Out_Mux0, In_Alu: STD_LOGIC_VECTOR (5 downto 0);
signal nzvc, siguiente: STD_LOGIC_VECTOR (3 downto 0);
signal Select_Mux2, Select_Mux3: STD_LOGIC_VECTOR (1 downto 0);

begin

nPC: Program_Counter
	port map( CLK => CLK,
				 Entrada => In_nPC,
				 reset => Reset,
				 Salida => In_PC
				);
				
PC: Program_Counter
	port map( CLK => CLK,
				 Entrada => In_PC,
				 reset => Reset,
				 Salida => Direccion
				);
				
Sum0: Sumador
	port map( Op1 => "00000000000000000000000000000001",
				 Op2 => In_Pc,
				 Salida => Sum0_Out
				);
				
IM: InstructionMemory
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
             nrd => In_rd,
             ro7 => Out_o7
				);
				
Extension22: SEU_22B
	port map( Imm22 => Instr(21 downto 0),
             Out_Imm32 => Exp22
				);
				
Extension30: SEU_30
	port map( Imm30 => Instr(29 downto 0),
             Out_Imm32 => Exp30
				 );

UC: UnidadControl
	port map( op => Instr(31 downto 30),
             op3 => Instr(24 downto 19),
             op2 => Instr(24 downto 22),
             cond => Instr(28 downto 25),
             icc => siguiente,
             HabilitadorMemoria => HabMem,
             Rfdest => Select_Mux0,
             Rfsource => Select_Mux3,
             Pcsource => Select_Mux2,
             EscrituraMem => WriteMem,
             EscrituraRF => WriteRF,
             Aluop => In_Alu
				);

Mux0: Mux_RF
	port map( Rd => In_rd,
             Ro7 => Out_o7,
             Rfdest => Select_Mux0,
             mRd => Out_Mux0
				);
				
RF: RegisterFile
	port map( Reset => Reset,
             Rs1 => In_rs1,
             Rs2 => In_rs2,
             Rd => Out_Mux0,
             Escritura => WriteRF,
             DatoEscritura => Out_Mux3,
             Crs1 => Out_R1,
             Crs2 => Out_R2,
             Crd => Out_RD
				);
			
Extension13: SEU_13
	port map( Imm13 => Instr(12 downto 0),
             Out_Imm32 => Exp13 
				);

Mux1: MultiplexorAlu
	port map( Entrada1 => Out_R2,
             Entrada2 => Exp13,
             Selector => Instr(13),
             Salida => Out_Mux1
				);

Sum1: Sumador
	port map( Op1 => Direccion,
				 Op2 => Exp22,
				 Salida => Sum1_Out
				);

Sum2: Sumador
	port map( Op1 => Direccion,
				 Op2 => Exp30,
				 Salida => Sum2_Out
				);

PSR_M: PSR_Modifier
	port map( rs1 => Out_R1(31),
             oper2 => Out_Mux1(31),
             rst => Reset,
             Aluop => In_Alu,
             AluResult => Alu_Out,
             Salida => nzvc
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
			 
ALU0: Alu
	port map( Op1 => Out_R1,
             Op2 => Out_Mux1,
             Selector => In_Alu, 
             Carry => acarreo,
             Salida => Alu_Out
				);

Mux2: MultiplexorPC
	port map( Disp30 => Sum2_Out,
				 Disp22 => Sum1_Out,
             PC1 => Sum0_Out,
             Direccion => Alu_Out,
             Selector => Select_Mux2,
			    Direccion_Out => In_nPC
				);
				
DM: DataMemory
	port map( CLK => CLK,
             HabilitadorMem => HabMem,
             Reset => Reset,
             Crd => Out_RD,
             Direccion => Alu_Out,
             HabilitadorEscritura => WriteMem,
             DatoMemoria => DatoMem
				);
				
Mux3: Multiplexor_Register
	port map( DatoMemoria_Out => DatoMem,
             Alu_Out => Alu_Out,
             Pc_Out => Direccion,
             Selector => Select_Mux3,
             DataToreg => Out_Mux3
				);

Alup_Result <= Out_Mux3;

end Behavioral;

