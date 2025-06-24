library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity test_subtracter_1 is
--  Port ( );
end test_subtracter_1;

architecture Behavioral of test_subtracter_1 is
component subtract_1 is
    Port ( Ai,Bi,Ci : in STD_LOGIC;
           Di,Ci_p1 : out STD_LOGIC);
end component;
signal Ai,Bi,Ci :  STD_LOGIC;
signal Di,Ci_p1 :  STD_LOGIC;
begin
uut: subtract_1  port map(Ai,Bi,Ci,Di,Ci_p1);
process
begin
  Ai<='0';Bi<='0'; Ci<='0';
  wait for 100 ns;
  Ai<='0';Bi<='0'; Ci<='1';
  wait for 100 ns;
  Ai<='0';Bi<='1'; Ci<='0';
  wait for 100 ns;
  Ai<='0';Bi<='1'; Ci<='1';
  wait for 100 ns;
  Ai<='1';Bi<='0'; Ci<='0';
  wait for 100 ns;
  Ai<='1';Bi<='0'; Ci<='1';
  wait for 100 ns;
  Ai<='1';Bi<='1'; Ci<='0';
  wait for 100 ns;
  Ai<='1';Bi<='1'; Ci<='1';
  wait for 100 ns;
end process;
end Behavioral;
