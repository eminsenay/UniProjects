library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity threebitupdowncounter is
    port(clk, CLR, up, down : in std_logic;
        Q : out std_logic_vector(2 downto 0);
		  err,full,empty: out std_logic);
end threebitupdowncounter;

architecture Behavioral of threebitupdowncounter is


signal tmp: std_logic_vector(2 downto 0);

begin 
	process (clk, CLR)
	begin				 		 
    	if (CLR='1') then
        	tmp <= "000";
			err <= '0';
        elsif (clk'event and clk='1') then
        	if (up = '1' and down = '0' and (tmp = "000" or tmp = "001" or tmp = "010" or tmp = "011")) then
        		tmp <= tmp + 1;			   
			elsif (up = '0' and down = '1' and (tmp = "001" or tmp = "010" or tmp = "011" or tmp = "100" )) then
				tmp <= tmp - 1;			 
			end if;			 
			 
			if ((up = '1' and tmp = "100") or (down = '1' and tmp = "000")) then
				err <= '1';
			else
				err <= '0';			 
			end if;
		end if;
	end process;
Q <= tmp;
full <= tmp(2) and not tmp(1) and not tmp(0);
empty <= not tmp(0) and not tmp(1) and not tmp(2);

end Behavioral;