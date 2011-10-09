-- C:\PROGRAMLAR\XILINX\BIN\QUEUE\TWOTOONEMUXTEST.VHW
-- VHDL Test Bench created by
-- HDL Bencher 4.1i
-- Sun Jun 05 13:20:05 2005
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
	COMPONENT twotoonebusmux
		PORT (
			a : in  std_logic_vector (5 DOWNTO 0);
			b : in  std_logic_vector (5 DOWNTO 0);
			sel : in  std_logic;
			o : out  std_logic_vector (5 DOWNTO 0)
		);
	END COMPONENT;

	SIGNAL a : std_logic_vector (5 DOWNTO 0);
	SIGNAL b : std_logic_vector (5 DOWNTO 0);
	SIGNAL sel : std_logic;
	SIGNAL o : std_logic_vector (5 DOWNTO 0);

BEGIN
	UUT : twotoonebusmux
	PORT MAP (
		a => a,
		b => b,
		sel => sel,
		o => o
	);

	PROCESS
		VARIABLE TX_OUT : LINE;
		VARIABLE TX_ERROR : INTEGER := 0;

		PROCEDURE CHECK_o(
			next_o : std_logic_vector (5 DOWNTO 0);
			TX_TIME : INTEGER
		) IS
			VARIABLE TX_STR : String(1 to 4096);
			VARIABLE TX_LOC : LINE;
		BEGIN
			-- If compiler error ("/=" is ambiguous) occurs in the next line of code
			-- change compiler settings to use explicit declarations only
			IF (o /= next_o) THEN 
				write(TX_LOC,string'("Error at time="));
				write(TX_LOC, TX_TIME);
				write(TX_LOC,string'("ns o="));
				write(TX_LOC, o);
				write(TX_LOC, string'(", Expected = "));
				write(TX_LOC, next_o);
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
		a <= transport std_logic_vector'("000000"); --0
		b <= transport std_logic_vector'("010000"); --10
		sel <= transport '0';
		-- --------------------
		WAIT FOR 100 ns; -- Time=100 ns
		a <= transport std_logic_vector'("000001"); --1
		b <= transport std_logic_vector'("001111"); --F
		sel <= transport '1';
		-- --------------------
		WAIT FOR 100 ns; -- Time=200 ns
		a <= transport std_logic_vector'("000010"); --2
		b <= transport std_logic_vector'("001110"); --E
		sel <= transport '0';
		-- --------------------
		WAIT FOR 100 ns; -- Time=300 ns
		a <= transport std_logic_vector'("000011"); --3
		b <= transport std_logic_vector'("001101"); --D
		sel <= transport '1';
		-- --------------------
		WAIT FOR 100 ns; -- Time=400 ns
		a <= transport std_logic_vector'("000100"); --4
		b <= transport std_logic_vector'("001100"); --C
		sel <= transport '0';
		-- --------------------
		WAIT FOR 100 ns; -- Time=500 ns
		a <= transport std_logic_vector'("000101"); --5
		b <= transport std_logic_vector'("001011"); --B
		sel <= transport '1';
		-- --------------------
		WAIT FOR 100 ns; -- Time=600 ns
		a <= transport std_logic_vector'("000110"); --6
		b <= transport std_logic_vector'("001010"); --A
		sel <= transport '0';
		-- --------------------
		WAIT FOR 100 ns; -- Time=700 ns
		a <= transport std_logic_vector'("000111"); --7
		sel <= transport '1';
		-- --------------------
		WAIT FOR 100 ns; -- Time=800 ns
		a <= transport std_logic_vector'("001000"); --8
		b <= transport std_logic_vector'("001001"); --9
		-- --------------------
		WAIT FOR 100 ns; -- Time=900 ns
		a <= transport std_logic_vector'("001001"); --9
		b <= transport std_logic_vector'("001000"); --8
		-- --------------------
		WAIT FOR 100 ns; -- Time=1000 ns
		a <= transport std_logic_vector'("001010"); --A
		b <= transport std_logic_vector'("000111"); --7
		-- --------------------
		WAIT FOR 100 ns; -- Time=1100 ns
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

CONFIGURATION twotoonebusmux_cfg OF testbench IS
	FOR testbench_arch
	END FOR;
END twotoonebusmux_cfg;
