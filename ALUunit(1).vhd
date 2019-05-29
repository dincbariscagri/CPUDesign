library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity ALUunit is 
	port(
-- 		inputs:
	 	A, B 		: in signed(7 downto 0);		-- operands
		AOP 		: in std_logic_vector(2 downto 0);	-- operation
		cin		: in std_logic;				-- carry in, clock, CE-input (whether component should be active or not)
-- 		outputs:
		cout, n, z, ovf: out std_logic;			-- carry, sign, zero flag
		F 		: out signed(7 downto 0)		-- result
	);
end entity;
		
		
architecture calculation of ALUunit is 

	signal F_i : signed(8 downto 0) := "000000000";	
	-- internal signal for calculation
	-- is assigned to F-output and carry-flag with concurrent statement
	
	begin

--	councurrent statements

	n <= F_i(7); 
	-- sign-flag is determined by bit 15 of the result -> sign bit
	
	z <= '1' when F_i(7 downto 0) = "000000000" else '0'; 
	-- only setting zero flag if result is zero, so all bits of F have to be 0
	
	F    <= F_i(7 downto 0); 
	-- bits 15 downto 0 will be the result
	
		 
	cout <= F_i(8); 
	-- bit 16 of F_i is the carry-flag
	
	ovf <= '1' when (AOP = "000" and A(7) = B(7) and A(7)/=F_i(7)) or (AOP = "001" and A(7) /= B(7) and A(7) /= F_i(7)) or (AOP = "010" and A(7) /= B(7) and B(7) /= F_i(7)) else '0'; 
--	processes
	
	process(AOP) is
	begin 
		
			case AOP is 
				-- determining operation
				-- concatenating first when using arithmetic calculations
				-- when using logical operations, the carry-flag is always 0
				
				when "000" => 					-- ADD
					if cin = '1' then F_i <= ('0' & A) + ('0' & B) + 1;
					else              F_i <= ('0' & A) + ('0' & B);
					end if;
					
				when "010" => 					-- SUBR
					if(A(7) = '1') then	
						if cin = '1' then F_i <= ('0' & B) - ('1' & A);
						else              F_i <= ('0' & B) - ('1' & A) - 1;
						end if;
					else
						if cin = '1' then F_i <= ('0' & B) - ('0' & A);
						else              F_i <= ('0' & B) - ('0' & A) - 1;
						end if;
					end if;
					
				when "001" => 					-- SUBS
					if(B(7) = '1') then
							if cin = '1' then F_i <= ('0' & A) - ('1' & B);
							else              F_i <= ('0' & A) - ('1' & B) - 1;
							end if;
					else
							if cin = '1' then F_i <= ('0' & B) - ('0' & A);
							else              F_i <= ('0' & B) - ('0' & A) - 1;
							end if;
					end if;
					
				-- concatenation happening after calculation because carry flag is impossible to reach
				when "011" => F_i <= '0' & (A OR B);		-- OR
				when "100" => F_i <= '0' & (A AND B);		-- AND
				when "101" => F_i <= '0' & (NOT A AND B);	-- NOTRS
				when "110" => F_i <= '0' & (A XOR B); 		-- XOR
				when "111" => F_i <= '0' & (A XNOR B);		-- XNOR
				when others =>
			end case;
		
	end process;
end architecture;