LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY SEU_30B_TB IS
END SEU_30B_TB;
 
ARCHITECTURE behavior OF SEU_30B_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT SEU_30B
    PORT(
         Imm30 : IN  std_logic_vector(29 downto 0);
         Out_Imm32 : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Imm30 : std_logic_vector(29 downto 0) := (others => '0');

 	--Outputs
   signal Out_Imm32 : std_logic_vector(31 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: SEU_30B PORT MAP (
          Imm30 => Imm30,
          Out_Imm32 => Out_Imm32
        );
 

   -- Stimulus process
   stim_proc: process
   begin		
	
      Imm30 <= "010101010101010101010101010101";
      wait for 100 ns;	
		
		Imm30 <= "111111111111111111111111111111";
      wait for 100 ns;

      wait;
   end process;

END;
