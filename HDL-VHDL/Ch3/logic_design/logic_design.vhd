library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity logic_design is
    Port ( A,B,C,D,E : in STD_LOGIC;
                   F : out STD_LOGIC);
end logic_design;

architecture Behavioral of logic_design is
signal n1,n2,n3,n4:STD_LOGIC;
begin
n1<=A and B;
n2<=C nand D;
n3<=not E;
n4<=n1 or n2;
F<=n3 xor n4;
end Behavioral;
