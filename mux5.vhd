library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity mux5 is 
	port(
	 	A, B	,C			: in std_logic_vector(7 downto 0);
		output			: out std_logic_vector(7 downto 0);
		Selectbits		: in std_logic_vector(2 downto 0)
		);
end mux5;
		
		
architecture selector of mux5 is 
begin
		process(Selectbits)
		begin
			case Selectbits is
				
				when "000" => output <= "00000000";
					
				when "001" => output <= "11111111";
					
				when "010" => output <= A;
			
				when "011" => output <= B;
				
				when "100" => output <= C;
				
				when others =>
				
			end case;
		end process;
end selector;

