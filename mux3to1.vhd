library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity mux3to1 is 
	port(
	 	A, B				: in std_logic;
		output			: out std_logic;
		Selectbits		: in std_logic_vector(1 downto 0)
		);
end mux3to1;
		
		
architecture selector of mux3to1 is 
begin
		process(Selectbits)
		begin
			case Selectbits is
				
				when "00" => output <= '0';
					
				when "01" => output <= '1';
					
				when "10" => output <= A;
			
				when "11" => output <= '0';
				
				when others =>
				
			end case;
		end process;
end selector;


	