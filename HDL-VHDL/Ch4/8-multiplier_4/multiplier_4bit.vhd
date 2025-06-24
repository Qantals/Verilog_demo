library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity multiplier_4bit is
    Port ( x : in STD_LOGIC_VECTOR (3 downto 0);
           y : in STD_LOGIC_VECTOR (3 downto 0);
           mul : out STD_LOGIC_VECTOR (7 downto 0));
end multiplier_4bit;

architecture Behavioral of multiplier_4bit is

begin
    process(x,y)
        variable sum_tmp:STD_LOGIC_VECTOR(6 downto 0); --7 bit
        variable mul_tmp:STD_LOGIC_VECTOR(7 downto 0); --8 bit
        variable i_count:integer;
    begin
        mul_tmp:=(others=>'0');
        for i in 0 to 3 loop --multiply x*y,check every bit of y to summation
            if y(i)='1' then
--                sum_tmp:=(3 downto 0=>x ,others=>'0'); --don't know why it's forbidden
                sum_tmp:="000" & x;
                i_count:=i;
                while i_count>0 loop
                    sum_tmp:=sum_tmp(5 downto 0) & '0';
                    i_count:=i_count-1;
                end loop;
                mul_tmp:=mul_tmp+sum_tmp;
            end if;
        end loop;
        mul<=mul_tmp;
--        mul_tmp:=(others=>'0');
--        sum_tmp:="000" & x;
--        for i in 0 to 3 loop --multiply x*y,check every bit of y to summation
--            if y(i)='1' then
--                mul_tmp:=mul_tmp+('0' & sum_tmp);
--            end if;
--            sum_tmp:=sum_tmp(5 downto 0) & '0';
--        end loop;
--        mul<=mul_tmp;
    end process;
end Behavioral;
