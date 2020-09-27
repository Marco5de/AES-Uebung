-- A gated RS latch desribed the hard way
LIBRARY ieee;
USE ieee.std_logic_1164.all;
ENTITY a2 is
	PORT ( 	
				SW : IN std_logic_vector(17 downto 0);
				LEDR : out std_logic_vector(17 downto 0)
			);
END a2;


ARCHITECTURE Structural OF a2 IS
	SIGNAL R_g, S_g, Qa, Qb, D, Q, Clk : STD_LOGIC ;
	ATTRIBUTE KEEP : BOOLEAN;
	ATTRIBUTE KEEP OF R_g, S_g, Qa, Qb : SIGNAL IS TRUE;
BEGIN
	D <= SW(0);
	Clk <= SW(1);
	LEDR(0) <= Q;
	
	S_g <= D nand Clk;
	R_g <= not D nand Clk;
	
	Qa <= S_g nand Qb;
	Qb <= R_g nand Qa;
	
	Q <= Qa;
END Structural;
