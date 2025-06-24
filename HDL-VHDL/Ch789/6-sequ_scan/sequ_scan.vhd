--Moore Machine

-- library IEEE;
-- use IEEE.STD_LOGIC_1164.ALL;

-- entity sequ_scan is
--     Port ( data : in STD_LOGIC;
--            clk : in STD_LOGIC;
--            rst_n : in STD_LOGIC;
--            check : out STD_LOGIC);
-- end sequ_scan;

-- architecture Behavioral of sequ_scan is
--     --type state_enum is (s1,s2,s3,s4,s_ok);
--     constant s1:STD_LOGIC_VECTOR(2 downto 0):="000";
--     constant s2:STD_LOGIC_VECTOR(2 downto 0):="001";
--     constant s3:STD_LOGIC_VECTOR(2 downto 0):="010";
--     constant s4:STD_LOGIC_VECTOR(2 downto 0):="011";
--     constant s_ok:STD_LOGIC_VECTOR(2 downto 0):="100";
--     signal state_cur,state_next:STD_LOGIC_VECTOR(2 downto 0);
-- begin
--     process(clk,rst_n)
--     begin
--         if rst_n='0' then
--             state_cur<=s1;
--         elsif clk'event and clk='1' then
--             state_cur<=state_next;
--         end if;
--     end process;

--     process(state_cur,data)
--     begin
--         case state_cur is
--             when s1=>
--                 if data='0' then
--                     state_next<=s2;
--                 else
--                      state_next<=s1;
--                 end if;
--             when s2=>
--                 if data='1' then
--                     state_next<=s3;
--                 else
--                     state_next<=s1;
--                 end if;
--             when s3=>
--                 if data='1' then
--                     state_next<=s4;
--                 else
--                     state_next<=s1;
--                 end if;
--             when s4=>
--                 if data='0' then
--                     state_next<=s_ok;
--                 else
--                     state_next<=s1;
--                 end if;
--             when s_ok=>
--                     state_next<=s1;
--             when others=>
--                     state_next<=s1;
--         end case;
--     end process;

--     check<='1' when state_cur=s_ok else
--         '0';

-- end Behavioral;







--Mealy Machine
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity sequ_scan is
    Port ( data : in STD_LOGIC;
           clk : in STD_LOGIC;
           rst_n : in STD_LOGIC;
           check : out STD_LOGIC);
end sequ_scan;

architecture Behavioral of sequ_scan is
    --type state_enum is (s0,s1,s2,s_ok);
    constant s0:STD_LOGIC_VECTOR(1 downto 0):="00";
    constant s1:STD_LOGIC_VECTOR(1 downto 0):="01";
    constant s2:STD_LOGIC_VECTOR(1 downto 0):="10";
    constant s_ok:STD_LOGIC_VECTOR(1 downto 0):="11";
    signal state_cur,state_next:STD_LOGIC_VECTOR(1 downto 0);
begin
    process(clk,rst_n)
    begin
        if rst_n='0' then
            state_cur<=s0;
        elsif clk'event and clk='1' then
            state_cur<=state_next;
        end if;
    end process;

    process(state_cur,data)
    begin
        case state_cur is
            when s0=>
                check<='0';
                if data='0' then
                    state_next<=s1;
                else
                     state_next<=s0;
                end if;
            when s1=>
                check<='0';
                if data='1' then
                    state_next<=s2;
                else
                    state_next<=s0;
                end if;
            when s2=>
                check<='0';
                if data='1' then
                    state_next<=s_ok;
                else
                    state_next<=s0;
                end if;
            when s_ok=>
                if data='0' then
                    check<='1';
                else
                    check<='0';
                end if;
                state_next<=s0;
            when others=>
                check<='0';
                state_next<=s0;
        end case;
    end process;


end Behavioral;
