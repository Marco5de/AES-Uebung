LIBRARY ieee;
USE ieee.std_logic_1164.all;


entity a3 is
	port( 
		SW : in std_logic_vector(17 downto 0);
		LEDR : out std_logic_vector(17 downto 0)
	);
end a3;


architecture behaviour of a3 is
begin
	ff : entity work.MS_DFF(behaviour)
				port map( 
					D => SW(0),
					clk => SW(1),
					Q => LEDR(0)
				);
end behaviour;