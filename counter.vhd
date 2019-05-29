library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity counter is
   port( 
 	 Clock: in std_logic;
 	 CountReset: in std_logic;
	 Enable:	in std_logic;
 	 Output: out std_logic_vector(3 downto 0));
end counter;
 
architecture Behavioral of counter is
   signal temp: std_logic_vector(3 downto 0);
begin   process(Clock,CountReset)
   begin
      if CountReset='0' then
         temp <= "1000";
      elsif(rising_edge(Clock) and Enable = '1') then
         
            if temp="0000" then
               temp<="1111";
            else
               temp <= temp - 1;
            end if;
         
      end if;
   end process;
   Output <= temp;
end Behavioral;