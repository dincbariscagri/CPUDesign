LIBRARY ieee;
USE ieee.std_logic_1164.all ;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

ENTITY registerM IS 
PORT ( RST,LDM  : IN STD_LOGIC ;
       D           : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 Clk         : IN STD_LOGIC;
		 Qout        : OUT STD_LOGIC_VECTOR(7 DOWNTO 0));
END registerM ; 

ARCHITECTURE behavior OF registerM IS 
BEGIN 
  PROCESS(Clk,RST,LDM)
  BEGIN
  IF(RST='0') Then 
     IF(Clk 'EVENT and Clk='1') Then 
	     IF(LDM='1') Then 
		  Qout <= D ; 
		  END IF ; 
	  END IF ;  
  ELSIF(RST='1') Then
  Qout <= "00000000" ; 
  END IF ;
  END PROCESS ;
END behavior ; 
		  