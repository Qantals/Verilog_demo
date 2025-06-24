library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ripple_counter is
    Port ( clk,res : in STD_LOGIC;
           q : out STD_LOGIC_VECTOR (3 downto 0));
end ripple_counter;

architecture Behavioral of ripple_counter is
    component d_flipflop is
        Port ( d : in STD_LOGIC;
               clk,res : in STD_LOGIC;
               q : out STD_LOGIC);
    end component;
    signal d_dff,q_dff:STD_LOGIC_VECTOR(3 downto 0);
    -- signal d_dff,q_dff:STD_LOGIC_VECTOR range 3 downto 0;  false expression
begin
    dff0_3_for:for i in 0 to 3 generate
        dff0_if:if i=0 generate
            dff0:d_flipflop
                port map(d=>d_dff(i),clk=>clk,res=>res,q=>q_dff(i));  --special for clk
        end generate dff0_if;
        dff1_3_if:if i/=0 generate
            dff1_3:d_flipflop
            port map(d=>d_dff(i),clk=>q_dff(i-1),res=>res,q=>q_dff(i));  --special for clk
        end generate dff1_3_if;
    end generate dff0_3_for;
    d_dff<=not q_dff;
    q<=q_dff;
end Behavioral;
