library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity IRregister is
   generic (w : INTEGER := 8);
          Port ( RST, LOAD : in STD_LOGIC;
          clk : in STD_LOGIC;
            D : in STD_LOGIC_VECTOR(w-1 DOWNTO 0);
            O : out STD_LOGIC_VECTOR(w-1 DOWNTO 0));
end IRregister;


architecture Behavioral of IRregister is
begin
    p1: process(clk)
    begin
        if (clk'EVENT AND clk='1') then
            for i in w-1 downto 0 loop
               if RST='1' then
                   O(i) <= '0';
               elsif LOAD='1' then
                   O(i) <= D(i);
               end if;
            end loop;
         end if;
    end process p1;
end Behavioral;