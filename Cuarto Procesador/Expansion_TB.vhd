LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY Expansion_TB IS
END Expansion_TB;
 
ARCHITECTURE behavior OF Expansion_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Expansion
    PORT(
         Imm13 : IN  std_logic_vector(12 downto 0);
         Out_Imm32 : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Imm13 : std_logic_vector(12 downto 0) := (others => '0');

 	--Outputs
   signal Out_Imm32 : std_logic_vector(31 downto 0);

 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Expansion PORT MAP (
          Imm13 => Imm13,
          Out_Imm32 => Out_Imm32
        );

 

   -- Stimulus process
   stim_proc: process
   begin		
      
		Imm13 <= "0101010101010";
      wait for 100 ns;	
		
		Imm13 <= "1111111111111";
      wait for 100 ns;

      wait;
   end process;

END;
