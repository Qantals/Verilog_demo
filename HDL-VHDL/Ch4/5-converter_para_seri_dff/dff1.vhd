library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity dff1 is
    Port(d:  in STD_LOGIC;
         clk:in STD_LOGIC;
         q:  out STD_LOGIC
    );
end dff1;

architecture Behavioral of dff1 is
begin
    process(clk)
    begin
        if clk'event and clk='1' then
            q<=d;
        end if;
    end process;
end Behavioral;
