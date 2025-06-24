library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity test_logic_design is
--  Port ( );
end test_logic_design;

architecture Behavioral of test_logic_design is
component logic_design is
    Port ( A,B,C,D,E : in STD_LOGIC;
                   F : out STD_LOGIC);
end component;
signal A,B,C,D,E:std_logic;
signal F:std_logic;
begin
uut: logic_design  port map(A,B,C,D,E,F);
process
begin
  A<='1';B<='0';C<='0';D<='0';E<='0';
  wait for 100 ns;
  A<='0';B<='1';C<='0';D<='0';E<='0';
  wait for 100 ns;
  A<='0';B<='0';C<='1';D<='0';E<='0';
  wait for 100 ns;
  A<='0';B<='0';C<='0';D<='1';E<='0';
  wait for 100 ns;
  A<='0';B<='0';C<='0';D<='0';E<='1';
  wait for 100 ns;
end process;
end Behavioral;
