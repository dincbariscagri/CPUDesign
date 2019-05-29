library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity muxupdownByte is
    Port ( SEL : in  STD_LOGIC;
           DownByte   : in  STD_LOGIC_VECTOR(7 downto 0);
           UpByte   	: in  STD_LOGIC_VECTOR(7 downto 0);
           OutByte   : out STD_LOGIC_VECTOR(7 downto 0));
end muxupdownByte ;

architecture Behavioral of muxupdownByte is
begin
   process(SEL)
		begin
			case SEL is
				
				when '0' => OutByte <= DownByte;
					
				when '1' => OutByte <= UpByte;
				
				when others =>
				
			end case;
	end process;
end Behavioral;