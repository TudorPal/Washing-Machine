-- Moldovan Maria

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity div_frecv_1s is
	port (clk_100Mhz: in std_logic; -- perioada de 10ns
	  	  clk_60Hz: out std_logic); -- 1s in proiect inseamna 1/60 sec reale deci clk are frecventa de 60Hz
end div_frecv_1s;

architecture Behavioral of div_frecv_1s is
signal clk_gate: std_logic := '0';
begin
	process(clk_100Mhz)
	variable nr: std_logic_vector(19 downto 0) := (others => '0');																																				 
	begin 	  
		if clk_100Mhz'event and clk_100Mhz = '1' then 
			if nr = "11001011011100110101" then 
				nr := (others => '0');
				clk_gate <= not(clk_gate);
			else nr := nr + 1; 
			end if;
		end if;
		clk_60Hz <= clk_gate;
	end process;
end architecture;