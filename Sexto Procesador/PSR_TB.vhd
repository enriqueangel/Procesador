LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY PSR_TB IS
END PSR_TB;
 
ARCHITECTURE behavior OF PSR_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT PSR
    PORT(
         CLK : IN  std_logic;
         Reset : IN  std_logic;
         Out_Modifier : IN  std_logic_vector(3 downto 0);
         nCWP : IN  std_logic;
         CWP : OUT  std_logic;
         icc : OUT  std_logic_vector(3 downto 0);
         carry : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal CLK : std_logic := '0';
   signal Reset : std_logic := '0';
   signal Out_Modifier : std_logic_vector(3 downto 0) := (others => '0');
   signal nCWP : std_logic := '0';

 	--Outputs
   signal CWP : std_logic;
   signal icc : std_logic_vector(3 downto 0);
   signal carry : std_logic;

   -- Clock period definitions
   constant CLK_period : time := 20 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: PSR PORT MAP (
          CLK => CLK,
          Reset => Reset,
          Out_Modifier => Out_Modifier,
          nCWP => nCWP,
          CWP => CWP,
          icc => icc,
          carry => carry
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
		Out_Modifier <= "1010";
		nCWP <= '1';
		wait for 100 ns;
		
		Out_Modifier <= "0000";
		nCWP <= '0';
		wait for 100 ns;
		
		Out_Modifier <= "1111";
		nCWP <= '0';
		wait for 100 ns;
		
		Out_Modifier <= "0010";
		nCWP <= '1';
		wait for 100 ns;
		
      wait;
   end process;

END;
