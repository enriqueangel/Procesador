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
	if(Op = "10") then
		case Op3 is
			when "000000" => Out_Aloup <= "000000";
			when "000100" => Out_Aloup <= "000001";
			when "000001" => Out_Aloup <= "000010";
			when "000010" => Out_Aloup <= "000011";
			when "000011" => Out_Aloup <= "000100";
			when "000111" => Out_Aloup <= "000101";
			when "000101" => Out_Aloup <= "000110";
			when "000110" => Out_Aloup <= "000111";
			when others => Out_Aloup <= "111111";
		end case;
	end if;
	end process;	
end Behavioral;

