library ieee;
use ieee.std_logic_1164.all;
-- use IEEE.numeric_std.all;
use ieee.std_logic_unsigned.all;


entity a1 is
	port (
		CLOCK_50 : in std_logic;
		HEX0		: out std_logic_vector(0 to 6);
		HEX1		: out std_logic_vector(0 to 6);
		HEX2		: out std_logic_vector(0 to 6)
	);
end a1;

architecture behaviour of a1 is
	signal clk : std_logic;
	signal count : std_logic_vector(22 downto 0);
	signal number0 : std_logic_vector(3 downto 0);
	signal number1 : std_logic_vector(3 downto 0);
	signal number2 : std_logic_vector(3 downto 0);
	signal output0 : std_logic_vector(0 to 6);
	signal output1 : std_logic_vector(0 to 6);
	signal output2 : std_logic_vector(0 to 6);
	
	
	begin 
	
	clk <= CLoCK_50;
	HEX0 <= output0;
	HEX1 <= output1;
	HEX2 <= output2;
	
	digit0 : entity work.SevenSegDecoder(behaviour)
						port map(
							input => number0,
							output => output0
						);
	
	digit1 : entity work.SevenSegDecoder(behaviour)
						port map(
							input => number1,
							output => output1
						);
	
	digit2 : entity work.SevenSegDecoder(behaviour)
						port map(
							input => number2,
							output => output2
						);
						
	
	process(clk)
	begin 
		if (rising_edge(clk)) then --sync with clock 
			-- first of all an implementation for "counting" 1 second is needed
			-- think about overflow
			count <= count + 1;
		end if;
	end process;
	
	process(clk)
	begin
	if (rising_edge(clk)) then --sync with clock 
		if (count = 0) then --triger action to count
			
			number0 <= number0 + 1;
			
			if number2 = 9 and number1 = 9 and number0 = 9 then
				number0 <= (3 downto 0 => '0');
				number1 <= (3 downto 0 => '0');
				number2 <= (3 downto 0 => '0');

			elsif number1 = 9 and number0 = 9 then
				number0 <= (3 downto 0 => '0');
				number1 <= (3 downto 0 => '0');
				number2 <= number2 + 1;
			elsif number0 = 9 then 
				number0 <= (3 downto 0 => '0');
				number1 <= number1 + 1;
			end if;
		end if;
	end if;
	end process;
	end behaviour;