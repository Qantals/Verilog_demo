----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2023/03/26 15:29:55
-- Design Name: 
-- Module Name: bit_calc - Behavioral
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

entity bit_calc is
    Port ( A : in STD_LOGIC_VECTOR (3 downto 0);
           B : in STD_LOGIC_VECTOR (3 downto 0);
           C : out STD_LOGIC_VECTOR (7 downto 0));
end bit_calc;

architecture Behavioral of bit_calc is

begin
C(1 DOWNTO 0) <= A(2 DOWNTO 1) OR B(1 DOWNTO 0);
C(3 DOWNTO 2) <= '1' & ('1' XOR NOT A(3));
C(7 DOWNTO 4) <= "1010" WHEN (A=B) ELSE "0100";

end Behavioral;
