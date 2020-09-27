LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity avalon is
	port (
		clock_50		: in std_logic;
		KEY			: in std_logic_vector(0 downto 0);
		HEX0			: out std_logic_vector(0 to 6);
		HEX1			: out std_logic_vector(0 to 6);
		HEX2			: out std_logic_vector(0 to 6);
		HEX3			: out std_logic_vector(0 to 6)
	);
end avalon;


architecture structure of avalon is
	signal to_hex : std_logic_vector(31 downto 0);
	
	 component NiosAndReg32 is
        port (
            clk_clk         : in  std_logic;
            resetn_reset_n  : in  std_logic;                    
            to_hex_readdata : out std_logic_vector(31 downto 0)    
        );
    end component NiosAndReg32;
	
	component SevenSegDecoder is
		port(
			input	: in std_logic_vector(3 downto 0);
			output	: out std_logic_vector(0 to 6)
		);
	end component SevenSegDecoder;
	
begin
	    u0 : component NiosAndReg32
        port map (
            clk_clk         => clock_50,         --    clk.clk
            resetn_reset_n  => KEY(0),  -- resetn.reset_n
            to_hex_readdata => to_hex  -- to_hex.readdata
        );
		  
		  h0 : SevenSegDecoder port map(to_hex(3 downto 0), HEX0);
		  h1 : SevenSegDecoder port map(to_hex(7 downto 4), HEX1);
		  h2 : SevenSegDecoder port map(to_hex(11 downto 8), HEX2);
		  h3 : SevenSegDecoder port map(to_hex(15 downto 12), HEX3);
end structure;
		  
