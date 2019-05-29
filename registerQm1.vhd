LIBRARY ieee;
USE ieee.std_logic_1164.all ;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

ENTITY registerQm1 IS 
PORT ( RST,LDQ     : IN STD_LOGIC ;
       SL , SR     : IN STD_LOGIC ; 
		 SIR         : IN STD_LOGIC ; 
  		 Clk         : IN STD_LOGIC;
		 SOL         : OUT STD_LOGIC ; 
	    Qm1out        : BUFFER STD_LOGIC);

END registerQm1 ; 

ARCHITECTURE behavior OF registerQm1 IS 


 
BEGIN 
  
  PROCESS(Clk,RST,LDQ)
  BEGIN
 
  IF(RST='0') Then 
     SOL <= Qm1out ; 
	  IF(Clk 'EVENT and Clk='1') Then 
	     IF(LDQ='1') Then 
		  Qm1out <= '0' ;
		    
		  ELSIF(SL='1' AND LDQ='0') Then 
		  
		  Qm1out <= '0' ; 
		  			 
		  ELSIF(SR='1' AND LDQ='0' AND SL='0') Then 
		  Qm1out <= SIR ; 
			
		  END IF;  	  
	  END IF ;  
  ELSIF(RST='1') Then
  Qm1out <= '0' ; 
  END IF ;
  END PROCESS ;
END behavior ; 
		  