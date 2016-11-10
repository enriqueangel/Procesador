library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity PSR is
    Port ( CLK : in  STD_LOGIC;
           Reset : in  STD_LOGIC;
           Out_Modifier : in  STD_LOGIC_VECTOR (3 downto 0);
           nCWP : in  STD_LOGIC;
           CWP : out  STD_LOGIC;
			  icc : out  STD_LOGIC_VECTOR (3 downto 0);
			  carry: out STD_LOGIC);
end PSR;

architecture Behavioral of PSR is

begin
process(CLK, Reset, Out_Modifier, nCWP)
begin
	
	if(Reset = '1') then
		CWP <= '0';
		icc <= "0000";
		carry <= '0';
		
	else
		if(rising_edge(CLK)) then
			CWP <= nCWP;
			icc <= Out_Modifier;
			carry <= Out_Modifier(0);
		end if;
	end if;
end process;

end Behavioral;

