LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY a1_MUX IS
	PORT (
		SW : IN std_logic_vector(17 DOWNTO 0);
		LEDR : OUT std_logic_vector(17 DOWNTO 0)
		);
END a1_MUX ;

ARCHITECTURE BEHAVIOUR OF a1_MUX IS
	signal s : std_logic;
	signal in1 : std_logic_vector(7 downto 0);
	signal in2 : std_logic_vector(7 downto 0);
	signal ret : std_logic_vector(7 downto 0);
BEGIN
	s <= SW(17);
	in1 <= SW(15 downto 8);
	in2 <= SW(7 downto 0);
	LEDR(7 downto 0) <= ret;
	
	ret <= in1 when s = '1' else in2;
	
END BEHAVIOUR ;