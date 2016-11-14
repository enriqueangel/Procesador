library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Program_Counter is
    Port ( CLK: in STD_LOGIC;
		     Entrada : in  STD_LOGIC_VECTOR (31 downto 0);
			  reset: in STD_LOGIC;
           Salida : out  STD_LOGIC_VECTOR (31 downto 0));
end Program_Counter;

architecture Behavioral of Program_Counter is

signal out_program: STD_LOGIC_VECTOR (31 downto 0) := (others => '0');

begin
process(CLK,reset,Entrada,out_program)
begin

	if(reset = '1') then
		out_program <= (others => '0');
	else
		if(rising_edge(CLK)) then
			out_program <= Entrada;
		end if;
	end if;
Salida <= out_program;
end process;

end Behavioral;

