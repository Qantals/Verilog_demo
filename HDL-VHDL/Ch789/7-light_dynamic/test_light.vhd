library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity test_light is
--  Port ( );
end test_light;

architecture Behavioral of test_light is
    component light_dynamic is
        Port ( clk : in STD_LOGIC;
            rst_n : in STD_LOGIC;
            mode : in STD_LOGIC_VECTOR(1 downto 0);
            light : out STD_LOGIC_VECTOR (7 downto 0));
    end component;
    signal clk : STD_LOGIC;
    signal rst_n : STD_LOGIC;
    signal mode : STD_LOGIC_VECTOR(1 downto 0);
    signal light : STD_LOGIC_VECTOR (7 downto 0);
begin
    uut:light_dynamic port map(
        clk=>clk,
        rst_n=>rst_n,
        mode=>mode,
        light=>light
    );
    process
        variable num:STD_LOGIC_VECTOR(3 downto 0);
    begin
        rst_n<='0';
        mode<="00";
        wait for 50 ns;
        rst_n<='1';
        wait for 1000 ns;
        mode<="01"; wait for 500 ns;
        mode<="10"; wait for 500 ns;
        mode<="11"; wait for 1500 ns;
        mode<="10"; wait;
    end process;

    process
    begin
        clk<='0';
        wait for 100 ns;
        while true loop
            clk<='1';
            wait for 50 ns;
            clk<='0';
            wait for 50 ns;
        end loop;
    end process;

end Behavioral;
