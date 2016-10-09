LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY Sumador_TB IS
END Sumador_TB;
 
ARCHITECTURE behavior OF Sumador_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Sumador
    PORT(
         Op1 : IN  std_logic_vector(31 downto 0);
         Op2 : IN  std_logic_vector(31 downto 0);
         Salida : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Op1 : std_logic_vector(31 downto 0) := (others => '0');
   signal Op2 : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal Salida : std_logic_vector(31 downto 0);
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Sumador PORT MAP (
          Op1 => Op1,
          Op2 => Op2,
          Salida => Salida
        );

   -- Stimulus process
   stim_proc: process
   begin		
      
		Op1 <= "00000000000000000000000000000001";
		Op2 <= "00000000000000001111111111111111";
      wait for 100 ns;	
		
		Op1 <= "00000000000000000000000000000000";
		Op2 <= "00000000000000000000000000000000";
      wait for 100 ns;	
		
		Op1 <= "11111111111111111111111111111111";
		Op2 <= "11111111111111111111111111111111";
      wait for 100 ns;	

      wait;
   end process;

END;
