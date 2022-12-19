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

entity main is
    Port ( clk : in STD_LOGIC;
           btn : in STD_LOGIC_VECTOR (4 downto 0);
           sw : in STD_LOGIC_VECTOR (15 downto 0);
           led : out STD_LOGIC_VECTOR (15 downto 0);
           an : out STD_LOGIC_VECTOR (3 downto 0);
           cat : out STD_LOGIC_VECTOR (6 downto 0));
end main;

architecture Behavioral of main is
signal enable, reset : std_logic;


component MPG is
    Port ( clk : in STD_LOGIC;
           btn : in STD_LOGIC;
           enable : out STD_LOGIC);
end component;

component SSD is
    Port ( digit : in STD_LOGIC_VECTOR(15 downto 0);
           clk : in STD_LOGIC;
           an : out STD_LOGIC_VECTOR (3 downto 0);
           cat : out STD_LOGIC_VECTOR (6 downto 0));
end component SSD;

component sumator_timp is
    Port ( enable, presp, clatire, CLK, reset : in STD_LOGIC;
           viteza, temp : in STD_LOGIC_VECTOR(1 downto 0);
           sel : in STD_LOGIC_VECTOR(2 downto 0);
           digits : out STD_LOGIC_VECTOR(15 downto 0));
end component;

component div_frecv_2min is
	port (clk_100Mhz: in std_logic; 
		  clk_05Hz: out std_logic); 
end component;

component div_frecv_1min is
	port (clk_100Mhz: in std_logic; -- perioada de 10ns
		  clk_1Hz: out std_logic); -- 1min in proiect inseamna 1s reala deci clk are frecventa de 1Hz
end component;

component div_frecv_1s is
	port (clk_100Mhz: in std_logic; -- perioada de 10ns
	  	  clk_60Hz: out std_logic); -- 1s in proiect inseamna 1/60 sec reale deci clk are frecventa de 60Hz
end component;

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

component timer_ssd is
    port (clk_60Hz: in STD_LOGIC;
          R, EN: in STD_LOGIC; -- reset asincron
          --PL: in STD_LOGIC;  
		  digit_3, digit_2, digit_1, digit_0: in STD_LOGIC_vector(3 downto 0); -- fiecare cifra e reprezentata pe 4 STD_LOGICi 
          Q3, Q2, Q1, Q0: out STD_LOGIC_vector(3 downto 0));																				
end component;

component dcd_int_to_vec is
  Port (Minutes, Seconds : in INTEGER;
  digits : out STD_LOGIC_VECTOR(15 downto 0));
end component;

component timer_usa is
  Port (CLK_1HZ : in STD_LOGIC;
  enable : inout STD_LOGIC;
  led_out : out STD_LOGIC);
end component;

signal digits : STD_LOGIC_VECTOR (15 downto 0);
signal timp : STD_LOGIC_VECTOR(15 downto 0) := X"0000";
signal sel : STD_LOGIC_VECTOR(2 downto 0);
signal temp, viteza : STD_LOGIC_VECTOR(1 downto 0);
signal presp, clatire : STD_LOGIC;
signal CLK_1HZ, CLK_60HZ, clk_05Hz : STD_LOGIC;
--signal aux1, aux2 : STD_LOGIC;
--signal MIN, SEC : INTEGER;
signal count : STD_LOGIC_VECTOR(1 downto 0);
signal seg0, seg1, seg2, seg3, out3, out2, out1, out0 : STD_LOGIC_VECTOR(3 downto 0);
signal res_timer, led_usa : STD_LOGIC := '1';
signal enable_usa : STD_LOGIC;

begin
sel <= sw(15 downto 13);
temp <= sw(12 downto 11);
viteza <= sw(10 downto 9);
presp <= sw(8);
clatire <= sw(7);

led(1 downto 0) <= count;

MPG_enable : MPG port map(clk,btn(0),enable);
MPG_reset : MPG port map(clk,btn(1),reset);
SUMATOR_TIMP1 : sumator_timp port map(enable, presp, clatire, CLK, reset, viteza, temp, sel, timp);
SSD1 : SSD port map(digits, clk, an, cat);
CLK1min : div_frecv_1min port map(clk_100Mhz => clk, clk_1Hz=>CLK_1HZ);    -- 1min in program / 1 sec in realitate
CLK2min : div_frecv_2min port map(clk_100Mhz => clk, clk_05Hz=>clk_05Hz);    -- 1min in program / 1 sec in realitate
CLK1sec : div_frecv_1s port map(clk_100Mhz => clk, clk_60Hz => CLK_60HZ);     -- 1 sec in program / 0.0167 sec in realitate
--count5 : count5_0 port map(CLK_1HZ, '1', '0', "0100", digits(15 downto 12), aux1);
--count9 : count9_0 port map(CLK_60HZ, '1', '0', "0100", digits(11 downto 8), aux2);
timer : timer_ssd port map(CLK_60HZ, res_timer, enable, seg3, seg2, seg1, seg0, out3, out2, out1, out0);
usa : timer_usa port map(CLK_05HZ, enable_usa, led_usa);

process(CLK ,ENABLE)
begin
if enable = '1' then
    if rising_edge(CLK) then
        count<= count + 1;
     end if;
     
end if;
end process;

process( count, timp)
begin
case count is
when "01" => digits <= timp;
              seg3 <= timp(15 downto 12);
              seg2 <= timp(11 downto 8);
              seg1 <= timp(7 downto 4);
              seg0 <= timp(3 downto 0);
              res_timer <= '1';
              led(15 downto 7) <= sel & temp & viteza & presp & clatire;
when "10" => digits <= out3 & out2 & out1 & out0;
              led(15 downto 7) <= "000000000";
              led(2) <= led_usa;
              res_timer <= '0';
              if(digits = X"0000") then
              enable_usa <= '1';
              else enable_usa <='0';
              end if;
when others => digits <= X"0000";
end case;
end process;


end Behavioral;
