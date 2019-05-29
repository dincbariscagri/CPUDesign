library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity destinationmux is 
	port(
	 	A, B , C, D				: in std_logic_vector(2 downto 0);
		output			: out std_logic_vector(2 downto 0);
		Selectbits		: in std_logic_vector(1 downto 0)
		);
end destinationmux;
		
		
architecture selector of destinationmux is 
begin
		process(Selectbits)
		begin
			case Selectbits is
				
				when "00" => output <= A;
					
				when "01" => output <= B;
					
				when "10" => output <= C;
			
				when "11" => output <= D;
				
				when others =>
				
			end case;
		end process;
end selector;


	