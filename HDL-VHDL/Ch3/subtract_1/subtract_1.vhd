library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity subtract_1 is
    Port ( Ai,Bi,Ci : in STD_LOGIC;
           Di,Ci_p1 : out STD_LOGIC);
end subtract_1;

architecture Behavioral of subtract_1 is

begin
Di<=Ai xor Bi xor Ci;
Ci_p1<=(not Ai and (Bi or Ci)) or (Bi and Ci);
end Behavioral;
