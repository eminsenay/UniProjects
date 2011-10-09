-- C:\PROGRAMLAR\XILINX\BIN\QUEUE\QUEUETEST.VHW
-- VHDL Test Bench created by
-- HDL Bencher 4.1i
-- Sun Jun 05 13:24:00 2005
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

LIBRARY  UNISIM;
USE Unisim.Vcomponents.All;

LIBRARY ieee;
USE IEEE.STD_LOGIC_TEXTIO.ALL;
USE STD.TEXTIO.ALL;

ENTITY testbench IS
END testbench;

ARCHITECTURE testbench_arch OF testbench IS
-- If you get a compiler error on the following line,
-- from the menu do Options->Configuration select VHDL 87
FILE RESULTS: TEXT OPEN WRITE_MODE IS "results.txt";
	COMPONENT queue
		PORT (
			Push : in  std_logic;
			Pop : in  std_logic;
			clock : in  std_logic;
			reset : in  std_logic;
			inp : in  std_logic_vector (5 DOWNTO 0);
			output : out  std_logic_vector (5 DOWNTO 0);
			fll : out  std_logic;
			emp : out  std_logic
		);
	END COMPONENT;

	SIGNAL Push : std_logic;
	SIGNAL Pop : std_logic;
	SIGNAL clock : std_logic;
	SIGNAL reset : std_logic;
	SIGNAL inp : std_logic_vector (5 DOWNTO 0);
	SIGNAL output : std_logic_vector (5 DOWNTO 0);
	SIGNAL fll : std_logic;
	SIGNAL emp : std_logic;

BEGIN
	UUT : queue
	PORT MAP (
		Push => Push,
		Pop => Pop,
		clock => clock,
		reset => reset,
		inp => inp,
		output => output,
		fll => fll,
		emp => emp
	);

	PROCESS -- clock process
	BEGIN
		CLOCK_LOOP : LOOP
		clock <= transport '0';
		WAIT FOR 10 ns;
		clock <= transport '1';
		WAIT FOR 10 ns;
		WAIT FOR 40 ns;
		clock <= transport '0';
		WAIT FOR 40 ns;
		END LOOP CLOCK_LOOP;
	END PROCESS;

	PROCESS
		VARIABLE TX_OUT : LINE;
		VARIABLE TX_ERROR : INTEGER := 0;

		PROCEDURE CHECK_output(
			next_output : std_logic_vector (5 DOWNTO 0);
			TX_TIME : INTEGER
		) IS
			VARIABLE TX_STR : String(1 to 4096);
			VARIABLE TX_LOC : LINE;
		BEGIN
			-- If compiler error ("/=" is ambiguous) occurs in the next line of code
			-- change compiler settings to use explicit declarations only
			IF (output /= next_output) THEN 
				write(TX_LOC,string'("Error at time="));
				write(TX_LOC, TX_TIME);
				write(TX_LOC,string'("ns output="));
				write(TX_LOC, output);
				write(TX_LOC, string'(", Expected = "));
				write(TX_LOC, next_output);
				write(TX_LOC, string'(" "));
				TX_STR(TX_LOC.all'range) := TX_LOC.all;
				writeline(results, TX_LOC);
				Deallocate(TX_LOC);
				ASSERT (FALSE) REPORT TX_STR SEVERITY ERROR;
				TX_ERROR := TX_ERROR + 1;
			END IF;
		END;

		PROCEDURE CHECK_fll(
			next_fll : std_logic;
			TX_TIME : INTEGER
		) IS
			VARIABLE TX_STR : String(1 to 4096);
			VARIABLE TX_LOC : LINE;
		BEGIN
			-- If compiler error ("/=" is ambiguous) occurs in the next line of code
			-- change compiler settings to use explicit declarations only
			IF (fll /= next_fll) THEN 
				write(TX_LOC,string'("Error at time="));
				write(TX_LOC, TX_TIME);
				write(TX_LOC,string'("ns fll="));
				write(TX_LOC, fll);
				write(TX_LOC, string'(", Expected = "));
				write(TX_LOC, next_fll);
				write(TX_LOC, string'(" "));
				TX_STR(TX_LOC.all'range) := TX_LOC.all;
				writeline(results, TX_LOC);
				Deallocate(TX_LOC);
				ASSERT (FALSE) REPORT TX_STR SEVERITY ERROR;
				TX_ERROR := TX_ERROR + 1;
			END IF;
		END;

		PROCEDURE CHECK_emp(
			next_emp : std_logic;
			TX_TIME : INTEGER
		) IS
			VARIABLE TX_STR : String(1 to 4096);
			VARIABLE TX_LOC : LINE;
		BEGIN
			-- If compiler error ("/=" is ambiguous) occurs in the next line of code
			-- change compiler settings to use explicit declarations only
			IF (emp /= next_emp) THEN 
				write(TX_LOC,string'("Error at time="));
				write(TX_LOC, TX_TIME);
				write(TX_LOC,string'("ns emp="));
				write(TX_LOC, emp);
				write(TX_LOC, string'(", Expected = "));
				write(TX_LOC, next_emp);
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
		Push <= transport '0';
		Pop <= transport '0';
		reset <= transport '1';
		inp <= transport std_logic_vector'("000000"); --0
		-- --------------------
		WAIT FOR 100 ns; -- Time=100 ns
		reset <= transport '0';
		-- --------------------
		WAIT FOR 100 ns; -- Time=200 ns
		Push <= transport '1';
		inp <= transport std_logic_vector'("000001"); --1
		-- --------------------
		WAIT FOR 100 ns; -- Time=300 ns
		inp <= transport std_logic_vector'("000010"); --2
		-- --------------------
		WAIT FOR 100 ns; -- Time=400 ns
		inp <= transport std_logic_vector'("000011"); --3
		-- --------------------
		WAIT FOR 100 ns; -- Time=500 ns
		inp <= transport std_logic_vector'("000100"); --4
		-- --------------------
		WAIT FOR 100 ns; -- Time=600 ns
		Push <= transport '0';
		inp <= transport std_logic_vector'("000101"); --5
		-- --------------------
		WAIT FOR 100 ns; -- Time=700 ns
		Pop <= transport '1';
		inp <= transport std_logic_vector'("000110"); --6
		-- --------------------
		WAIT FOR 100 ns; -- Time=800 ns
		inp <= transport std_logic_vector'("000111"); --7
		-- --------------------
		WAIT FOR 100 ns; -- Time=900 ns
		inp <= transport std_logic_vector'("001000"); --8
		-- --------------------
		WAIT FOR 100 ns; -- Time=1000 ns
		inp <= transport std_logic_vector'("001001"); --9
		-- --------------------
		WAIT FOR 100 ns; -- Time=1100 ns
		inp <= transport std_logic_vector'("001010"); --A
		-- --------------------
		WAIT FOR 100 ns; -- Time=1200 ns
		inp <= transport std_logic_vector'("001011"); --B
		-- --------------------
		WAIT FOR 100 ns; -- Time=1300 ns
		Push <= transport '1';
		inp <= transport std_logic_vector'("001100"); --C
		-- --------------------
		WAIT FOR 100 ns; -- Time=1400 ns
		Push <= transport '0';
		inp <= transport std_logic_vector'("001101"); --D
		-- --------------------
		WAIT FOR 100 ns; -- Time=1500 ns
		Pop <= transport '1';
		inp <= transport std_logic_vector'("001110"); --E
		-- --------------------
		WAIT FOR 100 ns; -- Time=1600 ns
		inp <= transport std_logic_vector'("001111"); --F
		-- --------------------
		WAIT FOR 100 ns; -- Time=1700 ns
		Push <= transport '1';
		inp <= transport std_logic_vector'("010000"); --10
		-- --------------------
		WAIT FOR 100 ns; -- Time=1800 ns
		inp <= transport std_logic_vector'("010001"); --11
		-- --------------------
		WAIT FOR 100 ns; -- Time=1900 ns
		Pop <= transport '0';
		inp <= transport std_logic_vector'("010010"); --12
		-- --------------------
		WAIT FOR 100 ns; -- Time=2000 ns
		inp <= transport std_logic_vector'("010011"); --13
		-- --------------------
		WAIT FOR 100 ns; -- Time=2100 ns
		inp <= transport std_logic_vector'("010100"); --14
		-- --------------------
		WAIT FOR 100 ns; -- Time=2200 ns
		Pop <= transport '1';
		inp <= transport std_logic_vector'("010101"); --15
		-- --------------------
		WAIT FOR 100 ns; -- Time=2300 ns
		Push <= transport '0';
		inp <= transport std_logic_vector'("010110"); --16
		-- --------------------
		WAIT FOR 100 ns; -- Time=2400 ns
		inp <= transport std_logic_vector'("010111"); --17
		-- --------------------
		WAIT FOR 100 ns; -- Time=2500 ns
		Pop <= transport '0';
		inp <= transport std_logic_vector'("011000"); --18
		-- --------------------
		WAIT FOR 100 ns; -- Time=2600 ns
		Push <= transport '1';
		inp <= transport std_logic_vector'("011001"); --19
		-- --------------------
		WAIT FOR 100 ns; -- Time=2700 ns
		inp <= transport std_logic_vector'("011010"); --1A
		-- --------------------
		WAIT FOR 100 ns; -- Time=2800 ns
		inp <= transport std_logic_vector'("011011"); --1B
		-- --------------------
		WAIT FOR 60 ns; -- Time=2860 ns
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

CONFIGURATION queue_cfg OF testbench IS
	FOR testbench_arch
	END FOR;
END queue_cfg;
