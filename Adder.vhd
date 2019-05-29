library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.STD_LOGIC_SIGNED.ALL;

entity Adder is 
	port(
-- 		inputs:
	 	A		: in STD_LOGIC;
		B		: in std_LOGIC_VECTOR(5 downto 0);
		PC		: in std_LOGIC_VECTOR(9 downto 0);		-- operands
		F 			: out STD_LOGIC_VECTOR(9 downto 0)		-- result
	);
end Adder;

architecture calculation of Adder is 
signal G : std_LOGIC_VECTOR(9 downto 0);
	begin			
	process(A,B)
	Begin
				G(9) <= A;
				G(8) <= A;
				G(7) <= A;
				G(6) <= A;
				G(5 downto 0) <= B;
	end process;
		F <= PC + G;
end architecture;