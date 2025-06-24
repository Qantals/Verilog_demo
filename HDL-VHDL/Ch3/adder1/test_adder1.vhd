----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2023/03/24 11:13:06
-- Design Name: 
-- Module Name: test_adder1 - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity test_adder1 is
--  Port ( );
end test_adder1;

architecture Behavioral of test_adder1 is
component adder1 is
    Port ( x : in STD_LOGIC;
           y : in STD_LOGIC;
           cin : in STD_LOGIC;
           sum : out STD_LOGIC_VECTOR (1 downto 0);
           dig : out STD_LOGIC_VECTOR (5 downto 0);
           seg : out STD_LOGIC_VECTOR (6 downto 0));
end component;

signal x :  STD_LOGIC;
signal y :  STD_LOGIC;
signal cin :  STD_LOGIC;
signal sum :  STD_LOGIC_VECTOR (1 downto 0);
signal dig :  STD_LOGIC_VECTOR (5 downto 0);
signal seg :  STD_LOGIC_VECTOR (6 downto 0);

begin
uut:adder1 port map (x=>x,y=>y,cin=>cin,sum=>sum,dig=>dig,seg=>seg);
process
begin
    x<='0';  y<='0';  cin<='0';
    wait for 10ns;
    
    x<='0';  y<='0';  cin<='1';
    wait for 10ns;
    
    x<='0';  y<='1';  cin<='0';
    wait for 10ns;
    
    x<='0';  y<='1';  cin<='1';
    wait for 10ns;
    
    x<='1';  y<='0';  cin<='0';
    wait for 10ns;
    
    x<='1';  y<='0';  cin<='1';
    wait for 10ns;
    
    x<='1';  y<='1';  cin<='0';
    wait for 10ns;
    
    x<='1';  y<='1';  cin<='1';
    wait for 10ns;
end process;

end Behavioral;
