library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity sevenSegmentCtl is
	generic (
		u_amount : integer := 1
	);
	port
	(
		clkIn		 : in	STD_LOGIC;
		full_bits_in : in	STD_LOGIC_VECTOR (((4*u_amount) - 1) downto 0);
		
		bits_out 		: out	STD_LOGIC_VECTOR (6 downto 0);
		common	: out	STD_LOGIC_VECTOR (3 downto 0)
	);
end sevenSegmentCtl;

architecture Behavioral of sevenSegmentCtl is
	--Declare 7 segme
	function BCDto7Segment (binaryIn : STD_LOGIC_VECTOR (3 downto 0) := "1010") return STD_LOGIC_VECTOR is
		variable segments : STD_LOGIC_VECTOR (6 downto 0);
	begin
		case binaryIn is
			when "0000" => segments := "1111110"; -- 0
			when "0001" => segments := "0110000"; -- 1
			when "0010" => segments := "1101101"; -- 2
			when "0011" => segments := "1111001"; -- 3
			when "0100" => segments := "0110011"; -- 4
			when "0101" => segments := "1011011"; -- 5
			when "0110" => segments := "1011111"; -- 6
			when "0111" => segments := "1110000"; -- 7
			when "1000" => segments := "1111111"; -- 8
			when "1001" => segments := "1111011"; -- 9
			when "1010" => segments := "1110111"; -- 10(A)
			when "1011" => segments := "0011111"; -- 11(b)
			when "1100" => segments := "1001110"; -- 12(C)
			when "1101" => segments := "0111101"; -- 13(d)
			when "1110" => segments := "1001111"; -- 14(E)
			when "1111" => segments := "1000111"; -- 15(f)
			when others => segments := "0000000"; -- blank/invalid BCD
		end case;
		
		return segments;
	end function;

	--Declare current Common
	signal current_com : integer := 0;

begin
	-- Rotate Common
	process (clkIn)
	begin
		--
		if (rising_edge(clkIn)) then
			if (current_com = u_amount - 1) then		--if common fully rotate 
				current_com <= 0;
			else
				current_com <= current_com + 1;
			end if;
		end if;
	end  process;
	
	process(current_com)
	begin
		common 				<= "1111";		--Common Cathode > 0 = on
		common(current_com)	<= '0';
		bits_out			<= BCDto7Segment(full_bits_in((current_com*4 + 3) downto (current_com*4)));
	end process;
end Behavioral;