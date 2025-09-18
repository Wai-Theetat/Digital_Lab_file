library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ModN is
	generic
	(
		max_n		:	integer := 16;
		max_bits	:	integer := 4
	);
	port
	(
		clkIn, CLR	:	in	STD_LOGIC;
		TC			:	out	STD_LOGIC;
		bits		:	out	STD_LOGIC_VECTOR(max_bits - 1 downto 0)
	);
end ModN;

architecture Behavioral of ModN is
	signal counting : integer := 0;
begin
	process(clkIn, CLR)
	begin
		if (CLR = '1') then
			counting <= 0;
		
		elsif(rising_edge(clkIn)) then
			if (counting = max_n-1) then			-- Overflow loop back to 0 & sent TC
				counting <= 0;
				TC		 <= '1';
			else
				TC	<= '0';
				counting <= counting + 1;
			end if;
		end if;
		
		bits <= STD_LOGIC_VECTOR (to_unsigned(counting, bits'length));
	
	end process;
end Behavioral;

