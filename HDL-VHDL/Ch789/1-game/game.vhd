library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity game is
    Port ( p_a : in STD_LOGIC;
           p_b : in STD_LOGIC;
           p_c : in STD_LOGIC;
           winner : out STD_LOGIC_VECTOR (1 downto 0));
end game;

architecture Behavioral of game is
    signal diff:STD_LOGIC;
begin
    winner<="00" when (p_b=p_c) and (p_a/=p_b) else
            "01" when (p_a=p_c) and (p_b/=p_a) else
            "10" when (p_a=p_b) and (p_c/=p_a) else
            "11";
end Behavioral;
