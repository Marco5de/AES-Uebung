LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY a2 IS
	PORT (
		SW : IN std_logic_vector(17 DOWNTO 0);
		LEDR : OUT std_logic_vector(17 DOWNTO 0)
		);
END a2 ;

ARCHITECTURE BEHAVIOUR OF a2 IS
	signal s : std_logic_vector(2 downto 0);
	signal in1 : std_logic_vector(4 downto 0);
	signal ret : std_logic;
BEGIN
	s <= SW(17 downto 15);
	in1 <= SW(4 downto 0);
	LEDR(0) <= ret;
	
	with s select ret <= in1(0) when "000",
								in1(1) when "001",
								in1(2) when "010",
								in1(3) when "011",
								in1(4) when "100",
								'0' when others;
END BEHAVIOUR ;