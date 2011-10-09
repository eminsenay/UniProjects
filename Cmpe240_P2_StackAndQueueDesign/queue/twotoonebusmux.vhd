library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity twotoonebusmux is
	Port (
		a,b: in std_logic_vector (5 downto 0);
	 	sel: in std_logic;
	 	o: out std_logic_vector (5 downto 0));
end twotoonebusmux;

architecture Behavioral of twotoonebusmux is

begin
	process(sel,a,b)
		begin
   		if (sel = '0') then
			o <= a;
		else
			o <= b;
		end if;
	end process;

end Behavioral;