library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MUX_2 is
    Port ( SEL : in STD_LOGIC_VECTOR (1 downto 0);
           DATA : in STD_LOGIC_VECTOR (3 downto 0);
           Y : buffer STD_LOGIC;
           Y_L : out STD_LOGIC);
end MUX_2;

architecture Behavioral of MUX_2 is

begin
with SEL select
Y<=DATA(0) when "00",
   DATA(1) when "01",
   DATA(2) when "10",
   DATA(3) when "11",
   '0' when others;
Y_L<=not Y;
end Behavioral;
