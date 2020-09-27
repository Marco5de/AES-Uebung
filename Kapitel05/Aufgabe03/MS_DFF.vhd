LIBRARY ieee;
USE ieee.std_logic_1164.all;


entity MS_DFF is
	port (
		D : in std_logic;
		clk : in std_logic;
		Q : out std_logic
	);
end MS_DFF;

architecture behaviour of MS_DFF is
	signal Qm : std_logic;
	attribute KEEP : boolean;
	attribute KEEP of Qm : signal is TRUE;
begin
	latch1 : entity work.D_Latch(behaviour)
						port map(
							D => D,
							clk => not clk,
							Q => Qm
						);
	
	latch2 : entity work.D_Latch(behaviour)
						port map(
							D => Qm,
							clk => clk,
							Q => Q
						);
end behaviour;