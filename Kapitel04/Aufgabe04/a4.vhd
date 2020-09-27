LIBRARY ieee;
USE ieee.std_logic_1164.ALL;


entity a4 is
	port (
		SW : in std_logic_vector(17 downto 0);
		LEDR : out std_logic_vector(17 downto 0);
		LEDG : out std_logic_vector(4 downto 0)
	);
end a4;

architecture behaviour of a4 is 
begin
	LEDR <= SW;
	
	cra : entity work.CarryRippleAdder(behaviour)
				port map( 
					a => SW(3 downto 0),
					b => SW(7 downto 4),
					c_in => SW(8),
					s => LEDG(3 downto 0),
					c_out => LEDG(4)
				);
end behaviour;

