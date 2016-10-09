LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY UC_TB IS
END UC_TB;
 
ARCHITECTURE behavior OF UC_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT UC
    PORT(
         Op : IN  std_logic_vector(1 downto 0);
         Op3 : IN  std_logic_vector(5 downto 0);
         Out_Aloup : OUT  std_logic_vector(5 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Op : std_logic_vector(1 downto 0) := (others => '0');
   signal Op3 : std_logic_vector(5 downto 0) := (others => '0');

 	--Outputs
   signal Out_Aloup : std_logic_vector(5 downto 0);

 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: UC PORT MAP (
          Op => Op,
          Op3 => Op3,
          Out_Aloup => Out_Aloup
        );

 

   -- Stimulus process
   stim_proc: process
   begin		
	
		Op <= "10";
		Op3 <= "000000";
		wait for 100 ns;
		
		Op3 <= "000101";
		wait for 100 ns;
		
		Op3 <= "000100";
		wait for 100 ns;
		
		Op3 <= "000110";
		wait for 100 ns;

      wait;
   end process;

END;
