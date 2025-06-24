library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;

entity test_comb_logic is
end test_comb_logic;

architecture Behavioral of test_comb_logic is
    component comb_logic is
    port(x,y,z:in STD_LOGIC;
         q1,q2:out STD_LOGIC
    );
    end component;
    signal x,y,z:STD_LOGIC;
    signal q1,q2:STD_LOGIC;
begin
    uut:comb_logic
    port map(x,y,z,q1,q2
    );
    process
        variable data_in:STD_LOGIC_VECTOR(2 downto 0);
    begin
        for i in 0 to 7 loop
            data_in:=std_logic_vector(to_unsigned(i,3));
            x<=data_in(0);
            y<=data_in(1);
            z<=data_in(2);
            wait for 100 ns;
        end loop;
        x<='X'; y<='1'; z<='0';
        wait for 100 ns;
        x<='1'; y<='X'; z<='0';
        wait for 100 ns;
        x<='0'; y<='1'; z<='X';
        wait for 100 ns;
    end process;
end Behavioral;
