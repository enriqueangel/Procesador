LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY RegisterFile_TB IS
END RegisterFile_TB;
 
ARCHITECTURE behavior OF RegisterFile_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT RegisterFile
    PORT(
         rs1 : IN  std_logic_vector(5 downto 0);
         rs2 : IN  std_logic_vector(5 downto 0);
         rd : IN  std_logic_vector(5 downto 0);
         DataWrite : IN  std_logic_vector(31 downto 0);
         rst : IN  std_logic;
         Crs1 : OUT  std_logic_vector(31 downto 0);
         Crs2 : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal rs1 : std_logic_vector(5 downto 0) := (others => '0');
   signal rs2 : std_logic_vector(5 downto 0) := (others => '0');
   signal rd : std_logic_vector(5 downto 0) := (others => '0');
   signal DataWrite : std_logic_vector(31 downto 0) := (others => '0');
   signal rst : std_logic := '0';

 	--Outputs
   signal Crs1 : std_logic_vector(31 downto 0);
   signal Crs2 : std_logic_vector(31 downto 0);

 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: RegisterFile PORT MAP (
          rs1 => rs1,
          rs2 => rs2,
          rd => rd,
          DataWrite => DataWrite,
          rst => rst,
          Crs1 => Crs1,
          Crs2 => Crs2
        );

 

   -- Stimulus process
   stim_proc: process
   begin		
     
	  rs1 <= "011110";
	  rs2 <= "000000";
	  wait for 100 ns;
	  
	  rd <= "011111";
	  DataWrite <= x"00000001";
	  wait for 20 ns;
	  
	  rd <= "000001";
	  DataWrite <= x"10000001";
	  wait for 20 ns;
	  
	  rs1 <= "011111";
	  rs2 <= "000001";
	  rd <= "000000";
	  wait for 100 ns;
	  
	  rst <= '1';
	  wait for 100 ns;
	  
	  rs1 <= "011110";
	  rs2 <= "000000";
	  rst <= '0';
	  wait for 100 ns;
	  

      wait;
   end process;

END;
