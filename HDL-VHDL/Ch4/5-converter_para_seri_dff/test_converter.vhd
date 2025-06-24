library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity test_converter is
end test_converter;

architecture Behavioral of test_converter is
    component conveter_para_seri is
        Port(Din : in STD_LOGIC_VECTOR (7 downto 0);
             CLK,EN : in STD_LOGIC;
             Dout : out STD_LOGIC
        );
    end component;
    signal Din:   STD_LOGIC_VECTOR (7 downto 0);
    signal CLK,EN:STD_LOGIC;
    signal Dout:  STD_LOGIC;
begin
    uut:conveter_para_seri
    port map(Din,CLK,EN,Dout
    );
    process
    begin
        for1:for m in 0 to 1 loop
            --EN='0'--parallel loading
            CLK<='0';
            EN<='0';
            --choose 2 inputs
            if m=0 then
                Din<="UZXW01LH"; --input 1:"UZXW01LH"
            else
                Din<="01001101"; --input 2:"01001101"
            end if;    
            wait for 100 ns;
            CLK<='1';
            wait for 100 ns;
            CLK<='0';
            --EN='1'--convert parallel to serial
            EN<='1';
            wait for 100 ns;
            for2:for i in 0 to 7 loop
                CLK<='1';
                wait for 100 ns;
                CLK<='0';
                wait for 100 ns;
            end loop for2;
        end loop for1;
    end process;
end Behavioral;
