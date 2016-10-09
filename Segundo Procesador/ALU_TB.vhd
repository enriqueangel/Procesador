LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY ALU_TB IS
END ALU_TB;
 
ARCHITECTURE behavior OF ALU_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ALU
    PORT(
         Op1 : IN  std_logic_vector(31 downto 0);
         Op2 : IN  std_logic_vector(31 downto 0);
         Selector : IN  std_logic_vector(5 downto 0);
         Salida : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Op1 : std_logic_vector(31 downto 0) := (others => '0');
   signal Op2 : std_logic_vector(31 downto 0) := (others => '0');
   signal Selector : std_logic_vector(5 downto 0) := (others => '0');

 	--Outputs
   signal Salida : std_logic_vector(31 downto 0);
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ALU PORT MAP (
          Op1 => Op1,
          Op2 => Op2,
          Selector => Selector,
          Salida => Salida
        );

   -- Stimulus process
   stim_proc: process
   begin		
      
		Op1 <= x"0000000F";
		Op2 <= x"0000000A";
		Selector <= "000000";
		wait for 100 ns;
		
		Op1 <= x"0000000F";
		Op2 <= x"0000000A";
		Selector <= "000001";
      wait for 100 ns;
		
		Op1 <= x"0000000F";
		Op2 <= x"0000000A";
		Selector <= "000010";
		wait for 100 ns;
		
		Op1 <= x"0000000F";
		Op2 <= x"0000000A";
		Selector <= "000011";
      wait for 100 ns;	
		
		Op1 <= x"0000000F";
		Op2 <= x"0000000A";
		Selector <= "000100";
		wait for 100 ns;
		
		Op1 <= x"0000000F";
		Op2 <= x"0000000A";
		Selector <= "000101";
      wait for 100 ns;
		
		Op1 <= x"0000000F";
		Op2 <= x"0000000A";
		Selector <= "000110";
		wait for 100 ns;
		
		Op1 <= x"0000000F";
		Op2 <= x"0000000A";
		Selector <= "000111";
      wait for 100 ns;	

      wait;
   end process;

END;
