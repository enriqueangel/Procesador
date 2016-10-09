library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Multiplexor is
    Port ( Entrada1 : in  STD_LOGIC_VECTOR (31 downto 0);
           Entrada2 : in  STD_LOGIC_VECTOR (31 downto 0);
           Selector : in  STD_LOGIC;
           Salida : out  STD_LOGIC_VECTOR (31 downto 0));
end Multiplexor;

architecture Behavioral of Multiplexor is

begin
	process(Entrada1, Entrada2, Selector)
	begin
		if(Selector = '0') then
			Salida <= Entrada1;
		else
			Salida <= Entrada2;
		end if;
	end process;
end Behavioral;

