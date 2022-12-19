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

entity dcd_int_to_vec is
  Port (Minutes, Seconds : in INTEGER;
  digits : out STD_LOGIC_VECTOR(15 downto 0));
end dcd_int_to_vec;

architecture Behavioral of dcd_int_to_vec is

begin
process(Minutes, Seconds)
begin
	case Minutes is 
		when 40 => digits(15 downto 12) <= "0100" ; digits(11 downto 8) <= "0000";
		when 41 => digits(15 downto 12) <= "0100" ; digits(11 downto 8) <= "0001";
		when 42 => digits(15 downto 12) <= "0100" ; digits(11 downto 8) <= "0010";
		when 50 => digits(15 downto 12) <= "0101" ; digits(11 downto 8) <= "0000";
		when 51 => digits(15 downto 12) <= "0101" ; digits(11 downto 8) <= "0001";
		when 52 => digits(15 downto 12) <= "0101" ; digits(11 downto 8) <= "0010";
		when 60 => digits(15 downto 12) <= "0110" ; digits(11 downto 8) <= "0000";
		when 61 => digits(15 downto 12) <= "0110" ; digits(11 downto 8) <= "0001";
		when 62 => digits(15 downto 12) <= "0110" ; digits(11 downto 8) <= "0010";
		when 70 => digits(15 downto 12) <= "0111" ; digits(11 downto 8) <= "0000";
		when 71 => digits(15 downto 12) <= "0111" ; digits(11 downto 8) <= "0001";
		when 72 => digits(15 downto 12) <= "0111" ; digits(11 downto 8) <= "0010";
		when others => digits(15 downto 8) <= "00000000";
	end case;
	
	case Seconds is
		when 30 => digits(7 downto 4) <= "0011" ; digits(3 downto 0) <= "0000";
		when 50 => digits(7 downto 4) <= "0101" ; digits(3 downto 0) <= "0000";
		when others => digits(7 downto 0) <= "00000000";
	end case;
end process;
end Behavioral;
