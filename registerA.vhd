LIBRARY ieee;
USE ieee.std_logic_1164.all ;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

ENTITY registerA IS 
PORT ( RST,LDA     : IN STD_LOGIC ;
       SL , SR     : IN STD_LOGIC ; 
		 SIL , SIR   : IN STD_LOGIC ; 
		 SOR         : OUT STD_LOGIC ; 
       D           : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 Clk         : IN STD_LOGIC;
		 Aout        : OUT STD_LOGIC_VECTOR(7 DOWNTO 0));
END registerA ; 

ARCHITECTURE behavior OF registerA IS 
SIGNAL Atry : STD_LOGIC_VECTOR(7 Downto 0);

 
BEGIN 
			SOR     <= Atry(0);
		  Aout(7) <= Atry(7);
		  Aout(6) <= Atry(6);
		  Aout(5) <= Atry(5);
		  Aout(4) <= Atry(4);
		  Aout(3) <= Atry(3);
		  Aout(2) <= Atry(2);
		  Aout(1) <= Atry(1);
		  Aout(0) <= Atry(0);
		  
  PROCESS(Clk,RST,LDA)
  BEGIN
 
  IF(RST='0') Then 
  	  
	  IF(Clk 'EVENT and Clk='1') Then 
	     IF(LDA='1') Then 
		  Atry <= D ;
		    
		  ELSIF(SL='1' AND LDA='0') Then 
		   
		  Atry(7) <= Atry(6);
		  Atry(6) <= Atry(5);
		  Atry(5) <= Atry(4);
		  Atry(4) <= Atry(3);
		  Atry(3) <= Atry(2);
		  Atry(2) <= Atry(1);
		  Atry(1) <= Atry(0);
		  Atry(0) <= SIL ;
		 
		 ELSIF(SR='1' AND LDA='0' AND SL='0') Then 
		  Atry(7) <= SIR;
		  Atry(6) <= Atry(7);
		  Atry(5) <= Atry(6);
		  Atry(4) <= Atry(5);
		  Atry(3) <= Atry(4);
		  Atry(2) <= Atry(3);
		  Atry(1) <= Atry(2);
		  Atry(0) <= Atry(1);
		  
		  END IF;  	  
	  END IF ;  
  ELSIF(RST='1') Then
  Atry <= "00000000" ; 
  END IF ;
  END PROCESS ;
END behavior ; 
		  