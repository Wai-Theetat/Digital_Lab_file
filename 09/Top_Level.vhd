library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Top_Level is
	port(
		CLK		: in STD_LOGIC; 							--FPGA System clock
		BTN_Mode : in STD_LOGIC;
		
		SW_A		: in STD_LOGIC_VECTOR(7 downto 0);
		SW_B		: in STD_LOGIC_VECTOR(7 downto 0);
		
		Segment	: out STD_LOGIC_VECTOR(6 downto 0);
		Common	: out STD_LOGIC_VECTOR(3 downto 0);
		
		Status_LED : out STD_LOGIC_VECTOR(1 downto 0)
	);
end Top_Level;

architecture Structural of Top_Level is
		signal mode_now	: STD_LOGIC_VECTOR(1 downto 0) := "00"; 
		signal clk_use	: STD_LOGIC :=	'0';
		signal alu_out	: STD_LOGIC_VECTOR(7 downto 0);
		signal dummy_tc : STD_LOGIC;
begin
	-- Mode Selector
	Mode_Switcher : entity work.ModN
	generic map
	(
		max_n		=> 4,
		max_bits	=> 2
	)
	port map
	(
		clkIn		=>	BTN_Mode,
		CLR		=>	'0',
		TC			=>	dummy_tc,
		bits		=>	mode_now
	);
	
	--LED Display Mode
	Status_LED 	<=	mode_now;
	
	--	Mod	Freq for display mux
	Mod_Display : entity work.ModN
	generic map
	(
		max_n		=> 20,
		max_bits	=> 5
	)
	port map
	(
		clkIn		=>	CLK,
		CLR			=>	'0',
		TC			=>	clk_use,
		bits		=>	open
	);
	 
	-- ALU core
   U1: entity work.ALU8
		port map
		(
            A      => SW_A,
            B      => SW_B,
            sel    => mode_now,
            result => alu_out
		);
		
	-- 7-Seg control
	U2: entity work.sevenSegmentCtl
		generic map
		(
			u_amount => 2
		)
		port map
		(
			clkIn		 => clk_use,
			full_bits_in => alu_out,
			
			bits_out 	 => Segment,
			common	 	 => Common
		);
end Structural;

