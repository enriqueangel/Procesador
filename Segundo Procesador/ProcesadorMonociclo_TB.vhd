LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY ProcesadorMonociclo_TB IS
END ProcesadorMonociclo_TB;
 
ARCHITECTURE behavior OF ProcesadorMonociclo_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ProcesadorMonociclo
    PORT(
         CLK : IN  std_logic;
         Reset : IN  std_logic;
         Alup_Result : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal CLK : std_logic := '0';
   signal Reset : std_logic := '0';

 	--Outputs
   signal Alup_Result : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 20 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ProcesadorMonociclo PORT MAP (
          CLK => CLK,
          Reset => Reset,
          Alup_Result => Alup_Result
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
      -- hold reset state for 100 ns.
		Reset <= '1';
		wait for 1 ms;
		Reset <= '0';

      -- insert stimulus here 

      wait;
   end process;

END;
