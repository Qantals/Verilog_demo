library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity sequence_sig_gen is
    Port ( clk : in STD_LOGIC;
           en : in STD_LOGIC;
           s : out STD_LOGIC);
end sequence_sig_gen;

architecture Behavioral of sequence_sig_gen is
    signal clk_2hz:STD_LOGIC;
    signal count_num:integer range 1 to 8;
begin
    division:process(clk,en)  --50Mhz-->2Hz,need 25M division,12.5Mcounters.
        variable count_div:integer range 1 to 125e5;
    begin
        if en='0' then
            count_div:=1;
            clk_2hz<='0';
        elsif clk'event and clk='1'then
            if count_div=125e5 then
                count_div:=1;
                clk_2hz<=not clk_2hz;
            else
                count_div:=count_div+1;
            end if;
        end if;
    end process;

    counter:process(clk_2hz,en)
    begin
        if en='0' then
        count_num<=1;
    elsif clk_2hz'event and clk_2hz='1'then
        if count_num=8 then
            count_num<=1;
        else
            count_num<=count_num+1;
        end if;
    end if;
    end process;
    
    sequence:process(count_num,en)  --11001001
    begin
        if en='0' then
            s<='0';
        else
            case count_num is
                when 1|2|5|8=> s<='1';
                when 3|4|6|7=> s<='0';
                when others=>  s<='0';
            end case;
        end if;
    end process;

end Behavioral;
