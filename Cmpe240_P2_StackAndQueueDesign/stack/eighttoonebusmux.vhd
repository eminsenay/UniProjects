library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity eighttoonebusmux is
	Port (
		a,b,c,d,e,f,g,h: in std_logic_vector (5 downto 0);
		enable : in std_logic;
		S2,S1,S0: in std_logic;
		o: out std_logic_vector (5 downto 0));
end eighttoonebusmux;

architecture Behavioral of eighttoonebusmux is
signal tmp: std_logic_vector(0 to 2);

begin
	tmp <= S2 & S1 & S0;
	process (a, b, c, d, e, f, g, h, tmp, enable) begin
		if (enable = '0') then
			o <= "000000";
		else		
			case tmp is
				when "000" => o <= a;
				when "001" => o <= b;
				when "010" => o <= c;
				when "011" => o <= d;
				when "100" => o <= e;
				when "101" => o <= f;
				when "110" => o <= g;
				when others => o <= h;
			end case;	
		end if;
	end process;

end Behavioral;