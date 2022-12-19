-- Moldovan Maria

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity div_frecv_2min is
	port (clk_100Mhz: in std_logic; 
		  clk_05Hz: out std_logic); 
end div_frecv_2min;

architecture Behavioral of div_frecv_2min is	
signal clk_gate: std_logic := '0';
begin
	process(clk_100Mhz)
	variable nr: std_logic_vector(26 downto 0) := (others => '0'); -- 100Mhz = 10^8Hz; 10^8 ~ 2^26 deci 27 de biti																																								 
	begin 	  
		if clk_100Mhz'event and clk_100Mhz = '1' then 
			if nr = "101111101011110000100000000" then -- 50mil = 10^8 / 2 in binar
				nr := (others => '0');
				clk_gate <= not(clk_gate); -- 1/2s clk e high, 1/2s clk e low deci in total 1s = perioada clk_1Hz
			else nr := nr + 1; 
			end if;
		end if;
		clk_05Hz <= clk_gate;
	end process;
end architecture;			