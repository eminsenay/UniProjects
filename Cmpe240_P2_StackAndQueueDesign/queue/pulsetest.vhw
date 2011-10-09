-- C:\PROGRAMLAR\XILINX\BIN\QUEUE\PULSETEST.VHW
-- VHDL Test Bench created by
-- HDL Bencher 4.1i
-- Sun Jun 05 13:42:09 2005
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
	COMPONENT pulsecatch
		PORT (
			P : in  std_logic;
			R : in  std_logic;
			Z : out  std_logic
		);
	END COMPONENT;

	SIGNAL P : std_logic;
	SIGNAL R : std_logic;
	SIGNAL Z : std_logic;

BEGIN
	UUT : pulsecatch
	PORT MAP (
		P => P,
		R => R,
		Z => Z
	);

	PROCESS
		VARIABLE TX_OUT : LINE;
		VARIABLE TX_ERROR : INTEGER := 0;

		PROCEDURE CHECK_Z(
			next_Z : std_logic;
			TX_TIME : INTEGER
		) IS
			VARIABLE TX_STR : String(1 to 4096);
			VARIABLE TX_LOC : LINE;
		BEGIN
			-- If compiler error ("/=" is ambiguous) occurs in the next line of code
			-- change compiler settings to use explicit declarations only
			IF (Z /= next_Z) THEN 
				write(TX_LOC,string'("Error at time="));
				write(TX_LOC, TX_TIME);
				write(TX_LOC,string'("ns Z="));
				write(TX_LOC, Z);
				write(TX_LOC, string'(", Expected = "));
				write(TX_LOC, next_Z);
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
		P <= transport '0';
		R <= transport '1';
		-- --------------------
		WAIT FOR 100 ns; -- Time=100 ns
		R <= transport '0';
		-- --------------------
		WAIT FOR 100 ns; -- Time=200 ns
		P <= transport '1';
		-- --------------------
		WAIT FOR 100 ns; -- Time=300 ns
		P <= transport '0';
		R <= transport '0';
		-- --------------------
		WAIT FOR 100 ns; -- Time=400 ns
		R <= transport '1';
		-- --------------------
		WAIT FOR 100 ns; -- Time=500 ns
		P <= transport '1';
		R <= transport '1';
		-- --------------------
		WAIT FOR 100 ns; -- Time=600 ns
		R <= transport '0';
		-- --------------------
		WAIT FOR 100 ns; -- Time=700 ns
		P <= transport '0';
		-- --------------------
		WAIT FOR 100 ns; -- Time=800 ns
		P <= transport '1';
		-- --------------------
		WAIT FOR 100 ns; -- Time=900 ns
		R <= transport '1';
		-- --------------------
		WAIT FOR 100 ns; -- Time=1000 ns
		P <= transport '0';
		-- --------------------
		WAIT FOR 100 ns; -- Time=1100 ns
		R <= transport '0';
		-- --------------------
		WAIT FOR 200 ns; -- Time=1300 ns
		P <= transport '1';
		-- --------------------
		WAIT FOR 100 ns; -- Time=1400 ns
		R <= transport '1';
		-- --------------------
		WAIT FOR 100 ns; -- Time=1500 ns
		R <= transport '0';
		-- --------------------
		WAIT FOR 100 ns; -- Time=1600 ns
		P <= transport '0';
		-- --------------------
		WAIT FOR 200 ns; -- Time=1800 ns
		P <= transport '1';
		-- --------------------
		WAIT FOR 100 ns; -- Time=1900 ns
		P <= transport '0';
		-- --------------------
		WAIT FOR 100 ns; -- Time=2000 ns
		P <= transport '1';
		-- --------------------
		WAIT FOR 100 ns; -- Time=2100 ns
		P <= transport '0';
		-- --------------------
		WAIT FOR 100 ns; -- Time=2200 ns
		P <= transport '1';
		-- --------------------
		WAIT FOR 100 ns; -- Time=2300 ns
		P <= transport '0';
		-- --------------------
		WAIT FOR 100 ns; -- Time=2400 ns
		R <= transport '1';
		-- --------------------
		WAIT FOR 200 ns; -- Time=2600 ns
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

CONFIGURATION pulsecatch_cfg OF testbench IS
	FOR testbench_arch
	END FOR;
END pulsecatch_cfg;
