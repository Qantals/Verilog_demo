library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity test_converter is
end test_converter;

architecture Behavioral of test_converter is
    component converter_seri_para is
        Port(clk,din: in STD_LOGIC;
             qout:    out STD_LOGIC_VECTOR (7 downto 0));
    end component;
    signal clk,din:STD_LOGIC;
    signal qout:STD_LOGIC_VECTOR(7 downto 0);
begin
    uut:converter_seri_para
    port map(clk,din,qout
    );
    process
        type din_type1 is array (0 to 1) of STD_LOGIC_VECTOR(0 to 7);
        constant din_cons1:din_type1:=("UZXW01LH","01001101");
--        type din_type2 is array (0 to 1,0 to 7) of STD_LOGIC;
--        constant din_cons2:din_type2:=("UZXW01LH","01001101");
    begin
        clk<='0';
        din<='0';
        for i in 0 to 1 loop
            for j in 0 to 7 loop
                din<=din_cons1(i)(j);
--                din<=din_cons2(i,j);
                clk<='1';    wait for 100 ns;
                clk<='0';    wait for 100 ns;
            end loop;
        end loop;
    end process;
end Behavioral;
