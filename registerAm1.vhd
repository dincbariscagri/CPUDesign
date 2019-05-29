LIBRARY ieee;
USE ieee.std_logic_1164.all ;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

ENTITY registerAm1 IS 
PORT ( RST,LDAmsb,Ain  : IN STD_LOGIC ;
  		 Clk         : IN STD_LOGIC; 
	    Qm1out        : BUFFER STD_LOGIC);

END registerAm1 ; 

ARCHITECTURE behavior OF registerAm1 IS 

BEGIN 
  
  PROCESS(Clk,RST,LDAmsb)
  BEGIN
 
  IF(RST='0') Then 
	  IF(Clk 'EVENT and Clk='1') Then 
	     IF(LDAmsb='1') Then 
		  Qm1out <= Ain ;
		  
			ELSE
			Qm1out <= Qm1out;
			END IF;
	  END IF ;  
  ELSIF(RST='1') Then
  Qm1out <= '0' ; 
  
  END IF ;
  END PROCESS ;
END behavior ; 
		  