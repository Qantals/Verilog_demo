library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MUX_8 is
    port(data_in:       in STD_LOGIC_VECTOR(7 downto 0);
         sel1,sel2,sel3:in STD_LOGIC;
         d:             out STD_LOGIC
    );
end MUX_8;

architecture Behavioral of MUX_8 is
    signal sel:STD_LOGIC_VECTOR(2 downto 0);
begin
    sel<=sel3 & sel2 & sel1;
    with sel select
        d<=data_in(0) when "000",
           data_in(1) when "001",
           data_in(2) when "010",
           data_in(3) when "011",
           data_in(4) when "100",
           data_in(5) when "101",
           data_in(6) when "110",
           data_in(7) when "111",
           'Z' when others;
end Behavioral;