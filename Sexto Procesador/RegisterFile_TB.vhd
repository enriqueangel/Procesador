LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY RegisterFile_TB IS
END RegisterFile_TB;
 
ARCHITECTURE behavior OF RegisterFile_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT RegisterFile
    PORT(
         Reset : IN  std_logic;
         Rs1 : IN  std_logic_vector(5 downto 0);
         Rs2 : IN  std_logic_vector(5 downto 0);
         Rd : IN  std_logic_vector(5 downto 0);
         Escritura : IN  std_logic;
         DatoEscritura : IN  std_logic_vector(31 downto 0);
         Crs1 : OUT  std_logic_vector(31 downto 0);
         Crs2 : OUT  std_logic_vector(31 downto 0);
         Crd : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Reset : std_logic := '0';
   signal Rs1 : std_logic_vector(5 downto 0) := (others => '0');
   signal Rs2 : std_logic_vector(5 downto 0) := (others => '0');
   signal Rd : std_logic_vector(5 downto 0) := (others => '0');
   signal Escritura : std_logic := '0';
   signal DatoEscritura : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal Crs1 : std_logic_vector(31 downto 0);
   signal Crs2 : std_logic_vector(31 downto 0);
   signal Crd : std_logic_vector(31 downto 0);

 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: RegisterFile PORT MAP (
          Reset => Reset,
          Rs1 => Rs1,
          Rs2 => Rs2,
          Rd => Rd,
          Escritura => Escritura,
          DatoEscritura => DatoEscritura,
          Crs1 => Crs1,
          Crs2 => Crs2,
          Crd => Crd
        );

   -- Stimulus process
	stim_proc: process
   begin
	  Rs1 <= "011110";
	  Rs2 <= "000000";
	  wait for 100 ns;
	  
	  Rd <= "011111";
	  Escritura <= '1';
	  DatoEscritura <= x"00000001";
	  wait for 100 ns;
	  
	  Rd <= "011111";
	  Escritura <= '0';
	  DatoEscritura <= x"10000001";
	  wait for 100 ns;
	  
	  Rs1 <= "011111";
	  Rs2 <= "000001";
	  Rd <= "000000";
	  wait for 100 ns;
	  
	  Reset <= '1';
	  wait for 100 ns;
	  
	  Rs1 <= "011110";
	  Rs2 <= "000000";
	  Reset <= '0';
	  wait for 100 ns;
	  
	  wait;
   end process;

END;
