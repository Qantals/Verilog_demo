library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

--b3~b0:active low
--b0 has the highest priority
--a1~a0:active high
--input can only be '1' or '0'

entity encoder is
    Port(b3,b2,b1,b0:in STD_LOGIC;
         a1,a0:      out STD_LOGIC
    );
end encoder;

architecture Behavioral of encoder is
begin
    process(b3,b2,b1,b0)
    begin
        if b0='0' then
            a1<='0';    a0<='0';
        elsif b1='0' then
            a1<='0';    a0<='1';
        elsif b2='0' then
            a1<='1';    a0<='0';
        else
            a1<='1';    a0<='1';
        end if;
    end process;
--    process(b3,b2,b1,b0)
--        variable data_in:STD_LOGIC_VECTOR(3 downto 0);
--    begin
--        data_in:=b3 & b2 & b1 & b0;
--        case data_in is
--            when "0000"|"0010"|"0100"|"0110"|"1000"|"1010"|"1100"|"1110" =>
--                a1<='0';    a0<='0';
--            when "0001"|"0101"|"1001"|"1101"=>
--                a1<='0';    a0<='1';
--            when "0011"|"1011"=>
--                a1<='1';    a0<='0';
--            when others=>
--                a1<='1';    a0<='1';
--        end case;
--    end process;
end Behavioral;
