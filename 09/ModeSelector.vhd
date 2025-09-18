library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ModeSelector is
	port
	(
		clk    : in  STD_LOGIC;  -- FPGA clock OSC
		btn    : in  STD_LOGIC;  -- push button
		mode   : out STD_LOGIC_VECTOR(1 downto 0) -- 00=ADD, 01=SUB, 10=XOR, 11=SHL
	);
end ModeSelector;


architecture Behavioral of ModeSelector is
		signal mode_reg   : unsigned(1 downto 0) := "00";
		signal btn_sync   : STD_LOGIC_VECTOR(1 downto 0) := "11"; -- for edge detect
begin

	process(clk)
	begin
		if rising_edge(clk) then
			btn_sync <= btn_sync(0) & btn;

			if (btn_sync = "10") then
				mode_reg <= mode_reg + 1; --Change mode
			end if;
		end if;
	end process;

	mode <= STD_LOGIC_VECTOR(mode_reg) ;
end Behavioral;

