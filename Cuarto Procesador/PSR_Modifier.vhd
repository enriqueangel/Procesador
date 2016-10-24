library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity PSR_Modifier is
    Port ( rs1 : in  STD_LOGIC;
           oper2 : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           Aluop : in  STD_LOGIC_VECTOR (5 downto 0);
           AluResult : in  STD_LOGIC_VECTOR (31 downto 0);
           Salida : out  STD_LOGIC_VECTOR (3 downto 0));
end PSR_Modifier;

architecture Behavioral of PSR_Modifier is

begin
process(rs1, oper2, rst, Aluop, AluResult)
begin
	
	if(rst = '1') then
		Salida <= "0000";
	else
		if(Aluop = "001001" or Aluop = "001010") then --sumacc o suma carrycc
		
			Salida(3) <= AluResult(31);
			
			if(AluResult = X"00000000") then
				Salida(2) <= '1';
			else
				Salida(2) <= '0';
			end if;
			
			Salida(1) <= (rs1 and oper2 and (not AluResult(31))) or ((not rs1) and (not oper2) and AluResult(31));
			
			Salida(0) <= (rs1 and oper2) or ((not AluResult(31)) and (rs1 or oper2));
			
		else
		
			if(Aluop = "001100" or Aluop = "001101") then --restacc o resta carrycc
			
				Salida(3) <= AluResult(31);
				
				if(AluResult = X"00000000") then
					Salida(2) <= '1';
				else
					Salida(2) <= '0';
				end if;
				
				Salida(1) <= (rs1 and (not oper2) and (not AluResult(31))) or ((not rs1) and oper2 and AluResult(31));
				
				Salida(0) <= ((not rs1) and oper2) or (AluResult(31) and ((not rs1) or oper2));
			
			else
		
				if(Aluop = "001110" or Aluop = "001111" or Aluop = "010000" or Aluop = "010001" or Aluop = "010010" or Aluop = "010011") then
				--ANDcc,NANDcc,ORcc,NORcc,XORcc,XNORcc
				
					Salida(3) <= AluResult(31);
					
					if(AluResult = X"00000000") then
						Salida(2) <= '1';
					else
						Salida(2) <= '0';
					end if;
					
					Salida(1) <= '0';
					
					Salida(0) <= '0';
				
				end if;
			end if;
		end if;
	end if;
end process;

end Behavioral;

