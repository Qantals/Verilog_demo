library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity test_MUX_2 is
--  Port ( );
end test_MUX_2;

architecture Behavioral of test_MUX_2 is
component MUX_2 is
    Port ( SEL : in STD_LOGIC_VECTOR (1 downto 0);
           DATA : in STD_LOGIC_VECTOR (3 downto 0);
           Y : buffer STD_LOGIC;
           Y_L : out STD_LOGIC);
end component;
signal SEL : STD_LOGIC_VECTOR (1 downto 0);
signal DATA : STD_LOGIC_VECTOR (3 downto 0);
signal Y : STD_LOGIC;
signal Y_L : STD_LOGIC;
begin
uut: MUX_2  port map(SEL,DATA,Y,Y_L);
process
begin
  SEL<="00";DATA<="1110";
  wait for 100 ns;
  SEL<="00";DATA<="0001";
  wait for 100 ns;
  SEL<="01";DATA<="1101";
  wait for 100 ns;
  SEL<="01";DATA<="0010";
  wait for 100 ns;
  SEL<="10";DATA<="1011";
  wait for 100 ns;
  SEL<="10";DATA<="0100";
  wait for 100 ns;
  SEL<="11";DATA<="0111";
  wait for 100 ns;
  SEL<="11";DATA<="1000";
  wait for 100 ns;
end process;
end Behavioral;
