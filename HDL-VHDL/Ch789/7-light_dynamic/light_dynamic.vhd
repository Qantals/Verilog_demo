library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity light_dynamic is
    Port ( clk : in STD_LOGIC;
           rst_n : in STD_LOGIC;
           -- light_en : in STD_LOGIC;
           mode : in STD_LOGIC_VECTOR(1 downto 0);
           light : out STD_LOGIC_VECTOR (7 downto 0));
end light_dynamic;

architecture Behavioral of light_dynamic is
    signal count_div:STD_LOGIC_VECTOR(23 downto 0);
    signal clk_2hz:STD_LOGIC;
    signal count_light:STD_LOGIC_VECTOR(4 downto 0);
    signal count_light_start:STD_LOGIC_VECTOR(4 downto 0);
    signal count_light_stop:STD_LOGIC_VECTOR(4 downto 0);
    signal count_light_en:STD_LOGIC;
    signal count_light_rst_n:STD_LOGIC;
    signal count_light_work:STD_LOGIC;

    constant ready:STD_LOGIC_VECTOR(1 downto 0):="00";
    constant step1:STD_LOGIC_VECTOR(1 downto 0):="01";
    constant step2:STD_LOGIC_VECTOR(1 downto 0):="10";
    constant step3:STD_LOGIC_VECTOR(1 downto 0):="11";
    --constant step4:STD_LOGIC_VECTOR(2 downto 0):="100";
    signal state_cur,state_next:STD_LOGIC_VECTOR(1 downto 0);
begin
    -- divide 50MHz-->2Hz,25M dividion,12.5M counters
    -- 12,500,000d=1011 1110 1011 1100 0010 0000b
    -- 12,499,999d=1011 1110 1011 1100 0001 1111b

     process(clk,rst_n)
     begin
         if rst_n='0' then
             count_div<="000000000000000000000000";
             clk_2hz<='0';
         elsif clk'event and clk='1' then
             if count_div="101111101011110000011111" then
                 count_div<="000000000000000000000000";
                 clk_2hz<=not clk_2hz;
             else
                 count_div<=count_div+1;
             end if;
         end if;
     end process;
    -- clk_2hz<=clk;

    -- state machine
    process(clk,rst_n)
    begin
        if rst_n='0' then
            state_cur<=ready;
        elsif clk'event and clk='1' then
            state_cur<=state_next;
        end if;
    end process;

    process(state_cur,mode,count_light_work)
    begin
        case state_cur is
            when ready=>
                case mode is
                    when "00"=> state_next<=ready;
                    when "01"=> state_next<=step1;
                    when "10"=> state_next<=step2;
                    when "11"=> state_next<=step3;
                    when others=> state_next<=ready;
                end case;
            when others=>
                if count_light_work='0' then
                    state_next<=ready;
                else
                    state_next<=state_next;
                end if;
        end case;
    end process;

    process(state_cur)
    begin
        case state_cur is
            when ready=>
                count_light_rst_n<='0';
                count_light_en<='0';
            when others=>
                count_light_rst_n<='1';
                count_light_en<='1';
        end case;
    end process;

    -- counter's start & end decoder
    
    process(state_cur,mode,rst_n)
    begin
        if state_cur=ready then
            if rst_n='0' then
                count_light_start<="00000";
            else
                case mode is
                    when "00"=> count_light_start<="00000";
                    when "01"=> count_light_start<="00001";
                    when "10"=> count_light_start<="00011";
                    when "11"=> count_light_start<="01011";
                    when others=> count_light_start<="00000";
                end case;
            end if;
        end if;
    end process;
    process(state_cur,mode)
    begin
        if state_cur=ready then
            case mode is
                when "00"=> count_light_stop<="00000";
                when "01"=> count_light_stop<="00010";
                when "10"=> count_light_stop<="01010";
                when "11"=> count_light_stop<="10100";
                when others=> count_light_stop<="00000";
            end case;
        end if;
    end process;

    -- light counter
    -- step 1: 3 counters (0_0000~0_0010)
    -- step 2: 8 counters (0_0011~0_1010)
    -- step 3: 5 counters (0_1011~0_1111)
    -- step 4: 5 counters (1_0000~1_0100)
    process(clk_2hz,count_light_en,count_light_rst_n,count_light_start,count_light_stop)
    begin
        if count_light_rst_n='0' then
            count_light<=count_light_start;
            count_light_work<='1';
        elsif clk_2hz'event and clk_2hz='1' then
            if count_light_en='1' then
                if count_light=count_light_stop then
                    count_light_work<='0';
                else
                    count_light<=count_light+1;
                end if;
            end if;
        end if;
    end process;

    -- light decoder
    process(count_light)
    begin
        case count_light is
            -- step 1
            when "00000"|"00010"=>
                light<=(others=>'0');
            when "00001"=>
                light<=(others=>'1');

            -- step 2
            when "00011"=>
                light<=(7=>'1',others=>'0');
            when "00100"=>
                light<=(6=>'1',others=>'0');
            when "00101"=>
                light<=(5=>'1',others=>'0');
            when "00110"=>
                light<=(4=>'1',others=>'0');
            when "00111"=>
                light<=(3=>'1',others=>'0');
            when "01000"=>
                light<=(2=>'1',others=>'0');
            when "01001"=>
                light<=(1=>'1',others=>'0');
            when "01010"=>
                light<=(0=>'1',others=>'0');

            -- step 3
            when "01011"=>
                light<=(7=>'1',0=>'1',others=>'0');
            when "01100"=>
                light<=(7 downto 6=>'1',1 downto 0=>'1',others=>'0');
            when "01101"=>
                light<=(7 downto 5=>'1',2 downto 0=>'1',others=>'0');
            when "01110"=>
                light<=(others=>'1');
            when "01111"=>
                light<=(others=>'0');

            -- step 4
            when "10000"=>
                light<=(4 downto 3=>'1',others=>'0');
            when "10001"=>
                light<=(5 downto 2=>'1',others=>'0');
            when "10010"=>
                light<=(6 downto 1=>'1',others=>'0');
            when "10011"=>
                light<=(others=>'1');
            when "10100"=>
                light<=(others=>'0');
            
            when others=>light<=(others=>'0');
        end case;
    end process;

end Behavioral;
