library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ByteSelector is
    Port ( SEL : in  STD_LOGIC;
           DataNew   	: in  STD_LOGIC_VECTOR(7 downto 0);
           DataOld   	: in  STD_LOGIC_VECTOR(7 downto 0);
           CombinedData : out STD_LOGIC_VECTOR(15 downto 0));
end ByteSelector ;

architecture Behavioral of ByteSelector is
begin
    process(SEL)
		begin
			case SEL is
				
				when '0' => 
				
				CombinedData(7 downto 0) <= DataNew;
				CombinedData(15 downto 8) <= DataOld;
					
				when '1' => 
				
				CombinedData(15 downto 8) <= DataNew;
				CombinedData(7 downto 0) <= DataOld;
				
				when others =>
				
			end case;
		end process;
end Behavioral;