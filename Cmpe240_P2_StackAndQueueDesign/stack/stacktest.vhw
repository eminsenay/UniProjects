-- C:\PROGRAMLAR\XILINX\BIN\STACK\STACKTEST.VHW
-- VHDL Test Bench created by
-- HDL Bencher 4.1i
-- Sun Jun 05 18:46:33 2005
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
	COMPONENT stack
		PORT (
			Push : in  std_logic;
			Pop : in  std_logic;
			clock : in  std_logic;
			reset : in  std_logic;
			inp : in  std_logic_vector (5 DOWNTO 0);
			output : out  std_logic_vector (5 DOWNTO 0);
			er : out  std_logic;
			fll : out  std_logic;
			emp : out  std_logic;
			i0 : out  std_logic_vector (5 DOWNTO 0);
			i1 : out  std_logic_vector (5 DOWNTO 0);
			i2 : out  std_logic_vector (5 DOWNTO 0);
			i3 : out  std_logic_vector (5 DOWNTO 0);
			o0 : out  std_logic_vector (5 DOWNTO 0);
			o1 : out  std_logic_vector (5 DOWNTO 0);
			o2 : out  std_logic_vector (5 DOWNTO 0);
			o3 : out  std_logic_vector (5 DOWNTO 0)
		);
	END COMPONENT;

	SIGNAL Push : std_logic;
	SIGNAL Pop : std_logic;
	SIGNAL clock : std_logic;
	SIGNAL reset : std_logic;
	SIGNAL inp : std_logic_vector (5 DOWNTO 0);
	SIGNAL output : std_logic_vector (5 DOWNTO 0);
	SIGNAL er : std_logic;
	SIGNAL fll : std_logic;
	SIGNAL emp : std_logic;
	SIGNAL i0 : std_logic_vector (5 DOWNTO 0);
	SIGNAL i1 : std_logic_vector (5 DOWNTO 0);
	SIGNAL i2 : std_logic_vector (5 DOWNTO 0);
	SIGNAL i3 : std_logic_vector (5 DOWNTO 0);
	SIGNAL o0 : std_logic_vector (5 DOWNTO 0);
	SIGNAL o1 : std_logic_vector (5 DOWNTO 0);
	SIGNAL o2 : std_logic_vector (5 DOWNTO 0);
	SIGNAL o3 : std_logic_vector (5 DOWNTO 0);

BEGIN
	UUT : stack
	PORT MAP (
		Push => Push,
		Pop => Pop,
		clock => clock,
		reset => reset,
		inp => inp,
		output => output,
		er => er,
		fll => fll,
		emp => emp,
		i0 => i0,
		i1 => i1,
		i2 => i2,
		i3 => i3,
		o0 => o0,
		o1 => o1,
		o2 => o2,
		o3 => o3
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

		PROCEDURE CHECK_i0(
			next_i0 : std_logic_vector (5 DOWNTO 0);
			TX_TIME : INTEGER
		) IS
			VARIABLE TX_STR : String(1 to 4096);
			VARIABLE TX_LOC : LINE;
		BEGIN
			-- If compiler error ("/=" is ambiguous) occurs in the next line of code
			-- change compiler settings to use explicit declarations only
			IF (i0 /= next_i0) THEN 
				write(TX_LOC,string'("Error at time="));
				write(TX_LOC, TX_TIME);
				write(TX_LOC,string'("ns i0="));
				write(TX_LOC, i0);
				write(TX_LOC, string'(", Expected = "));
				write(TX_LOC, next_i0);
				write(TX_LOC, string'(" "));
				TX_STR(TX_LOC.all'range) := TX_LOC.all;
				writeline(results, TX_LOC);
				Deallocate(TX_LOC);
				ASSERT (FALSE) REPORT TX_STR SEVERITY ERROR;
				TX_ERROR := TX_ERROR + 1;
			END IF;
		END;

		PROCEDURE CHECK_o0(
			next_o0 : std_logic_vector (5 DOWNTO 0);
			TX_TIME : INTEGER
		) IS
			VARIABLE TX_STR : String(1 to 4096);
			VARIABLE TX_LOC : LINE;
		BEGIN
			-- If compiler error ("/=" is ambiguous) occurs in the next line of code
			-- change compiler settings to use explicit declarations only
			IF (o0 /= next_o0) THEN 
				write(TX_LOC,string'("Error at time="));
				write(TX_LOC, TX_TIME);
				write(TX_LOC,string'("ns o0="));
				write(TX_LOC, o0);
				write(TX_LOC, string'(", Expected = "));
				write(TX_LOC, next_o0);
				write(TX_LOC, string'(" "));
				TX_STR(TX_LOC.all'range) := TX_LOC.all;
				writeline(results, TX_LOC);
				Deallocate(TX_LOC);
				ASSERT (FALSE) REPORT TX_STR SEVERITY ERROR;
				TX_ERROR := TX_ERROR + 1;
			END IF;
		END;

		PROCEDURE CHECK_i1(
			next_i1 : std_logic_vector (5 DOWNTO 0);
			TX_TIME : INTEGER
		) IS
			VARIABLE TX_STR : String(1 to 4096);
			VARIABLE TX_LOC : LINE;
		BEGIN
			-- If compiler error ("/=" is ambiguous) occurs in the next line of code
			-- change compiler settings to use explicit declarations only
			IF (i1 /= next_i1) THEN 
				write(TX_LOC,string'("Error at time="));
				write(TX_LOC, TX_TIME);
				write(TX_LOC,string'("ns i1="));
				write(TX_LOC, i1);
				write(TX_LOC, string'(", Expected = "));
				write(TX_LOC, next_i1);
				write(TX_LOC, string'(" "));
				TX_STR(TX_LOC.all'range) := TX_LOC.all;
				writeline(results, TX_LOC);
				Deallocate(TX_LOC);
				ASSERT (FALSE) REPORT TX_STR SEVERITY ERROR;
				TX_ERROR := TX_ERROR + 1;
			END IF;
		END;

		PROCEDURE CHECK_o1(
			next_o1 : std_logic_vector (5 DOWNTO 0);
			TX_TIME : INTEGER
		) IS
			VARIABLE TX_STR : String(1 to 4096);
			VARIABLE TX_LOC : LINE;
		BEGIN
			-- If compiler error ("/=" is ambiguous) occurs in the next line of code
			-- change compiler settings to use explicit declarations only
			IF (o1 /= next_o1) THEN 
				write(TX_LOC,string'("Error at time="));
				write(TX_LOC, TX_TIME);
				write(TX_LOC,string'("ns o1="));
				write(TX_LOC, o1);
				write(TX_LOC, string'(", Expected = "));
				write(TX_LOC, next_o1);
				write(TX_LOC, string'(" "));
				TX_STR(TX_LOC.all'range) := TX_LOC.all;
				writeline(results, TX_LOC);
				Deallocate(TX_LOC);
				ASSERT (FALSE) REPORT TX_STR SEVERITY ERROR;
				TX_ERROR := TX_ERROR + 1;
			END IF;
		END;

		PROCEDURE CHECK_i2(
			next_i2 : std_logic_vector (5 DOWNTO 0);
			TX_TIME : INTEGER
		) IS
			VARIABLE TX_STR : String(1 to 4096);
			VARIABLE TX_LOC : LINE;
		BEGIN
			-- If compiler error ("/=" is ambiguous) occurs in the next line of code
			-- change compiler settings to use explicit declarations only
			IF (i2 /= next_i2) THEN 
				write(TX_LOC,string'("Error at time="));
				write(TX_LOC, TX_TIME);
				write(TX_LOC,string'("ns i2="));
				write(TX_LOC, i2);
				write(TX_LOC, string'(", Expected = "));
				write(TX_LOC, next_i2);
				write(TX_LOC, string'(" "));
				TX_STR(TX_LOC.all'range) := TX_LOC.all;
				writeline(results, TX_LOC);
				Deallocate(TX_LOC);
				ASSERT (FALSE) REPORT TX_STR SEVERITY ERROR;
				TX_ERROR := TX_ERROR + 1;
			END IF;
		END;

		PROCEDURE CHECK_o2(
			next_o2 : std_logic_vector (5 DOWNTO 0);
			TX_TIME : INTEGER
		) IS
			VARIABLE TX_STR : String(1 to 4096);
			VARIABLE TX_LOC : LINE;
		BEGIN
			-- If compiler error ("/=" is ambiguous) occurs in the next line of code
			-- change compiler settings to use explicit declarations only
			IF (o2 /= next_o2) THEN 
				write(TX_LOC,string'("Error at time="));
				write(TX_LOC, TX_TIME);
				write(TX_LOC,string'("ns o2="));
				write(TX_LOC, o2);
				write(TX_LOC, string'(", Expected = "));
				write(TX_LOC, next_o2);
				write(TX_LOC, string'(" "));
				TX_STR(TX_LOC.all'range) := TX_LOC.all;
				writeline(results, TX_LOC);
				Deallocate(TX_LOC);
				ASSERT (FALSE) REPORT TX_STR SEVERITY ERROR;
				TX_ERROR := TX_ERROR + 1;
			END IF;
		END;

		PROCEDURE CHECK_i3(
			next_i3 : std_logic_vector (5 DOWNTO 0);
			TX_TIME : INTEGER
		) IS
			VARIABLE TX_STR : String(1 to 4096);
			VARIABLE TX_LOC : LINE;
		BEGIN
			-- If compiler error ("/=" is ambiguous) occurs in the next line of code
			-- change compiler settings to use explicit declarations only
			IF (i3 /= next_i3) THEN 
				write(TX_LOC,string'("Error at time="));
				write(TX_LOC, TX_TIME);
				write(TX_LOC,string'("ns i3="));
				write(TX_LOC, i3);
				write(TX_LOC, string'(", Expected = "));
				write(TX_LOC, next_i3);
				write(TX_LOC, string'(" "));
				TX_STR(TX_LOC.all'range) := TX_LOC.all;
				writeline(results, TX_LOC);
				Deallocate(TX_LOC);
				ASSERT (FALSE) REPORT TX_STR SEVERITY ERROR;
				TX_ERROR := TX_ERROR + 1;
			END IF;
		END;

		PROCEDURE CHECK_o3(
			next_o3 : std_logic_vector (5 DOWNTO 0);
			TX_TIME : INTEGER
		) IS
			VARIABLE TX_STR : String(1 to 4096);
			VARIABLE TX_LOC : LINE;
		BEGIN
			-- If compiler error ("/=" is ambiguous) occurs in the next line of code
			-- change compiler settings to use explicit declarations only
			IF (o3 /= next_o3) THEN 
				write(TX_LOC,string'("Error at time="));
				write(TX_LOC, TX_TIME);
				write(TX_LOC,string'("ns o3="));
				write(TX_LOC, o3);
				write(TX_LOC, string'(", Expected = "));
				write(TX_LOC, next_o3);
				write(TX_LOC, string'(" "));
				TX_STR(TX_LOC.all'range) := TX_LOC.all;
				writeline(results, TX_LOC);
				Deallocate(TX_LOC);
				ASSERT (FALSE) REPORT TX_STR SEVERITY ERROR;
				TX_ERROR := TX_ERROR + 1;
			END IF;
		END;

		PROCEDURE CHECK_er(
			next_er : std_logic;
			TX_TIME : INTEGER
		) IS
			VARIABLE TX_STR : String(1 to 4096);
			VARIABLE TX_LOC : LINE;
		BEGIN
			-- If compiler error ("/=" is ambiguous) occurs in the next line of code
			-- change compiler settings to use explicit declarations only
			IF (er /= next_er) THEN 
				write(TX_LOC,string'("Error at time="));
				write(TX_LOC, TX_TIME);
				write(TX_LOC,string'("ns er="));
				write(TX_LOC, er);
				write(TX_LOC, string'(", Expected = "));
				write(TX_LOC, next_er);
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
		inp <= transport std_logic_vector'("000001"); --1
		-- --------------------
		WAIT FOR 100 ns; -- Time=200 ns
		Push <= transport '1';
		inp <= transport std_logic_vector'("000010"); --2
		-- --------------------
		WAIT FOR 100 ns; -- Time=300 ns
		inp <= transport std_logic_vector'("000011"); --3
		-- --------------------
		WAIT FOR 100 ns; -- Time=400 ns
		inp <= transport std_logic_vector'("000100"); --4
		-- --------------------
		WAIT FOR 100 ns; -- Time=500 ns
		inp <= transport std_logic_vector'("000101"); --5
		-- --------------------
		WAIT FOR 100 ns; -- Time=600 ns
		inp <= transport std_logic_vector'("000110"); --6
		-- --------------------
		WAIT FOR 100 ns; -- Time=700 ns
		inp <= transport std_logic_vector'("000111"); --7
		-- --------------------
		WAIT FOR 100 ns; -- Time=800 ns
		Push <= transport '0';
		inp <= transport std_logic_vector'("001000"); --8
		-- --------------------
		WAIT FOR 100 ns; -- Time=900 ns
		inp <= transport std_logic_vector'("001001"); --9
		-- --------------------
		WAIT FOR 100 ns; -- Time=1000 ns
		Pop <= transport '1';
		inp <= transport std_logic_vector'("001010"); --A
		-- --------------------
		WAIT FOR 100 ns; -- Time=1100 ns
		inp <= transport std_logic_vector'("001011"); --B
		-- --------------------
		WAIT FOR 100 ns; -- Time=1200 ns
		inp <= transport std_logic_vector'("001100"); --C
		-- --------------------
		WAIT FOR 100 ns; -- Time=1300 ns
		inp <= transport std_logic_vector'("001101"); --D
		-- --------------------
		WAIT FOR 100 ns; -- Time=1400 ns
		inp <= transport std_logic_vector'("001110"); --E
		-- --------------------
		WAIT FOR 100 ns; -- Time=1500 ns
		inp <= transport std_logic_vector'("001111"); --F
		-- --------------------
		WAIT FOR 100 ns; -- Time=1600 ns
		Push <= transport '1';
		Pop <= transport '0';
		inp <= transport std_logic_vector'("010000"); --10
		-- --------------------
		WAIT FOR 100 ns; -- Time=1700 ns
		inp <= transport std_logic_vector'("010001"); --11
		-- --------------------
		WAIT FOR 100 ns; -- Time=1800 ns
		inp <= transport std_logic_vector'("010010"); --12
		-- --------------------
		WAIT FOR 100 ns; -- Time=1900 ns
		Pop <= transport '1';
		inp <= transport std_logic_vector'("010011"); --13
		-- --------------------
		WAIT FOR 100 ns; -- Time=2000 ns
		Push <= transport '0';
		inp <= transport std_logic_vector'("010100"); --14
		-- --------------------
		WAIT FOR 100 ns; -- Time=2100 ns
		inp <= transport std_logic_vector'("010101"); --15
		-- --------------------
		WAIT FOR 100 ns; -- Time=2200 ns
		inp <= transport std_logic_vector'("010110"); --16
		-- --------------------
		WAIT FOR 100 ns; -- Time=2300 ns
		inp <= transport std_logic_vector'("010111"); --17
		-- --------------------
		WAIT FOR 100 ns; -- Time=2400 ns
		inp <= transport std_logic_vector'("011000"); --18
		-- --------------------
		WAIT FOR 100 ns; -- Time=2500 ns
		Push <= transport '1';
		Pop <= transport '0';
		inp <= transport std_logic_vector'("011001"); --19
		-- --------------------
		WAIT FOR 100 ns; -- Time=2600 ns
		Push <= transport '0';
		Pop <= transport '1';
		inp <= transport std_logic_vector'("011010"); --1A
		-- --------------------
		WAIT FOR 100 ns; -- Time=2700 ns
		Pop <= transport '0';
		inp <= transport std_logic_vector'("011011"); --1B
		-- --------------------
		WAIT FOR 60 ns; -- Time=2760 ns
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
