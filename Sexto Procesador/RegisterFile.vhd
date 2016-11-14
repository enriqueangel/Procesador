library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity RegisterFile is
    Port ( Reset : in  STD_LOGIC;
           Rs1 : in  STD_LOGIC_VECTOR (5 downto 0);
           Rs2 : in  STD_LOGIC_VECTOR (5 downto 0);
           Rd : in  STD_LOGIC_VECTOR (5 downto 0);
           Escritura : in  STD_LOGIC;
           DatoEscritura : in  STD_LOGIC_VECTOR (31 downto 0);
           Crs1 : out  STD_LOGIC_VECTOR (31 downto 0);
           Crs2 : out  STD_LOGIC_VECTOR (31 downto 0);
           Crd : out  STD_LOGIC_VECTOR (31 downto 0));
end RegisterFile;

architecture Behavioral of RegisterFile is

type ram_type is array (0 to 39) of std_logic_vector (31 downto 0);
signal registerf : ram_type :=(others => x"00000000");

begin
	process(Reset, Rs1, Rs2, Rd, Escritura, DatoEscritura)
begin 
	
	if(Reset = '1') then
		Crs1 <= (others => '0');
		Crs2 <= (others => '0');
		Crd <= (others => '0');
		registerf <= (others => x"00000000");
		
	else
		Crs1 <= registerf(conv_integer(Rs1));
		Crs2 <= registerf(conv_integer(Rs2));
		Crd <= registerf(conv_integer(Rd));
		
		if(Escritura = '1' and Rd /= "000000") then
			registerf(conv_integer(Rd)) <= DatoEscritura;
		end if;
	end if;
end process;
end Behavioral;

