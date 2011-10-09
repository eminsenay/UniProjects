library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity BusDFlipFlop is
    Port (D : in std_logic_vector (5 downto 0);
	 res, clk : in std_logic;
	 Q: out std_logic_vector (5 downto 0));
end BusDFlipFlop;

architecture Behavioral of BusDFlipFlop is

begin
	STATE_CHANGE : process (clk, res) is
	begin
		if (res = '1') then --reset 1 iken her sey sifirlaniyor
			Q <= "000000";
		elsif clk'event and clk = '1' then --reset 0 iken her sey D
			Q <= D;			
		end if;
	end process STATE_CHANGE;

end Behavioral;