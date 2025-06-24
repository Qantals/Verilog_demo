library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;

entity test_encoder is
end test_encoder;

architecture Behavioral of test_encoder is
    component encoder is
        Port(b3,b2,b1,b0:in STD_LOGIC;
             a1,a0:      out STD_LOGIC
        );
    end component;
    signal b3,b2,b1,b0:STD_LOGIC;
    signal a1,a0:      STD_LOGIC;
    
    signal b_sig:STD_LOGIC_VECTOR(3 downto 0);
    signal a_sig:STD_LOGIC_VECTOR(1 downto 0);
begin
    uut:encoder
    port map(b3,b2,b1,b0,a1,a0
    );
    a_sig<=a1 & a0;
    process
        variable b:STD_LOGIC_VECTOR(3 downto 0);
    begin
        for i in 0 to 15 loop
            b:=std_logic_vector(to_unsigned(i,4));
            b_sig<=b;
            b3<=b(3);
            b2<=b(2);
            b1<=b(1);
            b0<=b(0);
            wait for 100 ns;
        end loop;
    end process;
end Behavioral;
