LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY DataMemory_TB IS
END DataMemory_TB;
 
ARCHITECTURE behavior OF DataMemory_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT DataMemory
    PORT(
         CLK : IN  std_logic;
         HabilitadorMem : IN  std_logic;
         Reset : IN  std_logic;
         Crd : IN  std_logic_vector(31 downto 0);
         Direccion : IN  std_logic_vector(31 downto 0);
         HabilitadorEscritura : IN  std_logic;
         DatoMemoria : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal CLK : std_logic := '0';
   signal HabilitadorMem : std_logic := '0';
   signal Reset : std_logic := '0';
   signal Crd : std_logic_vector(31 downto 0) := (others => '0');
   signal Direccion : std_logic_vector(31 downto 0) := (others => '0');
   signal HabilitadorEscritura : std_logic := '0';

 	--Outputs
   signal DatoMemoria : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 20 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: DataMemory PORT MAP (
          CLK => CLK,
          HabilitadorMem => HabilitadorMem,
          Reset => Reset,
          Crd => Crd,
          Direccion => Direccion,
          HabilitadorEscritura => HabilitadorEscritura,
          DatoMemoria => DatoMemoria
        );

   -- Clock process definitions
   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
	Reset <= '1';
	wait for 100 ns;
	Reset <= '0';
	HabilitadorMem <= '1';
	HabilitadorEscritura <= '1';
	Direccion <= "00000000000000000000000000000001";
	Crd <= "00000000000000000000000000001111";
	wait for 100 ns;
	HabilitadorMem <= '0';
	HabilitadorEscritura <= '1';
	Direccion <= "00000000000000000000000000000001";
	wait for 100 ns;
	HabilitadorMem <= '1';
	HabilitadorEscritura <= '0';
	Direccion <= "00000000000000000000000000000001";
	wait for 100 ns;
	
      -- insert stimulus here 

      wait;
   end process;

END;
