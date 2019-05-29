library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.STD_LOGIC_SIGNED.ALL;

entity mux4to1 is 
	port(
	 	A, B, C, D		: in std_logic_vector(7 downto 0);
		output			: out std_logic_vector(7 downto 0);
		Selectbits		: in std_logic_vector(2 downto 0)
		);
end mux4to1;
		
		
architecture selector of mux4to1 is 
begin
		process(Selectbits)
		begin
			case Selectbits is
				
				when "000" => output <= A;
					
				when "001" => output <= B;
					
				when "010" => output <= C;
			
				when "011" => output <= D;
				
				when "100" => output <= "11111111";
				
				when "101" => output <= "00000000";
				
				when "111" => output <= not(A)+1;
				
				when others =>
				
			end case;
		end process;
end selector;


	