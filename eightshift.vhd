LIBRARY ieee;
USE ieee.std_logic_1164.all ;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

ENTITY eightshift IS 
PORT ( 
       D           : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 O           : OUT STD_LOGIC_VECTOR(15 DOWNTO 0));
		
END eightshift ; 

ARCHITECTURE behavior OF eightshift IS 

 
BEGIN 
		O(0)<= '0' ;
		O(1)<= '0' ;
		O(2)<= '0' ;
		O(3)<= '0' ;
		O(4)<= '0' ;
		O(5)<= '0' ;
		O(6)<= '0' ;
		O(7)<= '0' ; 
		O(8)<=  D(0) ; 
		O(9)<=  D(1) ;
		O(10)<= D(2) ; 
		O(11)<= D(3) ; 
		O(12)<= D(4) ;
		O(13)<= D(5) ;
		O(14)<= D(6) ; 
		O(15)<= D(7) ; 
		
end behavior ;
 