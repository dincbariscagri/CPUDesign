library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity mux4withzeroone is 
	port(
	 	A, B				: in std_logic_vector(7 downto 0);
		output			: out std_logic_vector(7 downto 0);
		Selectbits		: in std_logic_vector(1 downto 0)
		);
end mux4withzeroone;
		
		
architecture selector of mux4withzeroone is 
begin
		process(Selectbits)
		begin
			case Selectbits is
				
				when "00" => output <= "00000000";
					
				when "01" => output <= "11111111";
					
				when "10" => output <= A;
			
				when "11" => output <= B;
				
				when others =>
				
			end case;
		end process;
end selector;


	