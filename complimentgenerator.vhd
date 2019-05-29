library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.STD_LOGIC_SIGNED.ALL;
use IEEE.numeric_std.all;

entity complimentgenerator is 
	port(
	 	A, B 				: in std_logic_vector(7 downto 0);
		OpCode			: in std_logic_vector(3 downto 0);
		Aout,Bout		: out std_logic_vector(7 downto 0)
		);
end complimentgenerator;
		
		
architecture selector of complimentgenerator is 
begin
 process(OpCode)
 Begin
		IF OpCode = "0011" then
			IF A(7) = '1' then
				Aout <= not(A)+1;
			ELSE
				Aout <= A;
			END IF;
			
			IF B(7) = '1' then
				Bout <= not(B)+1;
			ELSE
				Bout <= B;
			END IF;
			
		ELSE
		
			Aout <= A;
			Bout <= B;
			
		END IF;
	end process;
end selector;


	