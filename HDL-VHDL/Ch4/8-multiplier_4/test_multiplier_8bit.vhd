library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity test_multiplier_8bit is
end test_multiplier_8bit;

architecture Behavioral of test_multiplier_8bit is
    component multiplier_4bit is
        Port ( x : in STD_LOGIC_VECTOR (3 downto 0);
               y : in STD_LOGIC_VECTOR (3 downto 0);
               mul : out STD_LOGIC_VECTOR (7 downto 0));
    end component;
    signal x,y:STD_LOGIC_VECTOR(3 downto 0);
    signal mul:STD_LOGIC_VECTOR(7 downto 0);
    signal check:STD_LOGIC;
begin
    uut:multiplier_4bit
    port map(x,y,mul
    );
    process
        type mul_type is array(0 to 4) of STD_LOGIC_VECTOR(3 downto 0);
        constant x_cons:mul_type:=("0001","1111","0101","1101","0111");
        constant y_cons:mul_type:=("0001","1111","1010","0100","0010");
    begin
        for i in 0 to 4 loop
            x<=x_cons(i);   y<=y_cons(i);
            wait for 1 ns;
            if x*y=mul then
                check<='1';
            else
                check<='0';
            end if;
            wait for 100 ns;
        end loop;
    end process;
end Behavioral;
