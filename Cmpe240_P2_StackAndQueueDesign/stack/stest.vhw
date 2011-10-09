-- C:\PROGRAMLAR\XILINX\BIN\STACK\STEST.VHW
-- VHDL Test Bench created by
-- HDL Bencher 4.1i
-- Mon Jun 06 01:14:20 2005
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

LIBRARY  Unisim;
USE Unisim.VComponents.All;

LIBRARY ieee;
USE IEEE.STD_LOGIC_TEXTIO.ALL;
USE STD.TEXTIO.ALL;

ENTITY testbench IS
END testbench;

ARCHITECTURE testbench_arch OF testbench IS
-- If you get a compiler error on the following line,
-- from the menu do Options->Configuration select VHDL 87
FILE RESULTS: TEXT OPEN WRITE_MODE IS "results.txt";
	COMPONENT stack
		PORT (
			Push : in  std_logic;
			Pop : in  std_logic;
			pulse : in  std_logic;
			rst : in  std_logic;
			reset : in  std_logic;
			inp : in  std_logic_vector (5 DOWNTO 0);
			output : out  std_logic_vector (5 DOWNTO 0);
			fll : out  std_logic;
			emp : out  std_logic
		);
	END COMPONENT;

	SIGNAL Push : std_logic;
	SIGNAL Pop : std_logic;
	SIGNAL pulse : std_logic;
	SIGNAL rst : std_logic;
	SIGNAL reset : std_logic;
	SIGNAL inp : std_logic_vector (5 DOWNTO 0);
	SIGNAL output : std_logic_vector (5 DOWNTO 0);
	SIGNAL fll : std_logic;
	SIGNAL emp : std_logic;

BEGIN
	UUT : stack
	PORT MAP (
		Push => Push,
		Pop => Pop,
		pulse => pulse,
		rst => rst,
		reset => reset,
		inp => inp,
		output => output,
		fll => fll,
		emp => emp
	);

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
		pulse <= transport '0';
		rst <= transport '0';
		reset <= transport '1';
		inp <= transport std_logic_vector'("000000"); --0
		-- --------------------
		WAIT FOR 100 ns; -- Time=100 ns
		Push <= transport '1';
		rst <= transport '1';
		reset <= transport '0';
		inp <= transport std_logic_vector'("000000"); --0
		-- --------------------
		WAIT FOR 100 ns; -- Time=200 ns
		rst <= transport '0';
		inp <= transport std_logic_vector'("000001"); --1
		-- --------------------
		WAIT FOR 100 ns; -- Time=300 ns
		pulse <= transport '1';
		rst <= transport '0';
		inp <= transport std_logic_vector'("000001"); --1
		-- --------------------
		WAIT FOR 100 ns; -- Time=400 ns
		pulse <= transport '0';
		inp <= transport std_logic_vector'("000001"); --1
		-- --------------------
		WAIT FOR 100 ns; -- Time=500 ns
		rst <= transport '1';
		inp <= transport std_logic_vector'("000010"); --2
		-- --------------------
		WAIT FOR 100 ns; -- Time=600 ns
		rst <= transport '0';
		inp <= transport std_logic_vector'("000010"); --2
		-- --------------------
		WAIT FOR 100 ns; -- Time=700 ns
		pulse <= transport '1';
		inp <= transport std_logic_vector'("000010"); --2
		-- --------------------
		WAIT FOR 100 ns; -- Time=800 ns
		pulse <= transport '0';
		inp <= transport std_logic_vector'("000011"); --3
		-- --------------------
		WAIT FOR 100 ns; -- Time=900 ns
		rst <= transport '1';
		inp <= transport std_logic_vector'("000011"); --3
		-- --------------------
		WAIT FOR 100 ns; -- Time=1000 ns
		rst <= transport '0';
		inp <= transport std_logic_vector'("000011"); --3
		-- --------------------
		WAIT FOR 100 ns; -- Time=1100 ns
		pulse <= transport '1';
		inp <= transport std_logic_vector'("000100"); --4
		-- --------------------
		WAIT FOR 100 ns; -- Time=1200 ns
		pulse <= transport '0';
		inp <= transport std_logic_vector'("000100"); --4
		-- --------------------
		WAIT FOR 100 ns; -- Time=1300 ns
		rst <= transport '1';
		inp <= transport std_logic_vector'("000100"); --4
		-- --------------------
		WAIT FOR 100 ns; -- Time=1400 ns
		Push <= transport '0';
		rst <= transport '0';
		inp <= transport std_logic_vector'("000101"); --5
		-- --------------------
		WAIT FOR 100 ns; -- Time=1500 ns
		Pop <= transport '1';
		pulse <= transport '1';
		inp <= transport std_logic_vector'("000101"); --5
		-- --------------------
		WAIT FOR 100 ns; -- Time=1600 ns
		pulse <= transport '0';
		inp <= transport std_logic_vector'("000101"); --5
		-- --------------------
		WAIT FOR 100 ns; -- Time=1700 ns
		rst <= transport '1';
		inp <= transport std_logic_vector'("000110"); --6
		-- --------------------
		WAIT FOR 100 ns; -- Time=1800 ns
		rst <= transport '0';
		inp <= transport std_logic_vector'("000110"); --6
		-- --------------------
		WAIT FOR 100 ns; -- Time=1900 ns
		Pop <= transport '0';
		pulse <= transport '1';
		inp <= transport std_logic_vector'("000110"); --6
		-- --------------------
		WAIT FOR 100 ns; -- Time=2000 ns
		Push <= transport '1';
		pulse <= transport '0';
		inp <= transport std_logic_vector'("000111"); --7
		-- --------------------
		WAIT FOR 100 ns; -- Time=2100 ns
		Pop <= transport '1';
		rst <= transport '1';
		inp <= transport std_logic_vector'("000111"); --7
		-- --------------------
		WAIT FOR 100 ns; -- Time=2200 ns
		Pop <= transport '0';
		rst <= transport '0';
		inp <= transport std_logic_vector'("000111"); --7
		-- --------------------
		WAIT FOR 100 ns; -- Time=2300 ns
		Push <= transport '0';
		pulse <= transport '1';
		inp <= transport std_logic_vector'("001000"); --8
		-- --------------------
		WAIT FOR 100 ns; -- Time=2400 ns
		pulse <= transport '0';
		inp <= transport std_logic_vector'("001000"); --8
		-- --------------------
		WAIT FOR 100 ns; -- Time=2500 ns
		Pop <= transport '1';
		rst <= transport '1';
		inp <= transport std_logic_vector'("001000"); --8
		-- --------------------
		WAIT FOR 100 ns; -- Time=2600 ns
		rst <= transport '0';
		inp <= transport std_logic_vector'("001001"); --9
		-- --------------------
		WAIT FOR 100 ns; -- Time=2700 ns
		pulse <= transport '1';
		inp <= transport std_logic_vector'("001001"); --9
		-- --------------------
		WAIT FOR 100 ns; -- Time=2800 ns
		Push <= transport '1';
		pulse <= transport '0';
		inp <= transport std_logic_vector'("001001"); --9
		-- --------------------
		WAIT FOR 100 ns; -- Time=2900 ns
		Pop <= transport '0';
		rst <= transport '1';
		-- --------------------
		WAIT FOR 100 ns; -- Time=3000 ns
		rst <= transport '0';
		inp <= transport std_logic_vector'("001010"); --A
		-- --------------------
		WAIT FOR 100 ns; -- Time=3100 ns
		pulse <= transport '1';
		inp <= transport std_logic_vector'("001010"); --A
		-- --------------------
		WAIT FOR 100 ns; -- Time=3200 ns
		pulse <= transport '0';
		inp <= transport std_logic_vector'("001010"); --A
		-- --------------------
		WAIT FOR 100 ns; -- Time=3300 ns
		rst <= transport '1';
		inp <= transport std_logic_vector'("001011"); --B
		-- --------------------
		WAIT FOR 100 ns; -- Time=3400 ns
		rst <= transport '0';
		inp <= transport std_logic_vector'("001011"); --B
		-- --------------------
		WAIT FOR 100 ns; -- Time=3500 ns
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

CONFIGURATION stack_cfg OF testbench IS
	FOR testbench_arch
	END FOR;
END stack_cfg;
