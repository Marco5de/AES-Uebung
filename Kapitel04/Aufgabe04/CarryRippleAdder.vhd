LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

entity CarryRippleAdder is
	port(
		a : in std_logic_vector(3 downto 0);
		b : in std_logic_vector(3 downto 0);
		c_in : in std_logic;
		s : out std_logic_vector(3 downto 0);
		c_out : out std_logic
	);
end CarryRippleAdder;


architecture behaviour of CarryRippleAdder is
signal c1, c2, c3 : std_logic;
begin 
	bit0 : entity work.FullAdder(behaviour)
					port map(
						a => a(0),
						b => b(0),
						c_in => c_in,
						s => s(0),
						c_out => c1
					);
	bit1 : entity work.FullAdder(behaviour)
				port map(
					a => a(1),
					b => b(1),
					c_in => c1,
					s => s(1),
					c_out => c2
				);
	bit2 : entity work.FullAdder(behaviour)
					port map(
						a => a(2),
						b => b(2),
						c_in => c2,
						s => s(2),
						c_out => c3
					);
	bit3 : entity work.FullAdder(behaviour)
				port map(
					a => a(3),
					b => b(3),
					c_in => c3,
					s => s(3),
					c_out => c_out
				);

					
end behaviour;