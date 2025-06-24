library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;

entity test_sequ is
--  Port ( );
end test_sequ;

architecture Behavioral of test_sequ is
    component sequ_scan is
        Port ( data : in STD_LOGIC;
            clk : in STD_LOGIC;
            rst_n : in STD_LOGIC;
            check : out STD_LOGIC);
    end component;
    signal data : STD_LOGIC;
    signal clk : STD_LOGIC;
    signal rst_n : STD_LOGIC;
    signal check : STD_LOGIC;
begin
    uut:sequ_scan port map(
        data=>data,
        clk=>clk,
        rst_n=>rst_n,
        check=>check
    );
    process
        variable num:STD_LOGIC_VECTOR(3 downto 0);
    begin
        rst_n<='0';
        data<='0';
        wait for 100 ns;
        rst_n<='1';
        wait for 50 ns;
        -- data<='0';  wait for 100 ns;
        -- data<='0';  wait for 100 ns;
        -- data<='1';  wait for 100 ns;
        -- data<='1';  wait for 100 ns;
        -- data<='0';  wait for 100 ns;
        -- data<='1';  wait for 100 ns;
        for i in 0 to 15 loop
            num:=STD_LOGIC_VECTOR(to_unsigned(i,4));
            data<=num(0);
            wait for 100 ns;
            data<=num(1);
            wait for 100 ns;
            data<=num(2);
            wait for 100 ns;
            data<=num(3);
            wait for 100 ns;
        end loop;
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
