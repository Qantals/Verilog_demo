library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;

entity test_decoder_4_16 is
end test_decoder_4_16;

architecture Behavioral of test_decoder_4_16 is
    component decoder_4_16 is
        Port(g1,g2a,g2b: in STD_LOGIC;
             sel :       in STD_LOGIC_VECTOR (3 downto 0);
             y_l :       out STD_LOGIC_VECTOR (15 downto 0)
        );
    end component;
    signal g1,g2a,g2b:STD_LOGIC;
    signal sel :      STD_LOGIC_VECTOR (3 downto 0);
    signal y_l :      STD_LOGIC_VECTOR (15 downto 0);
begin
    uut:decoder_4_16
    port map(g1,g2a,g2b,sel,y_l
    );
    process
        variable en_test:boolean:=false;
    begin
        --test for enable port
        if en_test=false then
            sel<=(2 downto 1=>'1',others=>'0');
            g1<='0'; g2a<='0';  g2b<='0';
            wait for 100 ns;            
            g1<='1'; g2a<='1';  g2b<='0';
            wait for 100 ns;
            g1<='1'; g2a<='0';  g2b<='1';
            wait for 100 ns;
            en_test:=true;
        else
            --test for select port
            g1<='1'; g2a<='0';  g2b<='0';
            for i in 0 to 15 loop
                sel<=std_logic_vector(to_unsigned(i,4));
                wait for 100 ns;
            end loop;
        end if;
    end process;
end Behavioral;
