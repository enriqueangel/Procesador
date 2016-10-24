library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity UC is
    Port ( Op : in  STD_LOGIC_VECTOR (1 downto 0);
           Op3 : in  STD_LOGIC_VECTOR (5 downto 0);
           Out_Aloup : out  STD_LOGIC_VECTOR (5 downto 0));
end UC;

architecture Behavioral of UC is

begin
process(Op, Op3)
begin

	if(Op = "10") then --Arit log
		
		case Op3 is
			when "000000" => Out_Aloup <= "000000"; --suma
			when "000100" => Out_Aloup <= "000001"; --resta
			when "000001" => Out_Aloup <= "000010"; --and
			when "000010" => Out_Aloup <= "000011"; --or
			when "000011" => Out_Aloup <= "000100"; --xor
			when "000111" => Out_Aloup <= "000101"; --xnor
			when "000101" => Out_Aloup <= "000110"; --nand
			when "000110" => Out_Aloup <= "000111"; --nor
			when "001000" => Out_Aloup <= "001000"; --suma con carry
			when "010000" => Out_Aloup <= "001001"; --sumacc
			when "011000" => Out_Aloup <= "001010"; --suma con carrycc
			when "001100" => Out_Aloup <= "001011"; --resta con carry
			when "010100" => Out_Aloup <= "001100"; --restacc
			when "011100" => Out_Aloup <= "001101"; --resta con carrycc
			when "010001" => Out_Aloup <= "001110"; --andcc
			when "010101" => Out_Aloup <= "001111"; --nandcc
			when "010010" => Out_Aloup <= "010000"; --orcc
			when "010110" => Out_Aloup <= "010001"; --norcc
			when "010011" => Out_Aloup <= "010010"; --xorcc
			when "010111" => Out_Aloup <= "010011"; --xnorcc
			when "100101" => Out_Aloup <= "010100"; --corrimiento izquierdo
			when "100110" => Out_Aloup <= "010101"; --corrimiento derecho
			--Especiales se dejaron igual
			when "111100" => Out_Aloup <= "111100"; --save
			when "111101" => Out_Aloup <= "111101"; --restore
			when others => Out_Aloup <= "111111";
		
		end case;
	end if;
end process;
		

end Behavioral;

