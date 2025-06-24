library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;

entity test_MUX_8 is
end test_MUX_8;

architecture Behavioral of test_MUX_8 is
    component MUX_8 is
        port(data_in:       in STD_LOGIC_VECTOR(7 downto 0);
             sel1,sel2,sel3:in STD_LOGIC;
             d:             out STD_LOGIC
        );
    end component;
    signal data_in:        STD_LOGIC_VECTOR(7 downto 0);
    signal sel1,sel2,sel3: STD_LOGIC;
    signal d:              STD_LOGIC;
begin
    uut:MUX_8
    port map(data_in,sel1,sel2,sel3,d
    );
    data_in<=('U','Z','X','W','0','1','L','H');
    process
        variable sel:STD_LOGIC_VECTOR(2 downto 0);--used for better expressing
    begin
        for i in 0 to 7 loop
            sel:=std_logic_vector(to_unsigned(i,3));
            sel1<=sel(0);
            sel2<=sel(1);
            sel3<=sel(2);
            wait for 100 ns;
        end loop;
    end process;
end Behavioral;
