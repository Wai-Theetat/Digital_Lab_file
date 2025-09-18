library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity ALU8 is
	port
	(
		A, B    : in  STD_LOGIC_VECTOR (7 downto 0);
		sel     : in  STD_LOGIC_VECTOR (1 downto 0); -- 00=ADD, 01=SUB, 10=XOR, 11=SHL
		result  : out STD_LOGIC_VECTOR (7 downto 0)
	);
end ALU8;

architecture Behavioral of ALU8 is
	function two_compliment(bits_in : STD_LOGIC_VECTOR (7 downto 0)) return STD_LOGIC_VECTOR is
		variable bits_out : STD_LOGIC_VECTOR (7 downto 0);
		variable tmp	  : signed (7 downto 0);
	begin
			tmp := (not signed(bits_in)) + 1;
			bits_out := STD_LOGIC_VECTOR(tmp);
			return bits_out;
	end function;

begin
	process(A, B, sel)
		begin
			case sel is
				when "00" => result <= std_logic_vector(signed(A) + signed(B)); -- ADD
				when "01" => result <= std_logic_vector(signed(A) + signed(two_compliment(B))); -- SUB
				when "10" => result <= A xor B; -- XOR
				when "11" => result <= A(6 downto 0) & '0'; -- SHL (shift left by 1)
				when others => result <= (others => '0');
			end case;
		end process;
end Behavioral;