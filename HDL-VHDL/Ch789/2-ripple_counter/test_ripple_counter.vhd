library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity test_ripple_counter is
--  Port ( );
end test_ripple_counter;

architecture Behavioral of test_ripple_counter is
    component ripple_counter is
        Port ( clk,res : in STD_LOGIC;
               q : out STD_LOGIC_VECTOR (3 downto 0));
    end component;
    signal clk,res :STD_LOGIC;
    signal q :STD_LOGIC_VECTOR (3 downto 0);
begin
    uut:ripple_counter port map(clk,res,q);
    process
    begin
        clk<='0';
        res<='1';    wait for 50 ns;
        res<='0';    wait for 50 ns;  --initialization and reset for counting
        while true loop    --endless clocks
        clk<='1';   wait for 50 ns;
        clk<='0';   wait for 50 ns;
        end loop;
    end process;
end Behavioral;
