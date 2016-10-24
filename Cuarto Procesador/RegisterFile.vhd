library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity RegisterFile is
    Port ( rs1 : in  STD_LOGIC_VECTOR (5 downto 0);
           rs2 : in  STD_LOGIC_VECTOR (5 downto 0);
           rd : in  STD_LOGIC_VECTOR (5 downto 0);
           DataWrite : in  STD_LOGIC_VECTOR (31 downto 0);
			  rst : in  STD_LOGIC;
           Crs1 : out  STD_LOGIC_VECTOR (31 downto 0);
           Crs2 : out  STD_LOGIC_VECTOR (31 downto 0));
end RegisterFile;

architecture Behavioral of RegisterFile is

	
type ram_type is array (0 to 39) of std_logic_vector (31 downto 0);
signal registerf : ram_type :=(others => x"00000000");

begin
process(rs1, rs2, rd, DataWrite, rst)
begin
	
	if(rst = '1') then
		Crs1 <= (others => '0');
		Crs2 <= (others => '0');
		registerf <= (others => x"00000000");
		
	else
		Crs1 <= registerf(conv_integer(rs1));
		Crs2 <= registerf(conv_integer(rs2));
		
		if(rd /= "000000") then
			registerf(conv_integer(rd)) <= DataWrite;
		
		end if;
	
	end if;
	
end process;

end Behavioral;

