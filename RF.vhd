library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity RF is
   generic (l : INTEGER := 8; -- l: number of registers in RF
            w : INTEGER := 8; -- w: register width (or # bits in a register)
            m : INTEGER := 3); -- m: # bits in register address
 
 
 Port ( RST, WE : in STD_LOGIC;
      SrcAdrA, SrcAdrB, DstAdr : in STD_LOGIC_VECTOR(m-1 DOWNTO 0);
      clk : in STD_LOGIC;
      DataIn : in STD_LOGIC_VECTOR(w-1 DOWNTO 0);
      DataOutA, DataOutB : out STD_LOGIC_VECTOR(w-1 DOWNTO 0));
end RF;


architecture Behavioral of RF is
-- following are defined for the outputs of the D-FF array
signal tmpq: std_logic_vector(w*l-1 downto 0);
-- following are the load signals for individual registers
signal load: std_logic_vector(l-1 downto 0);



component RFregister is
   Port ( RST, LOAD : in STD_LOGIC;
       clk : in STD_LOGIC;
         D : in STD_LOGIC_VECTOR(w-1 DOWNTO 0);
         O : out STD_LOGIC_VECTOR(w-1 DOWNTO 0));
end component;


begin
-- Generation of correct number of registers:
  genreg1: for i in l-1 downto 0 generate begin
             registers: RFregister port map(
                RST => RST,
                LOAD => load(i),
                clk => clk,
                D => DataIn(w-1 DOWNTO 0),
                O => tmpq((i+1)*w-1 DOWNTO i*w)
     );
  end generate genreg1;


-- Parameterized DstAdr Decoder:
p1: process (WE, DstAdr) begin
for i in l-1 downto 0 loop
if ((i=conv_integer('0'&DstAdr)) AND (WE='1')) then
load(i) <= '1';
else
load(i) <= '0';
end if;
end loop;
end process p1;


-- Parameterized SrcAdrA MUX:
p2: process (SrcAdrA) begin
for i in l-1 downto 0 loop
if i=conv_integer('0'&SrcAdrA) then
DataOutA <= tmpq((i+1)*w-1 DOWNTO i*w);
end if;
end loop;
end process p2;


-- Parameterized SrcAdrB MUX:
p3: process (SrcAdrB) begin
for i in l-1 downto 0 loop
if i=conv_integer('0'&SrcAdrB) then
DataOutB <= tmpq((i+1)*w-1 DOWNTO i*w);
end if;
end loop;
end process p3;
end Behavioral;