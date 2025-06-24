library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity converter_seri_para is
    Port(clk,din: in STD_LOGIC;
         qout:    out STD_LOGIC_VECTOR (7 downto 0));
end converter_seri_para;

architecture Behavioral of converter_seri_para is
    signal data:STD_LOGIC_VECTOR(7 downto 0);
begin
    qout<=data;
    process(clk)
    begin
        if clk'event and clk='1' then
            data<=data(6 downto 0) & din;
        end if;
    end process;
end Behavioral;
