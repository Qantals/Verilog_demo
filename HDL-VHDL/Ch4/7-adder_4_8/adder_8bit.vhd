library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity adder_8bit is
    Port ( x : in STD_LOGIC_VECTOR (7 downto 0);
           y : in STD_LOGIC_VECTOR (7 downto 0);
           cin : in STD_LOGIC;
           sum : out STD_LOGIC_VECTOR (7 downto 0);
           cout : out STD_LOGIC);
end adder_8bit;

architecture Behavioral of adder_8bit is
    component adder_4bit is
        Port ( x : in STD_LOGIC_VECTOR (3 downto 0);
               y : in STD_LOGIC_VECTOR (3 downto 0);
               cin : in STD_LOGIC;
               sum : out STD_LOGIC_VECTOR (3 downto 0);
               cout : out STD_LOGIC);
    end component;
    signal carry:STD_LOGIC;
begin
    adder1_low:adder_4bit
    port map(
        x=>x(3 downto 0),
        y=>y(3 downto 0),
        cin=>cin,
        sum=>sum(3 downto 0),
        cout=>carry
    );
    adder2_high:adder_4bit
    port map(
        x=>x(7 downto 4),
        y=>y(7 downto 4),
        cin=>carry,
        sum=>sum(7 downto 4),
        cout=>cout
    );
end Behavioral;
