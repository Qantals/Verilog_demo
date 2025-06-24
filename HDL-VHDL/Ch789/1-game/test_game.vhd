library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;

entity test_game is
--  Port ( );
end test_game;

architecture Behavioral of test_game is
    component game is
        Port ( p_a : in STD_LOGIC;
               p_b : in STD_LOGIC;
               p_c : in STD_LOGIC;
               winner : out STD_LOGIC_VECTOR (1 downto 0));
    end component;
    signal p_a,p_b,p_c:STD_LOGIC;
    signal winner:STD_LOGIC_VECTOR(1 downto 0);
begin
    uut:game
    port map(p_a,p_b,p_c,winner
    );
    process
        variable data:STD_LOGIC_VECTOR(2 downto 0);
    begin
        for i in 0 to 7 loop
            data:=std_logic_vector(to_unsigned(i,3));
            p_a<=data(2);p_b<=data(1);p_c<=data(0);
            wait for 100 ns;
        end loop;
    end process;
end Behavioral;
