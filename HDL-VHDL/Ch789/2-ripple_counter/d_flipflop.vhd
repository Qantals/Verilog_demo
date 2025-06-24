library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity d_flipflop is
    Port ( d : in STD_LOGIC;
           clk : in STD_LOGIC;
           res : in STD_LOGIC;
           q : out STD_LOGIC);
end d_flipflop;

architecture Behavioral of d_flipflop is

begin
    process(clk,res)
    begin
        if res='1' then
            q<='0';
        elsif clk'event and clk='1' then
            q<=d;
        end if;
    end process;
end Behavioral;
