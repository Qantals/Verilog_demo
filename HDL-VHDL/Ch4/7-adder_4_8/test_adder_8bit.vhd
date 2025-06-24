library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity test_adder_8bit is
end test_adder_8bit;

architecture Behavioral of test_adder_8bit is
    component adder_8bit is
        Port ( x : in STD_LOGIC_VECTOR (7 downto 0);
               y : in STD_LOGIC_VECTOR (7 downto 0);
               cin : in STD_LOGIC;
               sum : out STD_LOGIC_VECTOR (7 downto 0);
               cout : out STD_LOGIC);
    end component;
    signal x,y,sum : STD_LOGIC_VECTOR (7 downto 0);
    signal cin,cout : STD_LOGIC;
    
    signal check:STD_LOGIC;
begin
    uut:adder_8bit
    port map(x,y,cin,sum,cout
    );
    process
        variable check1,check2:STD_LOGIC_VECTOR(8 downto 0);
        type add_type is array(0 to 4) of STD_LOGIC_VECTOR(7 downto 0);
        type carry_type is array(0 to 4) of STD_LOGIC;
        constant x_cons:add_type:=("00000001","11111111","11111111","10110100","00010111");
        constant y_cons:add_type:=("00000001","11111111","11111111","01001000","00101110");
        constant cin_cons:carry_type:=('1','0','1','0','1');
    begin
        for i in 0 to 4 loop
            x<=x_cons(i);   y<=y_cons(i);   cin<=cin_cons(i);
            wait for 1 ns;
            check1:=('0' & x)+('0' & y)+("00000000" & cin);
            check2:=cout & sum;
            if check1=check2 then
                check<='1';
            else
                check<='0';
            end if;
            wait for 100 ns;
        end loop;
    end process;
end Behavioral;
