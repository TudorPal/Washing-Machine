-- Moldovan Maria & Pal Tudor

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL; 

entity timer_ssd is
    port (clk_60Hz: in STD_LOGIC;
          R, EN: in STD_LOGIC; -- reset asincron
          --PL: in STD_LOGIC;  
		  digit_3, digit_2, digit_1, digit_0: in STD_LOGIC_vector(3 downto 0); -- fiecare cifra e reprezentata pe 4 STD_LOGIC_VECTOR 
          Q3, Q2, Q1, Q0: out STD_LOGIC_vector(3 downto 0));																				
end timer_ssd;

architecture Behavioral of timer_ssd is
signal tc3, tc2, tc1, tc0: STD_LOGIC; -- terminal count pentru fiecare numarator; reprezinta clk pentru urmatorul numarator 
signal q_or: STD_LOGIC_vector(3 downto 0);
signal Q3_aux, Q2_aux, Q1_aux, Q0_aux: STD_LOGIC_vector(3 downto 0) := "0000"; 
signal EN1, EN2: std_logic := '1'; 

component count5_0 is
  Port (CLK, ENABLE,R : in STD_LOGIC;
  I : in STD_LOGIC_VECTOR(3 downto 0);
  Q : out STD_LOGIC_VECTOR(3 downto 0);
  tc : out STD_LOGIC);
end component;	 

component count9_0 is
  Port (CLK, ENABLE,R : in STD_LOGIC;
  I : in STD_LOGIC_VECTOR(3 downto 0);
  Q : out STD_LOGIC_VECTOR(3 downto 0);
  tc : out STD_LOGIC);
end component;			

begin				

	num_0: count9_0 port map(CLK => clk_60Hz,	 
							   --PL => PL,
							   R => R,
							   ENABLE => EN2, 
							   I => digit_0,
							   tc => tc0,
							   Q => Q0_aux);
	
	num_1: count5_0 port map(CLK => tc0,	
							   --PL => PL,
							   R => R,
							   ENABLE => EN2, 
							   I => digit_1,
							   tc => tc1,
							   Q => Q1_aux);		  
	
	num_2: count9_0 port map(CLK => tc1,	 
							   --PL => PL,
							   R => R,
							   ENABLE => EN1, 
							   I => digit_2,
							   tc => tc2,
							   Q => Q2_aux);   
							   
	num_3: count9_0 port map(CLK => tc2,	 
							   --PL => PL,
							   R => R,
							   ENABLE => EN1, 
							   I => digit_3,
							   tc => tc3,
							   Q => Q3_aux);   	
							   
	Q3 <= Q3_aux; 
	Q2 <= Q2_aux;
	Q1 <= Q1_aux;
	Q0 <= Q0_aux;
	--q_or <= (Q3_aux + Q2_aux + Q1_aux + Q0_aux);
	--EN <= (q_or(3) or q_or(2) or q_or(1) or q_or(0));	  

	process(clk_60Hz)
	begin 
		if clk_60Hz'event and clk_60Hz = '1' then 
			if Q3_aux = "0000" and Q2_aux = "0000" and Q1_aux = "0000" and Q0_aux = "0001" then 
				EN2 <= '0';
			elsif Q3_aux = "0000" and Q2_aux = "0000" and Q1_aux = "0101" and Q0_aux = "1001" then
				EN1 <= '0';
		    end if;
		end if;
	end process;
	
end Behavioral;