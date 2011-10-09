-- C:\PROGRAMLAR\XILINX\BIN\QUEUE\NEWCOUNTERTEST.VHW
-- VHDL Test Bench created by
-- HDL Bencher 4.1i
-- Sun Jun 05 13:21:48 2005
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
	COMPONENT threebitupdowncounter
		PORT (
			clk : in  std_logic;
			CLR : in  std_logic;
			up : in  std_logic;
			down : in  std_logic;
			Q : out  std_logic_vector (2 DOWNTO 0);
			err : out  std_logic;
			full : out  std_logic;
			empty : out  std_logic
		);
	END COMPONENT;

	SIGNAL clk : std_logic;
	SIGNAL CLR : std_logic;
	SIGNAL up : std_logic;
	SIGNAL down : std_logic;
	SIGNAL Q : std_logic_vector (2 DOWNTO 0);
	SIGNAL err : std_logic;
	SIGNAL full : std_logic;
	SIGNAL empty : std_logic;

BEGIN
	UUT : threebitupdowncounter
	PORT MAP (
		clk => clk,
		CLR => CLR,
		up => up,
		down => down,
		Q => Q,
		err => err,
		full => full,
		empty => empty
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
			next_Q : std_logic_vector (2 DOWNTO 0);
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

		PROCEDURE CHECK_err(
			next_err : std_logic;
			TX_TIME : INTEGER
		) IS
			VARIABLE TX_STR : String(1 to 4096);
			VARIABLE TX_LOC : LINE;
		BEGIN
			-- If compiler error ("/=" is ambiguous) occurs in the next line of code
			-- change compiler settings to use explicit declarations only
			IF (err /= next_err) THEN 
				write(TX_LOC,string'("Error at time="));
				write(TX_LOC, TX_TIME);
				write(TX_LOC,string'("ns err="));
				write(TX_LOC, err);
				write(TX_LOC, string'(", Expected = "));
				write(TX_LOC, next_err);
				write(TX_LOC, string'(" "));
				TX_STR(TX_LOC.all'range) := TX_LOC.all;
				writeline(results, TX_LOC);
				Deallocate(TX_LOC);
				ASSERT (FALSE) REPORT TX_STR SEVERITY ERROR;
				TX_ERROR := TX_ERROR + 1;
			END IF;
		END;

		PROCEDURE CHECK_full(
			next_full : std_logic;
			TX_TIME : INTEGER
		) IS
			VARIABLE TX_STR : String(1 to 4096);
			VARIABLE TX_LOC : LINE;
		BEGIN
			-- If compiler error ("/=" is ambiguous) occurs in the next line of code
			-- change compiler settings to use explicit declarations only
			IF (full /= next_full) THEN 
				write(TX_LOC,string'("Error at time="));
				write(TX_LOC, TX_TIME);
				write(TX_LOC,string'("ns full="));
				write(TX_LOC, full);
				write(TX_LOC, string'(", Expected = "));
				write(TX_LOC, next_full);
				write(TX_LOC, string'(" "));
				TX_STR(TX_LOC.all'range) := TX_LOC.all;
				writeline(results, TX_LOC);
				Deallocate(TX_LOC);
				ASSERT (FALSE) REPORT TX_STR SEVERITY ERROR;
				TX_ERROR := TX_ERROR + 1;
			END IF;
		END;

		PROCEDURE CHECK_empty(
			next_empty : std_logic;
			TX_TIME : INTEGER
		) IS
			VARIABLE TX_STR : String(1 to 4096);
			VARIABLE TX_LOC : LINE;
		BEGIN
			-- If compiler error ("/=" is ambiguous) occurs in the next line of code
			-- change compiler settings to use explicit declarations only
			IF (empty /= next_empty) THEN 
				write(TX_LOC,string'("Error at time="));
				write(TX_LOC, TX_TIME);
				write(TX_LOC,string'("ns empty="));
				write(TX_LOC, empty);
				write(TX_LOC, string'(", Expected = "));
				write(TX_LOC, next_empty);
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
		CLR <= transport '1';
		up <= transport '0';
		down <= transport '0';
		-- --------------------
		WAIT FOR 100 ns; -- Time=100 ns
		CLR <= transport '0';
		-- --------------------
		WAIT FOR 100 ns; -- Time=200 ns
		up <= transport '1';
		-- --------------------
		WAIT FOR 400 ns; -- Time=600 ns
		up <= transport '0';
		-- --------------------
		WAIT FOR 100 ns; -- Time=700 ns
		down <= transport '1';
		-- --------------------
		WAIT FOR 400 ns; -- Time=1100 ns
		up <= transport '1';
		-- --------------------
		WAIT FOR 100 ns; -- Time=1200 ns
		down <= transport '0';
		-- --------------------
		WAIT FOR 310 ns; -- Time=1510 ns
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

CONFIGURATION threebitupdowncounter_cfg OF testbench IS
	FOR testbench_arch
	END FOR;
END threebitupdowncounter_cfg;
