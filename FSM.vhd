LIBRARY ieee;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
USE ieee.numeric_std.ALL;

Entity FSM is 
port( 
      RUN : in std_logic;
	   CLRINIT : in std_logic; 
	   CLK        : in std_logic; 
		OpCode  : in std_logic_vector(3 downto 0) ;
	   Negative: in std_logic ; 
		Zero       : in std_logic ;
		CounterVal : in std_logic_VECTOR(3 downto 0); 
		LastBits: in std_logic_VECTOR(1 downto 0);
		Qmsb		:in std_logic;
		Abef		:in std_logic;
		Amsb 		:in std_logic;
		Mmsb		:in std_logic;
		Qoldmsb	:in std_logic;
		PCsel   : out std_logic_vector(1 downto 0) ;
	   pcWE    : out std_logic ; 
	   DSEL    : out std_logic_vector(2 downto 0); 
		DestSel :out std_logic_vector(1 downto 0);
	   RegWE   : out std_logic ; 
	   ASEL    : out std_logic_vector(1 downto 0);
      BSEL    : out std_logic_vector(2 downto 0);
		AOP     : out std_logic_vector(2 downto 0);
		Cin     : out std_logic ; 
		LDA     : out std_logic ; 
		LDQ     : out std_logic ; 
		SRSEL   : out std_logic ; 
		SL      : out std_logic ; 
		SR      : out std_logic ; 
		BytWrSel: out std_logic ;
		BytRrSel: out std_logic ;	
		DataWE  : out std_logic ;
		STATE   : out std_logic_vector (5 downto 0);
		RESET   : out std_logic ;
		CountEn : out std_logic ;	
		CountRst: out std_logic ;
	   DIV1    : out std_logic			); 
end FSM ; 

architecture behavior of FSM is 

SIGNAL y_present, y_next : STD_LOGIC_VECTOR(37 DOWNTO 0);
CONSTANT s0  : STD_LOGIC_VECTOR(37 DOWNTO 0) := "10000000000000000000000000000000000000";
CONSTANT s1  : STD_LOGIC_VECTOR(37 DOWNTO 0) := "01000000000000000000000000000000000000";
CONSTANT s2  : STD_LOGIC_VECTOR(37 DOWNTO 0) := "00100000000000000000000000000000000000";
CONSTANT s3  : STD_LOGIC_VECTOR(37 DOWNTO 0) := "00010000000000000000000000000000000000";
CONSTANT s4  : STD_LOGIC_VECTOR(37 DOWNTO 0) := "00001000000000000000000000000000000000";
CONSTANT s5  : STD_LOGIC_VECTOR(37 DOWNTO 0) := "00000100000000000000000000000000000000";
CONSTANT s6  : STD_LOGIC_VECTOR(37 DOWNTO 0) := "00000010000000000000000000000000000000";
CONSTANT s7  : STD_LOGIC_VECTOR(37 DOWNTO 0) := "00000001000000000000000000000000000000";
CONSTANT s8  : STD_LOGIC_VECTOR(37 DOWNTO 0) := "00000000100000000000000000000000000000";
CONSTANT s9  : STD_LOGIC_VECTOR(37 DOWNTO 0) := "00000000010000000000000000000000000000";
CONSTANT s10 : STD_LOGIC_VECTOR(37 DOWNTO 0) := "00000000001000000000000000000000000000";
CONSTANT s11 : STD_LOGIC_VECTOR(37 DOWNTO 0) := "00000000000100000000000000000000000000";
CONSTANT s12 : STD_LOGIC_VECTOR(37 DOWNTO 0) := "00000000000010000000000000000000000000";
CONSTANT s13 : STD_LOGIC_VECTOR(37 DOWNTO 0) := "00000000000001000000000000000000000000";
CONSTANT s14 : STD_LOGIC_VECTOR(37 DOWNTO 0) := "00000000000000100000000000000000000000";
CONSTANT s15 : STD_LOGIC_VECTOR(37 DOWNTO 0) := "00000000000000010000000000000000000000";
CONSTANT s16 : STD_LOGIC_VECTOR(37 DOWNTO 0) := "00000000000000001000000000000000000000";
CONSTANT s17 : STD_LOGIC_VECTOR(37 DOWNTO 0) := "00000000000000000100000000000000000000";
CONSTANT s18 : STD_LOGIC_VECTOR(37 DOWNTO 0) := "00000000000000000010000000000000000000";
CONSTANT s19 : STD_LOGIC_VECTOR(37 DOWNTO 0) := "00000000000000000001000000000000000000";
CONSTANT s20 : STD_LOGIC_VECTOR(37 DOWNTO 0) := "00000000000000000000100000000000000000";
CONSTANT s21 : STD_LOGIC_VECTOR(37 DOWNTO 0) := "00000000000000000000010000000000000000";
CONSTANT s22 : STD_LOGIC_VECTOR(37 DOWNTO 0) := "00000000000000000000001000000000000000";
CONSTANT s23 : STD_LOGIC_VECTOR(37 DOWNTO 0) := "00000000000000000000000100000000000000";
CONSTANT s24 : STD_LOGIC_VECTOR(37 DOWNTO 0) := "00000000000000000000000010000000000000";
CONSTANT s25 : STD_LOGIC_VECTOR(37 DOWNTO 0) := "00000000000000000000000001000000000000";
CONSTANT s26 : STD_LOGIC_VECTOR(37 DOWNTO 0) := "00000000000000000000000000100000000000";
CONSTANT s27 : STD_LOGIC_VECTOR(37 DOWNTO 0) := "00000000000000000000000000010000000000";
CONSTANT s28 : STD_LOGIC_VECTOR(37 DOWNTO 0) := "00000000000000000000000000001000000000";
CONSTANT s29 : STD_LOGIC_VECTOR(37 DOWNTO 0) := "00000000000000000000000000000100000000";
CONSTANT s30 : STD_LOGIC_VECTOR(37 DOWNTO 0) := "00000000000000000000000000000010000000";
CONSTANT s31 : STD_LOGIC_VECTOR(37 DOWNTO 0) := "00000000000000000000000000000001000000";
CONSTANT s32 : STD_LOGIC_VECTOR(37 DOWNTO 0) := "00000000000000000000000000000000100000";
CONSTANT s33 : STD_LOGIC_VECTOR(37 DOWNTO 0) := "00000000000000000000000000000000010000";
CONSTANT s34 : STD_LOGIC_VECTOR(37 DOWNTO 0) := "00000000000000000000000000000000001000";
CONSTANT s35 : STD_LOGIC_VECTOR(37 DOWNTO 0) := "00000000000000000000000000000000000100";
CONSTANT s36 : STD_LOGIC_VECTOR(37 DOWNTO 0) := "00000000000000000000000000000000000010";
CONSTANT s37 : STD_LOGIC_VECTOR(37 DOWNTO 0) := "00000000000000000000000000000000000001";
BEGIN 

PROCESS (CLK,CLRINIT)
	BEGIN
		IF CLRINIT='1' THEN
			y_present <= s0;
			RESET <= '0';
		ELSIF (CLK'EVENT AND CLK='0' AND CLRINIT='0') THEN
			y_present <= y_next;
			RESET <= '1';
		END IF;
		
	END PROCESS; 
	
PROCESS(OpCode,RUN,y_present,Zero)
     BEGIN 
	  CASE y_present IS 
	       
			 WHEN s0 => 
			 IF RUN='1' THEN 
			 y_next <= s1 ; 
			 ELSE 
			 y_next <= s0 ; 
			 END IF; 
			 
			 WHEN s1=> 
			 
			 IF OpCode ="1011" then 
			 y_next <= s2 ;
			 
			 ELSIF OpCode = "1010" then 
			 y_next <= s4;
			 
			 ELSIF OpCode = "1100" then
			 y_next <= s5; 
			 
			 ELSIF OpCode = "0000" then 
			 y_next <= s6 ; 
			 
			 ELSIF OpCode = "0001" then 
			 y_next <= s7 ; 
			 
			 ELSIF OpCode = "0110" then 
			 y_next <= s9 ; 
			 
			 ELSIF OpCode = "0100" then 
			 y_next <= s10 ; 
			 
			 ELSIF OpCode = "0101" then 
			 y_next <= s11 ; 
			 
			 ELSIF OpCode = "0111" then
			 y_next <= s15 ;
			 
			 ELSIF OpCode = "1111" then
			 y_next <= s15 ;
			 
			 ELSIF OpCode = "1000" then
			 y_next <= s15 ;
			 
			 ELSIF OpCode = "1110" then
			 y_next <= s15 ;
			 
			 ELSIF OpCode = "1101" then
			 y_next <= s7 ;
			 
			 ELSIF OpCode = "0010" then
			 y_next <= s22 ;
			 
			 ELSIF OpCode = "0011" then
			 y_next <= s28 ;
			 
			 
			 ELSE 
			 y_next <=s0 ;
			 END IF; 
			 
			 WHEN s2 => 
			 y_next <= s3;
			 			 			 
			 WHEN s3 => 
			 y_next <= s0;
			 
			 WHEN s4 => 
			 y_next <= s0 ; 
			 
			 WHEN s5 => 
			 y_next <= s3;
			 
			 
			 WHEN s6 => 
			 y_next <= s8 ;
			 
			 WHEN s7 => 
			 IF Opcode="0001" then
				y_next <= s8;
			 ElSIF Opcode="1101" then
				 IF Negative='0' then 
				 y_next <= s20 ;
				 ELSE 
				 y_next <= s21;
				 END IF;
			 END IF;
			 
			 WHEN s8 => 
			 y_next <= s0 ; 
			 
			 WHEN s9 => 
			 y_next <= s0 ; 
			 
			 WHEN s10 => 
			 IF Zero='1' then 
			 y_next <= s12 ;
			 ELSE 
			 y_next <= s13;
			 END IF;
			 
			 WHEN s11 => 
			 IF Zero='0'then 
			 y_next <= s14 ;
			 ELSE 
			 y_next <= s13;
			 END IF;
			 
			 WHEN s12 =>
			 y_next<= s0; 
			 
			 WHEN s13 =>
			 y_next<= s0;
			 
			 WHEN s14 =>
			 y_next<= s0;
			 
			 WHEN s15 =>
			 IF Opcode="0111" then 
			 y_next <= s16 ;
			 ELSIF Opcode="1111" then 
			 y_next <= s17;
			 ELSIF Opcode="1000" then
			 y_next <= s18;
			 ELSIF Opcode="1110" then
			 y_next <= s19;
			 END IF;
			 
			 WHEN s16 =>
			 y_next<= s0;	
			 WHEN s17 =>
			 y_next<= s0;
			 WHEN s18 =>
			 y_next<= s0;
			 WHEN s19 =>
			 y_next<= s0;
			 
			 WHEN s20 =>
			 y_next<= s0;
			 WHEN s21 =>
			 y_next<= s0;
			 
			 WHEN s22 =>
			 IF CounterVal = "0000" THEN y_next <= s26;
				ELSE 
					IF LastBits = "10" THEN y_next <= s23;
					ELSIF LastBits = "01" THEN y_next <= s24;
					ELSE y_next <= s25;
					END IF;
				END IF;
			
			 WHEN s23 =>
			 y_next<= s25;
				
			 WHEN s24 =>
			 y_next<= s25;
				
			WHEN s25 =>
				IF CounterVal = "0000" THEN y_next <= s26;
				ELSE 
					IF LastBits = "10" THEN y_next <= s23;
					ELSIF LastBits = "01" THEN y_next <= s24;
					ELSE y_next <= s25;
					END IF;
				END IF;
			 
			 WHEN s26 =>
			 y_next<= s27;
			 
			 WHEN s27 =>
			 y_next<= s0;
			 
			 WHEN s28 =>
			 IF Qmsb = '1' then
			 y_next<= s29;
			 else
			 y_next<=s30;
			 end if;
			 
			 WHEN s29 =>
			 y_next<= s30;
			 
			 
			 WHEN s30 =>
		    IF Abef = Mmsb then
				y_next <= s32;
			 Else
			   y_next <= s31;
			 end if;
			 
			 
			 WHEN s31 => 
			 IF (Zero = '1' or Amsb = Abef) then
				y_next <= s33;
			 elsif counterVal = "0000" then
			  y_next <= s35;
			 else
				y_next <= s30;
			 end if;
			  
			 WHEN s32 => 
			 IF Zero = '1' then
				y_next <= s34;
			elsif (Amsb = Abef) then
				y_next <= s34;
			
			 elsif counterVal = "0000" then
			  y_next <= s35;
			 else
				y_next <= s30;
			 end if;
			 
			 WHEN s33 => 
			  if counterVal = "0000" then
					y_next <= s35 ;
				else 
					y_next <= s30;
				end if;
			
			WHEN s34 => 
			  if counterVal = "0000" then
					y_next <= s35 ;
				else 
					y_next <= s30;
				end if;
			
			 WHEN s35 => 
			 if (Mmsb = Qoldmsb)  then
					y_next <= s36 ;
				else 
					y_next <= s37;
				end if;
				
				
			 WHEN s36 => 
			 y_next <= s0 ;
			 
			 WHEN s37 => 
			 y_next <= s0 ;
			 
			 WHEN others =>
			 y_next <= s0;
			 
	  END CASE; 
	  END PROCESS; 


PROCESS(y_present)	
     BEGIN 
	  
	  IF y_present = s0 then 
		pcWE <= '0';
	   PCsel <= "00"; 
	   DSEL    <= "000"; 
		DestSel <= "00" ;
	   RegWE   <= '0' ;  
	   ASEL    <= "00" ;
      BSEL    <= "000" ; 
		AOP     <= "000" ;
		Cin     <= '0' ; 
		LDA     <= '0' ;
		LDQ     <= '0' ;
		SRSEL   <= '0' ;
		SL      <= '0' ;
		SR      <= '0' ;
		BytWrSel<= '0' ;
		BytRrSel<= '0' ;
	   DataWE  <= '0' ;
		CountEn <= '0' ;
		CountRst<= '0' ;
		DIV1    <= '0' ;
   	STATE   <= "000000" ;
		END IF ; 
	   
		IF y_present = s1 then 
		pcWE <= '0';
		PCsel <= "00"; 
	   DSEL    <= "000"; 
		DestSel <= "00" ;
	   RegWE   <= '0' ;  
	   ASEL    <= "00" ;
      BSEL    <= "000" ; 
		AOP     <= "000" ;
		Cin     <= '0' ; 
		LDA     <= '0' ;
		LDQ     <= '0' ;
		SRSEL   <= '0' ;
		SL      <= '0' ;
		SR      <= '0' ;
		BytWrSel<= '0' ;
		BytRrSel<= '0' ;
	   DataWE  <= '0' ;
		CountEn <= '0' ;
		DIV1    <= '0' ;
		STATE   <="000001"; 
		END IF;
		
		IF y_present = s2 then 
		pcWE <= '0';
		PCsel <= "10"; 
	   DSEL    <= "001"; 
		DestSel <= "01" ;
	   RegWE   <= '0' ;  
	   ASEL    <= "10" ;
      BSEL    <= "011" ; 
		AOP     <= "000" ;
		Cin     <= '0' ; 
		LDA     <= '1' ;
		LDQ     <= '0' ;
		SRSEL   <= '0' ;
		SL      <= '0' ;
		SR      <= '0' ;
		BytWrSel<= '0' ;
		BytRrSel<= '0' ;
	   DataWE  <= '0' ;
		DIV1    <= '0' ;
		STATE   <="000010";
		END IF ; 
		
		IF y_present = s3 then 
		pcWE <= '1';
		PCsel <= "10"; 
	   DSEL    <= "001"; 
		DestSel <= "01" ;
	   RegWE   <= '1' ;  
	   ASEL    <= "00" ;
      BSEL    <= "000" ; 
		AOP     <= "000" ;
		Cin     <= '0' ; 
		LDA     <= '0' ;
		LDQ     <= '0' ;
		SRSEL   <= '0' ;
		SL      <= '0' ;
		SR      <= '0' ;
		BytWrSel<= '0' ;
		BytRrSel<= '0' ;
	   DataWE  <= '0' ;
		DIV1    <= '0' ;
		STATE   <= "000011";
		END IF ;
	   
		IF y_present = s4 then 
		pcWE <= '1';
		PCsel <= "10"; 
	   DSEL    <= "010"; 
		DestSel <= "00" ;
	   RegWE   <= '1' ;  
	   ASEL    <= "00" ;
      BSEL    <= "000" ; 
		AOP     <= "000" ;
		Cin     <= '0' ; 
		LDA     <= '0' ;
		LDQ     <= '0' ;
		SRSEL   <= '0' ;
		SL      <= '0' ;
		SR      <= '0' ;
		BytWrSel<= '0' ;
		BytRrSel<= '0' ;
	   DataWE  <= '0' ;
		DIV1    <= '0' ;
		STATE   <="000100";	
      end if ; 
		
		IF y_present = s5 then 
	   pcWE <= '0';
		PCsel <= "10"; 
	   DSEL    <= "001"; 
		DestSel <= "01" ;
	   RegWE   <= '0' ;  
	   ASEL    <= "10" ;
      BSEL    <= "011" ; 
		AOP     <= "001" ;
		Cin     <= '1' ; 
		LDA     <= '1' ;
		LDQ     <= '0' ;
		SRSEL   <= '0' ;
		SL      <= '0' ;
		SR      <= '0' ;
		BytWrSel<= '0' ;
		BytRrSel<= '0' ;
	   DataWE  <= '0' ;
		DIV1    <= '0' ;
		STATE   <="000101";
		END IF ; 
      
		IF y_present = s6 then 
		
	   pcWE <= '0';
		PCsel <= "00"; 
	   DSEL    <= "000"; 
		DestSel <= "10" ;
	   RegWE   <= '0' ;  
	   ASEL    <= "10" ;
      BSEL    <= "010" ; 
		AOP     <= "000" ;
		Cin     <= '0' ; 
		LDA     <= '1' ;
		LDQ     <= '0' ;
		SRSEL   <= '0' ;
		SL      <= '0' ;
		SR      <= '0' ;
		BytWrSel<= '0' ;
		BytRrSel<= '0' ;
	   DataWE  <= '0' ;
		DIV1    <= '0' ;
		STATE   <="000110";
		END IF ; 
		
		IF y_present = s7 then 
		
	   pcWE <= '0';
		PCsel <= "00"; 
	   DSEL    <= "000"; 
		DestSel <= "10" ;
	   RegWE   <= '0' ;  
	   ASEL    <= "10" ;
      BSEL    <= "010" ; 
		AOP     <= "001" ;
		Cin     <= '1' ; 
		LDA     <= '1' ;
		LDQ     <= '0' ;
		SRSEL   <= '0' ;
		SL      <= '0' ;
		SR      <= '0' ;
		BytWrSel<= '0' ;
		BytRrSel<= '0' ;
	   DataWE  <= '0' ;
		DIV1    <= '0' ;
		STATE   <="000111";
		END IF ; 
		
		IF y_present = s8 then 
		
	   pcWE <= '1';
		PCsel <= "10"; 
	   DSEL    <= "001"; 
		DestSel <= "10" ;
	   RegWE   <= '1' ;  
	   ASEL    <= "00" ;
      BSEL    <= "000" ; 
		AOP     <= "000" ;
		Cin     <= '0' ; 
		LDA     <= '0' ;
		LDQ     <= '0' ;
		SRSEL   <= '0' ;
		SL      <= '0' ;
		SR      <= '0' ;
		BytWrSel<= '0' ;
		BytRrSel<= '0' ;
	   DataWE  <= '0' ;
		DIV1    <= '0' ;
		STATE   <="001000";
		END IF ; 
		
		IF y_present = s9 then 
		
	   pcWE <= '1';
		PCsel <= "00"; 
	   DSEL    <= "000"; 
		DestSel <= "00" ;
	   RegWE   <= '0' ;  
	   ASEL    <= "00" ;
      BSEL    <= "000" ; 
		AOP     <= "000" ;
		Cin     <= '0' ; 
		LDA     <= '0' ;
		LDQ     <= '0' ;
		SRSEL   <= '0' ;
		SL      <= '0' ;
		SR      <= '0' ;
		BytWrSel<= '0' ;
		BytRrSel<= '0' ;
	   DataWE  <= '0' ;
		DIV1    <= '0' ;
		STATE   <="001001";
      END IF ; 
		
		IF y_present = s10 then 
		
	   pcWE <= '0';
		PCsel <= "00"; 
	   DSEL    <= "000"; 
		DestSel <= "00" ;
	   RegWE   <= '0' ;  
	   ASEL    <= "10" ;
      BSEL    <= "010" ; 
		AOP     <= "001" ;
		Cin     <= '1' ; 
		LDA     <= '0' ;
		LDQ     <= '0' ;
		SRSEL   <= '0' ;
		SL      <= '0' ;
		SR      <= '0' ;
		BytWrSel<= '0' ;
		BytRrSel<= '0' ;
	   DataWE  <= '0' ;
		DIV1    <= '0' ;
		STATE   <="001010";
      END IF ; 
		IF y_present = s11 then 
		
	   pcWE <= '0';
		PCsel <= "00"; 
	   DSEL    <= "000"; 
		DestSel <= "00" ;
	   RegWE   <= '0' ;  
	   ASEL    <= "10" ;
      BSEL    <= "010" ; 
		AOP     <= "001" ;
		Cin     <= '1' ; 
		LDA     <= '0' ;
		LDQ     <= '0' ;
		SRSEL   <= '0' ;
		SL      <= '0' ;
		SR      <= '0' ;
		BytWrSel<= '0' ;
		BytRrSel<= '0' ;
	   DataWE  <= '0' ;
		DIV1    <= '0' ;
		STATE   <="001011";
      END IF ; 
		
		IF y_present = s12 then 
		
	   pcWE <= '1';
		PCsel <= "01"; 
	   DSEL    <= "000"; 
		DestSel <= "00" ;
	   RegWE   <= '0' ;  
	   ASEL    <= "00" ;
      BSEL    <= "000" ; 
		AOP     <= "000" ;
		Cin     <= '0' ; 
		LDA     <= '0' ;
		LDQ     <= '0' ;
		SRSEL   <= '0' ;
		SL      <= '0' ;
		SR      <= '0' ;
		BytWrSel<= '0' ;
		BytRrSel<= '0' ;
	   DataWE  <= '0' ;
		DIV1    <= '0' ;
		STATE   <="001100";
      END IF ; 
		
		IF y_present = s13 then 
		
	   pcWE <= '1';
		PCsel <= "10"; 
	   DSEL    <= "000"; 
		DestSel <= "00" ;
	   RegWE   <= '0' ;  
	   ASEL    <= "00" ;
      BSEL    <= "000" ; 
		AOP     <= "000" ;
		Cin     <= '0' ; 
		LDA     <= '0' ;
		LDQ     <= '0' ;
		SRSEL   <= '0' ;
		SL      <= '0' ;
		SR      <= '0' ;
		BytWrSel<= '0' ;
		BytRrSel<= '0' ;
	   DataWE  <= '0' ;
		DIV1    <= '0' ;
		STATE   <="001101";
      END IF ; 
		
		IF y_present = s14 then 
		
	   pcWE <= '1';
		PCsel <= "01"; 
	   DSEL    <= "000"; 
		DestSel <= "00" ;
	   RegWE   <= '0' ;  
	   ASEL    <= "00" ;
      BSEL    <= "000" ; 
		AOP     <= "000" ;
		Cin     <= '0' ; 
		LDA     <= '0' ;
		LDQ     <= '0' ;
		SRSEL   <= '0' ;
		SL      <= '0' ;
		SR      <= '0' ;
		BytWrSel<= '0' ;
		BytRrSel<= '0' ;
	   DataWE  <= '0' ;
		DIV1    <= '0' ;
		STATE   <="001110";
      END IF ;
	
		IF y_present = s15 then 
		
	   pcWE <= '0';
		PCsel <= "00"; 
	   DSEL    <= "000"; 
		DestSel <= "00" ;
	   RegWE   <= '0' ;  
	   ASEL    <= "10" ;
      BSEL    <= "011" ; 
		AOP     <= "000" ;
		Cin     <= '0' ; 
		LDA     <= '1' ;
		LDQ     <= '1' ;
		SRSEL   <= '0' ;
		SL      <= '0' ;
		SR      <= '0' ;
		BytWrSel<= '0' ;
		BytRrSel<= '0' ;
	   DataWE  <= '0' ;
		DIV1    <= '0' ;
		STATE   <="001111";
      END IF ;	
		
		IF y_present = s16 then 
		
	   pcWE <= '1';
		PCsel <= "10"; 
	   DSEL    <= "000"; 
		DestSel <= "00" ;
	   RegWE   <= '0' ;  
	   ASEL    <= "10" ;
      BSEL    <= "011" ; 
		AOP     <= "000" ;
		Cin     <= '0' ; 
		LDA     <= '0' ;
		LDQ     <= '0' ;
		SRSEL   <= '0' ;
		SL      <= '0' ;
		SR      <= '0' ;
		BytWrSel<= '0' ;
		BytRrSel<= '1' ;
		DataWE  <= '1' ;
	   DIV1    <= '0' ;
		STATE   <="010000";
      END IF ;	
		
		IF y_present = s17 then 
		
	   pcWE <= '1';
		PCsel <= "10"; 
	   DSEL    <= "000"; 
		DestSel <= "00" ;
	   RegWE   <= '0' ;  
	   ASEL    <= "10" ;
      BSEL    <= "011" ; 
		AOP     <= "000" ;
		Cin     <= '0' ; 
		LDA     <= '0' ;
		LDQ     <= '0' ;
		SRSEL   <= '0' ;
		SL      <= '0' ;
		SR      <= '0' ;
		BytWrSel<= '1' ;
		BytRrSel<= '0' ;
		DataWE  <= '1' ;
		DIV1    <= '0' ;
	
		STATE   <="010001";
      END IF ;
		
		IF y_present = s18 then 
		
	   pcWE <= '1';
		PCsel <= "10"; 
	   DSEL    <= "011"; 
		DestSel <= "01" ;
	   RegWE   <= '1' ;  
	   ASEL    <= "10" ;
      BSEL    <= "011" ; 
		AOP     <= "000" ;
		Cin     <= '0' ; 
		LDA     <= '0' ;
		LDQ     <= '0' ;
		SRSEL   <= '0' ;
		SL      <= '0' ;
		SR      <= '0' ;
		BytWrSel<= '0' ;
		BytRrSel<= '0' ;
		DataWE  <= '0' ;
		DIV1    <= '0' ;
	
		STATE   <="010010";
      END IF ;
		
		IF y_present = s19 then 
		
	   pcWE <= '1';
		PCsel <= "10"; 
	   DSEL    <= "011"; 
		DestSel <= "01" ;
	   RegWE   <= '1' ;  
	   ASEL    <= "10" ;
      BSEL    <= "011" ; 
		AOP     <= "000" ;
		Cin     <= '0' ; 
		LDA     <= '0' ;
		LDQ     <= '0' ;
		SRSEL   <= '0' ;
		SL      <= '0' ;
		SR      <= '0' ;
		BytWrSel<= '0' ;
		BytRrSel<= '1' ;
		DataWE  <= '0' ;
		DIV1    <= '0' ;
	
		STATE   <="010011";
      END IF ;
		
		IF y_present = s20 then 
		
	   pcWE <= '1';
		PCsel <= "10"; 
	   DSEL    <= "101"; 
		DestSel <= "10" ;
	   RegWE   <= '1' ;  
	   ASEL    <= "10" ;
      BSEL    <= "011" ; 
		AOP     <= "000" ;
		Cin     <= '0' ; 
		LDA     <= '0' ;
		LDQ     <= '0' ;
		SRSEL   <= '0' ;
		SL      <= '0' ;
		SR      <= '0' ;
		BytWrSel<= '0' ;
		BytRrSel<= '0' ;
		DataWE  <= '0' ;
		DIV1    <= '0' ;
	
		STATE   <="010100";
      END IF ;
		
		IF y_present = s21 then 
		
	   pcWE <= '1';
		PCsel <= "10"; 
	   DSEL    <= "100"; 
		DestSel <= "10" ;
	   RegWE   <= '1' ;  
	   ASEL    <= "10" ;
      BSEL    <= "011" ; 
		AOP     <= "000" ;
		Cin     <= '0' ; 
		LDA     <= '0' ;
		LDQ     <= '0' ;
		SRSEL   <= '0' ;
		SL      <= '0' ;
		SR      <= '0' ;
		BytWrSel<= '0' ;
		BytRrSel<= '0' ;
		DataWE  <= '0' ;
		DIV1    <= '0' ;
	
		STATE   <="010101";
      END IF ;
		
		IF y_present = s22 then 
		
	   pcWE <= '0';
		PCsel <= "10"; 
	   DSEL    <= "100"; 
		DestSel <= "10" ;
	   RegWE   <= '0' ;  
	   ASEL    <= "10" ;
      BSEL    <= "000" ; 
		AOP     <= "000" ;
		Cin     <= '0' ; 
		LDA     <= '0' ;
		LDQ     <= '1' ;
		SRSEL   <= '0' ;
		SL      <= '0' ;
		SR      <= '0' ;
		BytWrSel<= '0' ;
		BytRrSel<= '0' ;
		DataWE  <= '0' ;
		CountRst<= '1' ;
		CountEn <= '0' ;
		DIV1    <= '0' ;
		STATE   <="010110";
      END IF ;
		
		IF y_present = s23 then 
		
	   pcWE <= '0';
		PCsel <= "10"; 
	   DSEL    <= "100"; 
		DestSel <= "10" ;
	   RegWE   <= '0' ;  
	   ASEL    <= "11" ;
      BSEL    <= "100" ; 
		AOP     <= "001" ;
		Cin     <= '1' ; 
		LDA     <= '1' ;
		LDQ     <= '0' ;
		SRSEL   <= '0' ;
		SL      <= '0' ;
		SR      <= '0' ;
		BytWrSel<= '0' ;
		BytRrSel<= '0' ;
		DataWE  <= '0' ;
		CountRst<= '1' ;
	   CountEn <= '0' ;
		DIV1    <= '0' ;
		STATE   <="010111";
      END IF ;
		
		IF y_present = s24 then 
		
	   pcWE <= '0';
		PCsel <= "10"; 
	   DSEL    <= "100"; 
		DestSel <= "10" ;
	   RegWE   <= '0' ;  
	   ASEL    <= "11" ;
      BSEL    <= "100" ; 
		AOP     <= "000" ;
		Cin     <= '0' ; 
		LDA     <= '1' ;
		LDQ     <= '0' ;
		SRSEL   <= '0' ;
		SL      <= '0' ;
		SR      <= '0' ;
		BytWrSel<= '0' ;
		BytRrSel<= '0' ;
		DataWE  <= '0' ;
		CountRst<= '1' ;
	   CountEn <= '0' ;
		DIV1    <= '0' ;
		STATE   <="011000";
      END IF ;
		
		IF y_present = s25 then 
		
	   pcWE <= '0';
		PCsel <= "10"; 
	   DSEL    <= "100"; 
		DestSel <= "10" ;
	   RegWE   <= '0' ;  
	   ASEL    <= "10" ;
      BSEL    <= "000" ; 
		AOP     <= "000" ;
		Cin     <= '0' ; 
		LDA     <= '0' ;
		LDQ     <= '0' ;
		SRSEL   <= '1' ;
		SL      <= '0' ;
		SR      <= '1' ;
		BytWrSel<= '0' ;
		BytRrSel<= '0' ;
		DataWE  <= '0' ;
		CountEn <= '1' ;
		CountRst<= '1' ;
		DIV1    <= '0' ;
	
		STATE   <="011001";
      END IF ;
		
		IF y_present = s26 then 
		
	   pcWE <= '0';
		PCsel <= "10"; 
	   DSEL    <= "001"; 
		DestSel <= "10" ;
	   RegWE   <= '1' ;  
	   ASEL    <= "10" ;
      BSEL    <= "000" ; 
		AOP     <= "000" ;
		Cin     <= '0' ; 
		LDA     <= '0' ;
		LDQ     <= '0' ;
		SRSEL   <= '0' ;
		SL      <= '0' ;
		SR      <= '0' ;
		BytWrSel<= '0' ;
		BytRrSel<= '0' ;
		DataWE  <= '0' ;
		CountRst<= '1' ;
	   CountEn <= '0' ;
		DIV1    <= '0' ;
		STATE   <="011010";
      END IF ;
		
		IF y_present = s27 then 
		
	   pcWE <= '1';
		PCsel <= "10"; 
	   DSEL    <= "000"; 
		DestSel <= "11" ;
	   RegWE   <= '1' ;  
	   ASEL    <= "10" ;
      BSEL    <= "000" ; 
		AOP     <= "000" ;
		Cin     <= '0' ; 
		LDA     <= '0' ;
		LDQ     <= '0' ;
		SRSEL   <= '0' ;
		SL      <= '0' ;
		SR      <= '0' ;
		BytWrSel<= '0' ;
		BytRrSel<= '0' ;
		DataWE  <= '0' ;
		CountRst<= '1' ;
		CountEn <= '0' ;
		DIV1    <= '0' ;
	
		STATE   <="011011";
      END IF ;
		
		IF y_present = s28 then 
		
	   pcWE <= '0';
		PCsel <= "10"; 
	   DSEL    <= "000"; 
		DestSel <= "00" ;
	   RegWE   <= '0' ;  
	   ASEL    <= "00" ;
      BSEL    <= "000" ; 
		AOP     <= "000" ;
		Cin     <= '0' ; 
		LDA     <= '1' ;
		LDQ     <= '1' ;
		SRSEL   <= '0' ;
		SL      <= '0' ;
		SR      <= '0' ;
		BytWrSel<= '0' ;
		BytRrSel<= '0' ;
		DataWE  <= '0' ;
		CountRst<= '0' ;
		CountEn <= '0' ;
		DIV1    <= '0' ;
	
		STATE   <="011100";
      END IF ;
		
		IF y_present = s29 then 
		
	   pcWE <= '0';
		PCsel <= "10"; 
	   DSEL    <= "000"; 
		DestSel <= "00" ;
	   RegWE   <= '0' ;  
	   ASEL    <= "01" ;
      BSEL    <= "000" ; 
		AOP     <= "000" ;
		Cin     <= '0' ; 
		LDA     <= '1' ;
		LDQ     <= '0' ;
		SRSEL   <= '0' ;
		SL      <= '0' ;
		SR      <= '0' ;
		BytWrSel<= '0' ;
		BytRrSel<= '0' ;
		DataWE  <= '0' ;
		CountRst<= '1' ;
		CountEn <= '0' ;
		DIV1    <= '0' ;
	
		STATE   <="011101";
      END IF ;
		
		IF y_present = s30 then 
		
	   pcWE <= '0';
		PCsel <= "10"; 
	   DSEL    <= "000"; 
		DestSel <= "00" ;
	   RegWE   <= '0' ;  
	   ASEL    <= "00" ;
      BSEL    <= "000" ; 
		AOP     <= "000" ;
		Cin     <= '0' ; 
		LDA     <= '0' ;
		LDQ     <= '0' ;
		SRSEL   <= '0' ;
		SL      <= '1' ;
		SR      <= '0' ;
		BytWrSel<= '0' ;
		BytRrSel<= '0' ;
		DataWE  <= '0' ;
		CountRst<= '1' ;
		CountEn <= '1' ;
		DIV1    <= '0' ;
	
		STATE   <="011110";
      END IF ;
      
		IF y_present = s31 then 
		
	   pcWE <= '0';
		PCsel <= "10"; 
	   DSEL    <= "000"; 
		DestSel <= "00" ;
	   RegWE   <= '0' ;  
	   ASEL    <= "11" ;
      BSEL    <= "100" ; 
		AOP     <= "000" ;
		Cin     <= '0' ; 
		LDA     <= '0' ;
		LDQ     <= '0' ;
		SRSEL   <= '0' ;
		SL      <= '0' ;
		SR      <= '0' ;
		BytWrSel<= '0' ;
		BytRrSel<= '0' ;
		DataWE  <= '0' ;
		CountRst<= '1' ;
		CountEn <= '0' ;
		DIV1    <= '0' ;
	
		STATE   <="011111";
      END IF ;
		
		IF y_present = s32 then 
		
	   pcWE <= '0';
		PCsel <= "10"; 
	   DSEL    <= "000"; 
		DestSel <= "00" ;
	   RegWE   <= '0' ;  
	   ASEL    <= "11" ;
      BSEL    <= "100" ; 
		AOP     <= "001" ;
		Cin     <= '0' ; 
		LDA     <= '0' ;
		LDQ     <= '0' ;
		SRSEL   <= '0' ;
		SL      <= '0' ;
		SR      <= '0' ;
		BytWrSel<= '0' ;
		BytRrSel<= '0' ;
		DataWE  <= '0' ;
		CountRst<= '1' ;
		CountEn <= '0' ;
		DIV1    <= '0' ;
	
		STATE   <="100000";
      END IF ;
		
		IF y_present = s33 then 
		
	   pcWE <= '0';
		PCsel <= "10"; 
	   DSEL    <= "000"; 
		DestSel <= "00" ;
	   RegWE   <= '0' ;  
	   ASEL    <= "11" ;
      BSEL    <= "100" ; 
		AOP     <= "000" ;
		Cin     <= '1' ; 
		LDA     <= '1' ;
		LDQ     <= '0' ;
		SRSEL   <= '0' ;
		SL      <= '0' ;
		SR      <= '0' ;
		BytWrSel<= '0' ;
		BytRrSel<= '0' ;
		DataWE  <= '0' ;
		CountRst<= '1' ;
		CountEn <= '0' ;
		DIV1    <= '1' ;
	
		STATE   <="100001";
      END IF ;
		IF y_present = s34 then 
		
	   pcWE <= '0';
		PCsel <= "10"; 
	   DSEL    <= "000"; 
		DestSel <= "00" ;
	   RegWE   <= '0' ;  
	   ASEL    <= "11" ;
      BSEL    <= "100" ; 
		AOP     <= "001" ;
		Cin     <= '1' ; 
		LDA     <= '1' ;
		LDQ     <= '0' ;
		SRSEL   <= '0' ;
		SL      <= '0' ;
		SR      <= '0' ;
		BytWrSel<= '0' ;
		BytRrSel<= '0' ;
		DataWE  <= '0' ;
		CountRst<= '1' ;
		CountEn <= '0' ;
		DIV1    <= '1' ;
	
		STATE   <="100010";
      END IF ;
		
		IF y_present = s35 then 
		
	   pcWE <= '0';
		PCsel <= "10"; 
	   DSEL    <= "001"; 
		DestSel <= "10" ;
	   RegWE   <= '1' ;  
	   ASEL    <= "00" ;
      BSEL    <= "000" ; 
		AOP     <= "000" ;
		Cin     <= '0' ; 
		LDA     <= '0' ;
		LDQ     <= '0' ;
		SRSEL   <= '0' ;
		SL      <= '0' ;
		SR      <= '0' ;
		BytWrSel<= '0' ;
		BytRrSel<= '0' ;
		DataWE  <= '0' ;
		CountRst<= '0' ;
		CountEn <= '0' ;
		DIV1    <= '0' ;
	
		STATE   <="100011";
      END IF ;
		
		IF y_present = s36 then 
		
	   pcWE <= '1';
		PCsel <= "10"; 
	   DSEL    <= "000"; 
		DestSel <= "11" ;
	   RegWE   <= '1' ;  
	   ASEL    <= "00" ;
      BSEL    <= "000" ; 
		AOP     <= "000" ;
		Cin     <= '0' ; 
		LDA     <= '0' ;
		LDQ     <= '0' ;
		SRSEL   <= '0' ;
		SL      <= '0' ;
		SR      <= '0' ;
		BytWrSel<= '0' ;
		BytRrSel<= '0' ;
		DataWE  <= '0' ;
		CountRst<= '0' ;
		CountEn <= '0' ;
		DIV1    <= '0' ;
	
		STATE   <="100100";
      END IF ;
		
		IF y_present = s37 then 
		
	   pcWE <= '1';
		PCsel <= "10"; 
	   DSEL    <= "111"; 
		DestSel <= "11" ;
	   RegWE   <= '1' ;  
	   ASEL    <= "00" ;
      BSEL    <= "000" ; 
		AOP     <= "000" ;
		Cin     <= '0' ; 
		LDA     <= '0' ;
		LDQ     <= '0' ;
		SRSEL   <= '0' ;
		SL      <= '0' ;
		SR      <= '0' ;
		BytWrSel<= '0' ;
		BytRrSel<= '0' ;
		DataWE  <= '0' ;
		CountRst<= '0' ;
		CountEn <= '0' ;
		DIV1    <= '0' ;
	
		STATE   <="100101";
      END IF ;
		
END PROCESS ; 		
END behavior;	  
 
 	