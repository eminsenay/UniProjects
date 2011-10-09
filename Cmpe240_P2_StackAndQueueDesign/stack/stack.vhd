library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
library Unisim;
use Unisim.VComponents.All;

entity stack is
    Port (
    	Push, Pop : in std_logic;
	 	pulse, rst: in std_logic;
		reset: in std_logic;
	 	inp: in std_logic_vector (5 downto 0);
	 	output: out std_logic_vector (5 downto 0);
	 	fll, emp: out std_logic
	 	);	 	
end stack;

architecture Behavioral of stack is

component twotoonebusmux Port (
	a,b: in std_logic_vector (5 downto 0);
	sel: in std_logic;
	o: inout std_logic_vector (5 downto 0));
end component;

component threebitupdowncounter Port(
	clk, CLR, up, down : in std_logic;
    Q : out std_logic_vector(2 downto 0);
	err,full,empty: out std_logic);
end component;

component eighttoonebusmux Port (
	a,b,c,d,e,f,g,h: in std_logic_vector (5 downto 0);
	enable : in std_logic;
	S2,S1,S0: in std_logic;
	o: out std_logic_vector (5 downto 0));
end component;

component BusDFlipFlop Port(
	 D : in std_logic_vector (5 downto 0);
	 res, clk : in std_logic;
	 Q: out std_logic_vector (5 downto 0));
end component;

component pulsecatch Port (
	P : in std_logic;
	R : in std_logic;
	Z : out std_logic);
end component;

signal d0in,d1in,d2in,d3in: std_logic_vector (5 downto 0);
signal inpbuf,otpt,d0out,d1out,d2out,d3out: std_logic_vector (5 downto 0);
signal l0,l1,k1,error: std_logic;
signal counterout: std_logic_vector (2 downto 0);
signal clock,ena,fl,resetbuf,rstbuf,pulsebuf,Pushbuf,Popbuf: std_logic;

begin
u0: ibuf port map (i => inp(0),o => inpbuf(0));
u1: ibuf port map (i => inp(1),o => inpbuf(1));  
u2: ibuf port map (i => inp(2),o => inpbuf(2));  
u3: ibuf port map (i => inp(3),o => inpbuf(3));  
u4: ibuf port map (i => inp(4),o => inpbuf(4));    
u5: ibuf port map (i => inp(5),o => inpbuf(5));
u6: ibuf port map (i => pulse, o => pulsebuf);
u7: ibuf port map (i => rst, o => rstbuf);
u8: ibuf port map (i => reset, o => resetbuf); 
u9: ibuf port map (i => Push, o => Pushbuf); 
u10: ibuf port map (i => Pop, o => Popbuf); 

u11: pulsecatch Port map (P => pulsebuf, R => rstbuf, Z => clock);

u12: threebitupdowncounter Port map
	(clk => clock, CLR => resetbuf, up => Pushbuf, down => Popbuf, Q => counterout, err => error, full => fl, empty => emp);

l0 <= counterout(2) and Pushbuf;
l1 <= counterout(2) and not Popbuf;
ena  <= l0 or l1;

u13: eighttoonebusmux Port map
	(a => d0out, b => d1out, c => inpbuf, d => d0out ,e => d0out ,f => d0out ,g => d0out ,h => d0out,
	enable => '1', S2  => ena, S1 => Pushbuf, S0 => Popbuf, o => d0in);
u14: BusDFlipFlop Port map (D => d0in, res => resetbuf, clk => clock, Q => d0out);
u15: eighttoonebusmux Port map
	(a => d1out, b => d2out, c => d0out, d => d1out ,e => d1out ,f => d1out ,g => d1out ,h => d1out,
	enable => '1', S2  => ena, S1 => Pushbuf, S0 => Popbuf, o => d1in);
u16: BusDFlipFlop Port map (D => d1in, res => resetbuf, clk => clock, Q => d1out);
u17: eighttoonebusmux Port map
	(a => d2out, b => d3out, c => d1out, d => d2out ,e => d2out ,f => d2out ,g => d2out ,h => d2out,
	enable => '1', S2  => ena, S1 => Pushbuf, S0 => Popbuf, o => d2in);
u18: BusDFlipFlop Port map (D => d2in, res => resetbuf, clk => clock, Q => d2out);
u19: eighttoonebusmux Port map
	(a => d3out, b => d0out, c => d2out, d => d3out ,e => d3out ,f => d3out ,g => d3out ,h => d3out,
	enable => '1', S2  => ena, S1 => Pushbuf, S0 => Popbuf, o => d3in);
u20: BusDFlipFlop Port map (D => d3in, res => resetbuf, clk => clock, Q => d3out);
k1 <= Popbuf and not Pushbuf and not error;
u21: twotoonebusmux Port map (a => "000000", b => d3out, sel => k1, o => otpt);
output <= otpt;
fll <= fl;

end Behavioral;
