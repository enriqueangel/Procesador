LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY Program_Counter_TB IS
END Program_Counter_TB;
 
ARCHITECTURE behavior OF Program_Counter_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Program_Counter
    PORT(
         CLK : IN  std_logic;
         Entrada : IN  std_logic_vector(31 downto 0);
         reset : IN  std_logic;
         Salida : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal CLK : std_logic := '0';
   signal Entrada : std_logic_vector(31 downto 0) := (others => '0');
   signal reset : std_logic := '0';

 	--Outputs
   signal Salida : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 20 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Program_Counter PORT MAP (
          CLK => CLK,
          Entrada => Entrada,
          reset => reset,
          Salida => Salida
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
      reset <= '0';
		Entrada <= "00000000000000001111111111111111";
		wait for 100 ns;
		
		reset <= '1';
		Entrada <= "00000000000000001111111111111110";
		wait for 100 ns;
		
		reset <= '0';
		Entrada <= "10000000000000001111111111111111";
		wait for 100 ns;
		
		reset <= '1';
		Entrada <= "00000000000000001111111111111111";
		wait for 100 ns;
		

      wait;
   end process;

END;
