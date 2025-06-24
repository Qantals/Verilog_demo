library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

--g1:enable,high active
--g2a,g2b:enable,low active
--sel:select,high active
--y_l:decode,low active

entity decoder_4_16 is
    Port(g1,g2a,g2b: in STD_LOGIC;
         sel :       in STD_LOGIC_VECTOR (3 downto 0);
         y_l :       out STD_LOGIC_VECTOR (15 downto 0)
    );
end decoder_4_16;

architecture Behavioral of decoder_4_16 is

begin
    process(g1,g2a,g2b,sel)
    begin
        if g1='1' and g2a='0' and g2b='0' then
            case sel is
                when "0000"=>   y_l<=(0=>'0',others=>'1');
                when "0001"=>   y_l<=(1=>'0',others=>'1');
                when "0010"=>   y_l<=(2=>'0',others=>'1');
                when "0011"=>   y_l<=(3=>'0',others=>'1');
                when "0100"=>   y_l<=(4=>'0',others=>'1');
                when "0101"=>   y_l<=(5=>'0',others=>'1');
                when "0110"=>   y_l<=(6=>'0',others=>'1');
                when "0111"=>   y_l<=(7=>'0',others=>'1');
                when "1000"=>   y_l<=(8=>'0',others=>'1');
                when "1001"=>   y_l<=(9=>'0',others=>'1');
                when "1010"=>   y_l<=(10=>'0',others=>'1');
                when "1011"=>   y_l<=(11=>'0',others=>'1');
                when "1100"=>   y_l<=(12=>'0',others=>'1');
                when "1101"=>   y_l<=(13=>'0',others=>'1');
                when "1110"=>   y_l<=(14=>'0',others=>'1');
                when "1111"=>   y_l<=(15=>'0',others=>'1');
                when others =>   y_l<=(others=>'1');
            end case;
        else
            y_l<=(others=>'1');
        end if;
    end process;
end Behavioral;
