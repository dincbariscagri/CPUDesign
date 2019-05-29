library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity PC is

Port ( reset,PCwrite,clk : in STD_LOGIC;
	   data : in STD_LOGIC_VECTOR (9 downto 0);
	   counterout,pcplusone : out STD_LOGIC_VECTOR ( 9 downto 0 )
	 );
	
	end PC ; 
	
architecture behaviour of PC is
signal values : STD_LOGIC_VECTOR(9 downto 0);
begin
	counterout <= values;
	pcplusone <= values + 2 ;
	process(clk, reset, data,PCwrite)
	begin
		if reset = '1' then
			values <= "0000000000";
			 
		elsif clk'event and clk='1' then
			if PCwrite ='1' then
			values <= data;
			
		end if;
		end if;
		
		end process;
end behaviour;