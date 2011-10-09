-- C:\PROGRAMLAR\XILINX\BIN\QUEUE\DFLIPFLOPTEST.VHW
-- VHDL Test Bench created by
-- HDL Bencher 4.1i
-- Sun Jun 05 13:15:36 2005
-- 
-- Notes:
-- 1) This testbench has been automatically generated from
--   your Test Bench Waveform
-- 2) To use this as a user modifiable testbench do the following:
--   - Save it as a file with a .vhd extension (i.e. File->Save As...)
--   - Add it to your project as a testbench source (i.e. Project->Add Source...)
-- 

LIBRARY  IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

LIBRARY ieee;
USE IEEE.STD_LOGIC_TEXTIO.ALL;
USE STD.TEXTIO.ALL;

ENTITY testbench IS
END testbench;

ARCHITECTURE testbench_arch OF testbench IS
-- If you get a compiler error on the following line,
-- from the menu do Options->Configuration select VHDL 87
FILE RESULTS: TEXT OPEN WRITE_MODE IS "results.txt";
	COMPONENT BusDFlipFlop
		PORT (
			D : in  std_logic_vector (5 DOWNTO 0);
			res : in  std_logic;
			clk : in  std_logic;
			Q : out  std_logic_vector (5 DOWNTO 0)
		);
	END COMPONENT;

	SIGNAL D : std_logic_vector (5 DOWNTO 0);
	SIGNAL res : std_logic;
	SIGNAL clk : std_logic;
	SIGNAL Q : std_logic_vector (5 DOWNTO 0);

BEGIN
	UUT : BusDFlipFlop
	PORT MAP (
		D => D,
		res => res,
		clk => clk,
		Q => Q
	);

	PROCESS -- clock process
	BEGIN
		CLOCK_LOOP : LOOP
		clk <= transport '0';
		WAIT FOR 10 ns;
		clk <= transport '1';
		WAIT FOR 10 ns;
		WAIT FOR 40 ns;
		clk <= transport '0';
		WAIT FOR 40 ns;
		END LOOP CLOCK_LOOP;
	END PROCESS;

	PROCESS
		VARIABLE TX_OUT : LINE;
		VARIABLE TX_ERROR : INTEGER := 0;

		PROCEDURE CHECK_Q(
			next_Q : std_logic_vector (5 DOWNTO 0);
			TX_TIME : INTEGER
		) IS
			VARIABLE TX_STR : String(1 to 4096);
			VARIABLE TX_LOC : LINE;
		BEGIN
			-- If compiler error ("/=" is ambiguous) occurs in the next line of code
			-- change compiler settings to use explicit declarations only
			IF (Q /= next_Q) THEN 
				write(TX_LOC,string'("Error at time="));
				write(TX_LOC, TX_TIME);
				write(TX_LOC,string'("ns Q="));
				write(TX_LOC, Q);
				write(TX_LOC, string'(", Expected = "));
				write(TX_LOC, next_Q);
				write(TX_LOC, string'(" "));
				TX_STR(TX_LOC.all'range) := TX_LOC.all;
				writeline(results, TX_LOC);
				Deallocate(TX_LOC);
				ASSERT (FALSE) REPORT TX_STR SEVERITY ERROR;
				TX_ERROR := TX_ERROR + 1;
			END IF;
		END;

		BEGIN
		-- --------------------
		D <= transport std_logic_vector'("000001"); --1
		res <= transport '1';
		-- --------------------
		WAIT FOR 100 ns; -- Time=100 ns
		res <= transport '0';
		-- --------------------
		WAIT FOR 100 ns; -- Time=200 ns
		D <= transport std_logic_vector'("000000"); --0
		-- --------------------
		WAIT FOR 200 ns; -- Time=400 ns
		D <= transport std_logic_vector'("000011"); --3
		-- --------------------
		WAIT FOR 100 ns; -- Time=500 ns
		D <= transport std_logic_vector'("000100"); --4
		-- --------------------
		WAIT FOR 20 ns; -- Time=520 ns
		CHECK_Q("000000",520); --0
		-- --------------------
		WAIT FOR 80 ns; -- Time=600 ns
		D <= transport std_logic_vector'("000101"); --5
		-- --------------------
		WAIT FOR 100 ns; -- Time=700 ns
		D <= transport std_logic_vector'("000110"); --6
		-- --------------------
		WAIT FOR 100 ns; -- Time=800 ns
		D <= transport std_logic_vector'("000111"); --7
		-- --------------------
		WAIT FOR 100 ns; -- Time=900 ns
		D <= transport std_logic_vector'("001000"); --8
		-- --------------------
		WAIT FOR 60 ns; -- Time=960 ns
		-- --------------------

		IF (TX_ERROR = 0) THEN 
			write(TX_OUT,string'("No errors or warnings"));
			writeline(results, TX_OUT);
			ASSERT (FALSE) REPORT
				"Simulation successful (not a failure).  No problems detected. "
				SEVERITY FAILURE;
		ELSE
			write(TX_OUT, TX_ERROR);
			write(TX_OUT, string'(
				" errors found in simulation"));
			writeline(results, TX_OUT);
			ASSERT (FALSE) REPORT
				"Errors found during simulation"
				SEVERITY FAILURE;
		END IF;
	END PROCESS;
END testbench_arch;

CONFIGURATION BusDFlipFlop_cfg OF testbench IS
	FOR testbench_arch
	END FOR;
END BusDFlipFlop_cfg;
