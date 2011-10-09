library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity pulsecatch is
    Port ( P : in std_logic;
           R : in std_logic;
           Z : out std_logic);
end pulsecatch;

architecture Behavioral of pulsecatch is
signal a,b,c,d,e,y1,y2: std_logic;
begin
a <= P and R;
b <= P and y1;
c <= y2 and not R;
d <= not y1 and y2 and P;
e <= not y1 and P and not R;
y1 <= a or b;
y2 <= c or d or e;
Z <= y2;

end Behavioral;
