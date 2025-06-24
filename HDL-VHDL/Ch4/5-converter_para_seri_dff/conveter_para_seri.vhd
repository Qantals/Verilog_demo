
--use behavioral description

--library IEEE;
--use IEEE.STD_LOGIC_1164.ALL;

--entity conveter_para_seri is
--    Port(Din : in STD_LOGIC_VECTOR (7 downto 0);
--         CLK,EN : in STD_LOGIC;
--         Dout : out STD_LOGIC
--    );
--end conveter_para_seri;

--architecture Behavioral of conveter_para_seri is
--    signal data:STD_LOGIC_VECTOR(7 downto 0);
--begin
--    Dout<=data(7);
--    process(CLK)
--    begin
--        if CLK'event and CLK='1' then
--            if EN='0' then --parallel loading
--                data<=Din;
--            else --shift to serial out
--                data<=data(6 downto 0) & data(7);--rotate left 
--            end if;
--        end if;
--    end process;
--end Behavioral;














--use layer description

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity conveter_para_seri is
    Port(Din : in STD_LOGIC_VECTOR (7 downto 0);
         CLK,EN : in STD_LOGIC;
         Dout : out STD_LOGIC
    );
end conveter_para_seri;

architecture Behavioral of conveter_para_seri is
    component dff1 is
        Port(d:  in STD_LOGIC;
             clk:in STD_LOGIC;
             q:  out STD_LOGIC
        );
    end component;
    signal d_sig,q_sig:STD_LOGIC_VECTOR(7 downto 0);
begin
    dff_gen:for i in 0 to 7 generate
        dff_ins:dff1
        port map(
            d   =>d_sig(i),
            clk =>CLK,
            q   =>q_sig(i)
        );
    end generate dff_gen;
    
    Dout<=q_sig(7);
    process(EN,Din,q_sig)
    begin
        if EN='0' then --parallel loading
            d_sig<=Din;
        else --EN='1'--convert parallel to serial
            d_sig<=q_sig(6 downto 0) & q_sig(7);--rotate left  
        end if;
    end process;
end Behavioral;
