library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SEU_30B is
    Port ( Imm30 : in  STD_LOGIC_VECTOR (29 downto 0);
           Out_Imm32 : out  STD_LOGIC_VECTOR (31 downto 0));
end SEU_30B;

architecture Behavioral of SEU_30B is

signal compara : STD_LOGIC := '0';
begin
process(Imm30, compara)
begin
	compara <= Imm30(29);
	
	if(compara = '0') then
		Out_Imm32(31 downto 30) <= (others => '0');
		Out_Imm32(29 downto 0) <= Imm30;
	end if;
	if(compara = '1') then
		Out_Imm32(31 downto 30) <= (others => '1');
		Out_Imm32(29 downto 0) <= Imm30;
		
	end if;
end process;

end Behavioral;

