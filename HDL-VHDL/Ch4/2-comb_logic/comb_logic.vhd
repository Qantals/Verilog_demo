library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity comb_logic is
    port(x,y,z:in STD_LOGIC;
         q1,q2:out STD_LOGIC
    );
end comb_logic;

architecture Behavioral of comb_logic is
    signal data_in:STD_LOGIC_VECTOR(2 downto 0);
begin
    data_in<=x & y & z;
--    with data_in select
--        q1<='1' when "000",
--            '0' when "001",
--            '0' when "010",
--            '0' when "011",
--            '0' when "100",
--            '0' when "101",
--            '0' when "110",
--            '1' when "111",
--            'X' when others;
--    with data_in select
--        q2<='0' when "000",
--            '1' when "001",
--            '1' when "010",
--            '1' when "011",
--            '1' when "100",
--            '1' when "101",
--            '1' when "110",
--            '1' when "111",
--            'X' when others;
    with data_in select
                q1<='1' when "000" | "111",
                    '0' when "001" | "010" | "011" | "100" | "101" | "110",
                    'X' when others;
    with data_in select
                q2<='1' when "001" | "010" | "011" | "100" | "101" | "110" | "111",
                    '0' when "000",
                    'X' when others;
end Behavioral;
