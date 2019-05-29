LIBRARY ieee;
USE ieee.std_logic_1164.all ;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

ENTITY registerQ IS 
PORT ( RST,LDQ     : IN STD_LOGIC ;
       SL , SR     : IN STD_LOGIC ; 
		 SIL , SIR   : IN STD_LOGIC ; 
		 SOL , SOR   : OUT STD_LOGIC ; 
       D           : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 Clk  , DIV1 : IN STD_LOGIC;
		 Qout        : OUT STD_LOGIC_VECTOR(7 DOWNTO 0));
END registerQ ; 

ARCHITECTURE behavior OF registerQ IS 

SIGNAL qtry : STD_LOGIC_VECTOR(7 downto 0);
 
BEGIN 
  
		SOL     <= qtry(7) ; 
		SOR     <= qtry(0);
	   Qout(7) <= qtry(7);
	   Qout(6) <= qtry(6);
		Qout(5) <= qtry(5);
		Qout(4) <= qtry(4);
		Qout(3) <= qtry(3);
		Qout(2) <= qtry(2);
		Qout(1) <= qtry(1);
		Qout(0) <= qtry(0);
  
  PROCESS(Clk,RST,LDQ)
  BEGIN
 
  IF(RST='0') Then 
    
	  
	  IF(Clk 'EVENT and Clk='1') Then 
	     IF(LDQ='1') Then 
		  qtry <= D ;
		    
		  ELSIF(SL='1' AND LDQ='0') Then 
		  
		  qtry(7) <= qtry(6);
		  qtry(6) <= qtry(5);
		  qtry(5) <= qtry(4);
		  qtry(4) <= qtry(3);
		  qtry(3) <= qtry(2);
		  qtry(2) <= qtry(1);
		  qtry(1) <= qtry(0);
		  qtry(0) <= SIL ;
		 
		  ELSIF(SR='1' AND LDQ='0' AND SL='0') Then 
		  qtry(7) <= SIR;
		  qtry(6) <= qtry(7);
		  qtry(5) <= qtry(6);
		  qtry(4) <= qtry(5);
		  qtry(3) <= qtry(4);
		  qtry(2) <= qtry(3);
		  qtry(1) <= qtry(2);
		  qtry(0) <= qtry(1);
		  
		  ELSIF(DIV1='1') Then
		  qtry(0) <= '1' ; 
		  
		  
		  END IF;  	  
	  END IF ;  
  ELSIF(RST='1') Then
  qtry <= "00000000" ; 
  END IF ;
  END PROCESS ;
END behavior ; 
		  