library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
--use IEEE.STD_LOGIC_ARITH.ALL;

entity division_11_1_2 is
    Port ( clk_in : in STD_LOGIC;
           rst_n: in STD_LOGIC;
           clk_out : out STD_LOGIC);
end division_11_1_2;

architecture Behavioral of division_11_1_2 is
    signal count_rising:STD_LOGIC_VECTOR(3 downto 0);
    signal count_falling:STD_LOGIC_VECTOR(3 downto 0);
    signal count:STD_LOGIC_VECTOR(7 downto 0);
begin
    process(clk_in,rst_n)
    begin
        if rst_n='0' then
            count_rising<="0000";
        elsif clk_in'event and clk_in='1'then  --rising edge
            if count_rising="1010" then
                count_rising<="0000";
            else
                count_rising<=count_rising+1;
            end if;
        end if;
    end process;

    process(clk_in,rst_n)
    begin
        if rst_n='0' then
            count_falling<="0000";
        elsif clk_in'event and clk_in='0'then  --falling edge
            if count_falling="1010" then
                count_falling<="0000";
            else
                count_falling<=count_falling+1;
            end if;
        end if;
    end process;
    
    count<=count_rising & count_falling;
    
    process(count,rst_n)
    begin
        if rst_n='0' then
            clk_out<='0';
        elsif count<"01010101" then
            clk_out<='1';
        else
            clk_out<='0';
        end if;
    end process;
    
--    s_div<='1' when count<"001001" else
--       '0';

end Behavioral;
