library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Expansion is
    Port ( Imm13 : in  STD_LOGIC_VECTOR (12 downto 0);
           Out_Imm32 : out  STD_LOGIC_VECTOR (31 downto 0));
end Expansion;

architecture Behavioral of Expansion is

signal compara : STD_LOGIC := '0';
begin
process(Imm13, compara)
begin
	compara <= Imm13(12);
	
	if(compara = '0') then
		Out_Imm32(31 downto 13) <= (others => '0');
		Out_Imm32(12 downto 0) <= Imm13;
	end if;
	if(compara = '1') then
		Out_Imm32(31 downto 13) <= (others => '1');
		Out_Imm32(12 downto 0) <= Imm13;
		
	end if;
end process;
end Behavioral;

