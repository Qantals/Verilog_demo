library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity division_11_3_11 is
    Port ( clk_in : in STD_LOGIC;
           clk_out : out STD_LOGIC;
           rst_n : in STD_LOGIC
    );
end division_11_3_11;

architecture Behavioral of division_11_3_11 is
    signal count_11:integer range 0 to 10;
begin
    process(clk_in,rst_n)
    begin
        if rst_n='0' then
            count_11<=0;
        elsif clk_in'event and clk_in='1' then
            if count_11=10 then
                count_11<=0;
            else
                count_11<=count_11+1;
            end if;
        end if;
    end process;

    process(count_11)
    begin
        if count_11<3 then
            clk_out<='1';
        else
            clk_out<='0';
        end if;
    end process;

end Behavioral;
