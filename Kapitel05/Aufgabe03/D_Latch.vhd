LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity D_Latch is 
	port ( 
		D : in std_logic;
		clk : in std_logic;
		Q : out std_logic
	);
end D_Latch;


architecture behaviour of D_Latch is
	signal R_g, S_g, Qa, Qb : std_logic;
	attribute KEEP : boolean;
	attribute KEEP of R_g, S_g, Qa, Qb : signal is TRUE;
begin 
	S_g <= D nand Clk;
	R_g <= not D nand Clk;
	
	Qa <= S_g nand Qb;
	Qb <= R_g nand Qa;
	
	Q <= Qa;
end behaviour;