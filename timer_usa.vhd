-- Pal Tudor

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity timer_usa is
  Port (CLK_1HZ : in STD_LOGIC;
  enable : in STD_LOGIC;
  led_out : out STD_LOGIC);
end timer_usa;

architecture Behavioral of timer_usa is
begin	 	

process(CLK_1HZ, enable)
begin
if enable = '1' then
    if falling_edge(CLK_1HZ) then 
        led_out <= '0';
     end if;
else
    if falling_edge(CLK_1HZ) then 
        led_out <= '1';
     end if;
end if;
end process;

end Behavioral;
