library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity test_devision is
--  Port ( );
end test_devision;

architecture Behavioral of test_devision is
    component division_11_1_2 is
        Port ( clk_in : in STD_LOGIC;
            rst_n : in STD_LOGIC;
            clk_out : out STD_LOGIC
        );
    end component;
    signal clk_in : STD_LOGIC;
    signal clk_out : STD_LOGIC;
    signal rst_n : STD_LOGIC;
begin
    uut:division_11_1_2
        port map(
            clk_in=>clk_in,
            clk_out=>clk_out,
            rst_n=>rst_n
    );
    process
    begin
        rst_n<='0';
        clk_in<='0';
        wait for 100 ns;
        rst_n<='1';
        clk_in<='1';
        while true loop
            wait for 50 ns;
            clk_in<=not clk_in;
        end loop;
    end process;

end Behavioral;
