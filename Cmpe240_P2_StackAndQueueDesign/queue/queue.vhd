library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
library UNISIM;
use Unisim.Vcomponents.All;

entity queue is
    Port (
    	Push, Pop : in std_logic;
	 	pulse, rst: in std_logic;
		reset: in std_logic;
	 	inp: in std_logic_vector (5 downto 0);
	 	output: out std_logic_vector (5 downto 0);
	 	fll, emp: out std_logic );	 	
end queue;

architecture Behavioral of queue is

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

component twobitbusdflipflop Port (
	 D : in std_logic_vector (2 downto 0);
	 res, clk : in std_logic;
	 Q: out std_logic_vector (2 downto 0));
end component;

component pulsecatch Port (
	P : in std_logic;
	R : in std_logic;
	Z : out std_logic);
end component;

signal d0in,d1in,d2in,d3in: std_logic_vector (5 downto 0);
signal inpbuf,d0out,d1out,d2out,d3out: std_logic_vector (5 downto 0);
signal k1,k2,error: std_logic;
signal counterout,counterout2: std_logic_vector (2 downto 0);
signal rstbuf,resetbuf,Pushbuf,Popbuf,pulsebuf,clock,cout1, cout0,cout2,fl: std_logic;
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
k1 <= Pushbuf and not fl and not Popbuf;

u13: twotoonebusmux Port map (a => d0out, b => inpbuf, sel => k1, o => d0in);
u14: BusDFlipFlop Port map (D => d0in, res => resetbuf, clk => clock, Q => d0out);
u15: twotoonebusmux Port map (a => d1out, b => d0out, sel => k1, o => d1in);
u16: BusDFlipFlop Port map (D => d1in, res => resetbuf, clk => clock, Q => d1out);
u17: twotoonebusmux Port map (a => d2out, b => d1out, sel => k1, o => d2in);
u18: BusDFlipFlop Port map (D => d2in, res => resetbuf, clk => clock, Q => d2out);
u19: twotoonebusmux Port map (a => d3out, b => d2out, sel => k1, o => d3in);
u20: BusDFlipFlop Port map (D => d3in, res => resetbuf, clk => clock, Q => d3out);

k2 <= Popbuf and not error and not Pushbuf;

cout2 <= counterout(2);
cout1 <= counterout(1);
cout0 <= counterout(0);
u21: eighttoonebusmux Port map
	( a => d0out, b => d1out, c => d2out, d => d3out, e=>"000000" , f=>"000000", g=>"000000", h=>"000000",
	 enable => k2, S2=>cout2, S1 => cout1, S0 => cout0, o => output);

fll <= fl;
end Behavioral;