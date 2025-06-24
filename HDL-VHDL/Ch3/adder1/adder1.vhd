----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2023/03/24 10:52:40
-- Design Name: 
-- Module Name: adder1 - Behavioral
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

entity adder1 is
    Port ( x : in STD_LOGIC;
           y : in STD_LOGIC;
           cin : in STD_LOGIC;
           sum : out STD_LOGIC_VECTOR (1 downto 0);
           dig : out STD_LOGIC_VECTOR (5 downto 0);
           seg : out STD_LOGIC_VECTOR (6 downto 0));
end adder1;

architecture Behavioral of adder1 is
signal sum_tmp:STD_LOGIC_VECTOR(1 downto 0);
begin
    sum_tmp(0)<= x xor y xor cin;
    sum_tmp(1)<= (x and y) or (x and cin) or (y and cin);
    sum<=sum_tmp;
    dig<="111110";
    process(sum_tmp)
    begin
        case sum_tmp is
        when "00" => seg<="1111110"; --number 0
        when "01" => seg<="0110000"; --number 1
        when "10" => seg<="1101101"; --number 2
        when "11" => seg<="1111001"; --number 3
        when others=>seg<="0000000";--others:off
        end case;
    end process;
        
end Behavioral;
