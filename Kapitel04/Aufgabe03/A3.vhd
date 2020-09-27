LIBRARY ieee;
USE ieee.std_logic_1164.ALL;


entity a3 is
	port ( 
		SW : in std_logic_vector(17 downto 0);
		LEDR : out std_logic_vector(17 downto 0);
		HEX0: out std_logic_vector(0 to 6)
	);
end a3;


architecture behaviour of a3 is
begin 
	LEDR <= SW;
	decoder : entity work.decoder(behaviour)
					port map(
						input => SW(3 downto 0),
						output => HEX0);
end behaviour;