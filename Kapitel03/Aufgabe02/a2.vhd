LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY a2 IS
	PORT (
		SW : IN std_logic_vector(17 DOWNTO 0);
		LEDR : OUT std_logic_vector(17 DOWNTO 0)
		);
END a2 ;

ARCHITECTURE LogicFunction OF a2 IS
BEGIN
	LEDR <= SW;
END LogicFunction ;