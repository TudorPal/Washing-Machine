----------------------------------------------------------------------------------
-- Company: UTCN
-- Student: Pal Tudor 
-- 
-- Design Name: 
-- Module Name: sumator_timp
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


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

entity sumator_timp is
    Port ( enable, presp, clatire, CLK, reset : in STD_LOGIC;
           viteza, temp : in STD_LOGIC_VECTOR(1 downto 0);
           sel : in STD_LOGIC_VECTOR(2 downto 0);
           digits : out STD_LOGIC_VECTOR(15 downto 0));
end sumator_timp;

architecture Behavioral of sumator_timp is
signal timp : STD_LOGIC_VECTOR(15 downto 0);
begin
    digits <= timp;
    process(enable, presp, clatire,viteza, temp, sel)
    begin
    if reset = '1' then
        timp <= X"0000";
    elsif rising_edge(CLK) then
        case sel is
            when "001" => timp(15 downto 12) <= "0100"; --4
                          timp(11 downto 8) <= "0000"; --0
                          timp(7 downto 4) <= "0011"; --3
                          timp(3 downto 0) <= "0000"; --0
            when "010" => timp(15 downto 12) <= "0100"; --4
                          timp(11 downto 8) <= "0001"; --1
                          timp(7 downto 4) <= "0011"; --3
                          timp(3 downto 0) <= "0000"; --0
            when "011" => timp(15 downto 12) <= "0101"; --5
                          timp(11 downto 8) <= "0000"; --0 
                          timp(7 downto 4) <= "0101"; --5  
                          timp(3 downto 0) <= "0000"; --0  
            when "100" => timp(15 downto 12) <= "0110"; --6
                          timp(11 downto 8) <= "0000"; --0 
                          timp(7 downto 4) <= "0101"; --5  
                          timp(3 downto 0) <= "0000"; --0  
            when "101" => timp(15 downto 12) <= "0101"; --5
                          timp(11 downto 8) <= "0010"; --2 
                          timp(7 downto 4) <= "0011"; --3  
                          timp(3 downto 0) <= "0000"; --0  
            when "000" => case temp is
				when "00" => if presp = '0' and clatire = '0' then timp(15 downto 0) <= B"0100_0000_0011_0000";	   
							elsif presp = '0' and clatire = '1' then timp(15 downto 0) <= B"0101_0000_0011_0000";	
							elsif presp = '1' and clatire = '0' then timp(15 downto 0) <= B"0110_0000_0011_0000";
							else timp(15 downto 0) <= B"0111_0000_0011_0000";
							end if;
				when "01" => if presp = '0' and clatire = '0' then timp(15 downto 0) <= B"0100_0000_0101_0000";	   
							elsif presp = '0' and clatire = '1' then timp(15 downto 0) <= B"0101_0000_0101_0000";	
							elsif presp = '1' and clatire = '0' then timp(15 downto 0) <= B"0110_0000_0101_0000";
							else timp(15 downto 0) <= B"0111_0000_0101_0000";
							end if;
				when "10" => if presp = '0' and clatire = '0' then timp(15 downto 0) <= B"0100_0001_0011_0000";	   
							elsif presp = '0' and clatire = '1' then timp(15 downto 0) <= B"0101_0001_0011_0000";	
							elsif presp = '1' and clatire = '0' then timp(15 downto 0) <= B"0110_0001_0011_0000";
							else timp(15 downto 0) <= B"0111_0001_0011_0000";
							end if;
				when "11" => if presp = '0' and clatire = '0' then timp(15 downto 0) <= B"0100_0010_0011_0000";	   
							elsif presp = '0' and clatire = '1' then timp(15 downto 0) <= B"0101_0010_0011_0000";	
							elsif presp = '1' and clatire = '0' then timp(15 downto 0) <= B"0110_0010_0011_0000";
							else timp(15 downto 0) <= B"0111_0010_0011_0000";
							end if;
						   end case;
             when others => timp <= X"0000";
                            timp <= X"0000";
            end case; 
       end if; 
    end process;

end Behavioral;