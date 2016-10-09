library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ALU is
    Port ( Op1 : in  STD_LOGIC_VECTOR (31 downto 0);
           Op2 : in  STD_LOGIC_VECTOR (31 downto 0);
           Selector : in  STD_LOGIC_VECTOR (5 downto 0);
           Salida : out  STD_LOGIC_VECTOR (31 downto 0));
end ALU;

architecture Behavioral of ALU is

begin
	process(Op1, Op2, Selector)
	begin
		case Selector is
			when "000000" => Salida <= Op1 + Op2;
			when "000001" => Salida <= Op1 - Op2;
			when "000010" => Salida <= Op1 and Op2;
			when "000011" => Salida <= Op1 or Op2;
			when "000100" => Salida <= Op1 xor Op2;
			when "000101" => Salida <= Op1 xnor Op2;
			when "000110" => Salida <= Op1 nand Op2;
			when "000111" => Salida <= Op1 nor Op2;
			when others => Salida <= (others => '0');
		end case;
	end process;
end Behavioral;

