LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY PSR_Modifier_TB IS
END PSR_Modifier_TB;
 
ARCHITECTURE behavior OF PSR_Modifier_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT PSR_Modifier
    PORT(
         rs1 : IN  std_logic;
         oper2 : IN  std_logic;
         rst : IN  std_logic;
         Aluop : IN  std_logic_vector(5 downto 0);
         AluResult : IN  std_logic_vector(31 downto 0);
         Salida : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal rs1 : std_logic := '0';
   signal oper2 : std_logic := '0';
   signal rst : std_logic := '0';
   signal Aluop : std_logic_vector(5 downto 0) := (others => '0');
   signal AluResult : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal Salida : std_logic_vector(3 downto 0);

 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: PSR_Modifier PORT MAP (
          rs1 => rs1,
          oper2 => oper2,
          rst => rst,
          Aluop => Aluop,
          AluResult => AluResult,
          Salida => Salida
        );

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
		rst <= '1';
		rs1 <= '1';
		oper2 <= '1';
		Aluop <= "001001";
		AluResult <= X"00000011";
      wait for 100 ns;
		
		--sumas
		rst <= '0';
		rs1 <= '1';
		oper2 <= '1';
		Aluop <= "001001";
		AluResult <= X"00000011";
      wait for 100 ns;
		
		rst <= '0';
		rs1 <= '1';
		oper2 <= '1';
		Aluop <= "000000";
		AluResult <= X"00000011";
      wait for 100 ns;
		
		rs1 <= '1';
		oper2 <= '1';
		Aluop <= "001010";
		AluResult <= X"00000011";
      wait for 100 ns;
		
		--restas
		rs1 <= '1';
		oper2 <= '0';
		Aluop <= "001100";
		AluResult <= X"00000011";
      wait for 100 ns;
		
		rs1 <= '0';
		oper2 <= '1';
		Aluop <= "001101";
		AluResult <= X"00000011";
      wait for 100 ns;
		
		--logicos
		rs1 <= '1';
		oper2 <= '1';
		Aluop <= "001110";
		AluResult <= X"00000011";
      wait for 100 ns;
		
		rs1 <= '1';
		oper2 <= '0';
		Aluop <= "010010";
		AluResult <= X"00000011";
      wait for 100 ns;
		
		


      -- insert stimulus here 

      wait;
   end process;

END;
