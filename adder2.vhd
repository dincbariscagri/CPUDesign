library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use ieee.std_logic_arith.all ;
use IEEE.STD_LOGIC_SIGNED.all ;


entity adder2 is 
port(
   
	A : in std_logic_vector(9 downto 0);
	B : out std_logic_vector(9 downto 0));
	
end adder2; 

architecture behavior of adder2 is 

begin 

B <= A + 1 ; 

end behavior ; 


	

