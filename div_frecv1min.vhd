-- Moldovan Maria

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity div_frecv_1min is
	port (clk_100Mhz: in std_logic; -- perioada de 10ns
		  clk_1Hz: out std_logic); -- 1min in proiect inseamna 1s reala deci clk are frecventa de 1Hz
end div_frecv_1min;

architecture Behavioral of div_frecv_1min is	
signal clk_gate: std_logic := '0';
begin
	process(clk_100Mhz)
	variable nr: std_logic_vector(26 downto 0) := (others => '0'); -- 100Mhz = 10^8Hz; 10^8 ~ 2^26 deci 27 de biti																																								 
	begin 	  
		if clk_100Mhz'event and clk_100Mhz = '1' then 
			if nr = "010111110101111000010000000" then -- 50mil = 10^8 / 2 in binar
				nr := (others => '0');
				clk_gate <= not(clk_gate); -- 1/2s clk e high, 1/2s clk e low deci in total 1s = perioada clk_1Hz
			else nr := nr + 1; 
			end if;
		end if;
		clk_1Hz <= clk_gate;
	end process;
end architecture;			