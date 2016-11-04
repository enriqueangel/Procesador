library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SEU_22B is
    Port ( Imm22 : in  STD_LOGIC_VECTOR (21 downto 0);
           Out_Imm32 : out  STD_LOGIC_VECTOR (31 downto 0));
end SEU_22B;

architecture Behavioral of SEU_22B is

signal compara : STD_LOGIC := '0';
begin
process(Imm22, compara)
begin
	compara <= Imm22(21);
	
	if(compara = '0') then
		Out_Imm32(31 downto 22) <= (others => '0');
		Out_Imm32(21 downto 0) <= Imm22;
	end if;
	if(compara = '1') then
		Out_Imm32(31 downto 22) <= (others => '1');
		Out_Imm32(21 downto 0) <= Imm22;
		
	end if;
end process;

end Behavioral;

