library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity DataMemory is
    Port ( CLK : in  STD_LOGIC;
           HabilitadorMem : in  STD_LOGIC;
           Reset : in  STD_LOGIC;
           Crd : in  STD_LOGIC_VECTOR (31 downto 0);
           Direccion : in  STD_LOGIC_VECTOR (31 downto 0);
           HabilitadorEscritura : in  STD_LOGIC;
           DatoMemoria : out  STD_LOGIC_VECTOR (31 downto 0));
end DataMemory;

architecture Behavioral of DataMemory is

type ram_type is array (0 to 63) of std_logic_vector (31 downto 0);
signal ramMemory : ram_type:=(others => x"00000000");

begin
	process(CLK, HabilitadorMem, Reset, Crd, Direccion, HabilitadorEscritura)
begin
	
	if(Reset = '1') then
		DatoMemoria <= (others => '0');
		ramMemory <= (others => x"00000000");
	
	else
		if(rising_edge(CLK)) then
			if(HabilitadorMem = '1') then
				if(HabilitadorEscritura = '0') then
					DatoMemoria <= ramMemory(conv_integer(Direccion(5 downto 0)));
				else
					ramMemory(conv_integer(Direccion(5 downto 0))) <= Crd;
				end if;
			end if;
		end if;
	end if;
end process;

end Behavioral;

