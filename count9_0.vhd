-- Moldovan Maria

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

entity count9_0 is
  Port (CLK, ENABLE,R : in STD_LOGIC;
  I : in STD_LOGIC_VECTOR(3 downto 0);
  Q : out STD_LOGIC_VECTOR(3 downto 0);
  tc : out STD_LOGIC);
end count9_0;

architecture Behavioral of count9_0 is
signal cifra : STD_LOGIC_VECTOR(3 downto 0); 
signal PL : STD_LOGIC := '1';
begin
process (CLK, PL, R, ENABLE)
begin  
	if ENABLE='1' then
		if(PL = '1') then
			cifra(0) <= I(0);
			cifra(1) <= I(1);
			cifra(2) <= I(2);
			cifra(3) <= I(3);
			PL <='0';
		elsif(R = '1') then  -- revine la 0 daca avem activ reset-ul
			cifra(0) <= I(0);
            cifra(1) <= I(1);
            cifra(2) <= I(2);
            cifra(3) <= I(3);
		elsif(CLK'event and CLK = '1') then	 
			case cifra is
                when "1001" => cifra <= "1000";
                when "1000" => cifra <= "0111";
                when "0111" => cifra <= "0110";
                when "0110" => cifra <= "0101";
                when "0101" => cifra <= "0100";
                when "0100" => cifra <= "0011";
                when "0011" => cifra <= "0010";
                when "0010" => cifra <= "0001";
                when "0001" => cifra <= "0000"; 
                when others => cifra <= "1001";
            end case;
            if (cifra = "0000") or (I = "0000" and PL = '1') then
                        tc <= '1';
                    else
                        tc <= '0';    
                    end if;		
		end if;	   
		
	end if;
		Q <= cifra; 	   
end process;

end Behavioral;
