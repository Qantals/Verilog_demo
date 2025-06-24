library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity adder_4bit is
    Port ( x : in STD_LOGIC_VECTOR (3 downto 0);
           y : in STD_LOGIC_VECTOR (3 downto 0);
           cin : in STD_LOGIC;
           sum : out STD_LOGIC_VECTOR (3 downto 0);
           cout : out STD_LOGIC);
end adder_4bit;

architecture Behavioral of adder_4bit is

begin
    process(x,y,cin)
        variable sum_tmp:STD_LOGIC_VECTOR(4 downto 0); --5 bit
    begin
        sum_tmp:=('0' & x)+('0' & y)+("0000" & cin);
--        sum_tmp:=x+y+cin; --wrong,width dismatch!
        sum<=sum_tmp(3 downto 0);
        cout<=sum_tmp(4);
    end process;
end Behavioral;
