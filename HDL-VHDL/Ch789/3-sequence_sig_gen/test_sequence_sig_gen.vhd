library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity test_sequence_sig_gen is
--  Port ( );
end test_sequence_sig_gen;

architecture Behavioral of test_sequence_sig_gen is
    component sequence_sig_gen is
        Port ( clk : in STD_LOGIC;
               en : in STD_LOGIC;
               s : out STD_LOGIC);
    end component;
    signal clk,en:STD_LOGIC;
    signal s:STD_LOGIC;
begin
    uut:sequence_sig_gen port map(clk,en,s);
    process
    begin
        clk<='0';
        en<='0';   wait for 10 ns;
        en<='1';   wait for 10 ns;
        while true loop    --endless clocks
        clk<='1';   wait for 10 ns;
        clk<='0';   wait for 10 ns;
        end loop;
    end process;
end Behavioral;
