LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity CRCCHecker_avalon_interface is
	port (
		clock, reset					: in std_logic;
		read, write, chipselect		: in std_logic;
		addr								: in std_logic;
		writedata						: in std_logic_vector(31 downto 0);
		readdata							: out std_logic_vector(31 downto 0)
	);
end CRCCHecker_avalon_interface;


architecture structure of CRCCHecker_avalon_interface is
	signal to_crc, from_crc : std_logic_vector(31 downto 0);
	signal addr_impl : std_logic;
	
	component CRCChecker 
		port(
			clk : in std_logic;
			reset : in std_logic;
			addr : in std_logic;
			write_enable : in std_logic;
			write_data : in std_logic_vector(31 downto 0);
			read_data : out std_logic_vector(31 downto 0)
		);
	end component CRCChecker;

begin
	to_crc <= writedata;
	readdata <= from_crc;
	
	with (chipselect and (write or read)) select
		addr_impl <= addr when '1',
									'0' 		when others;
	
	crc : CRCChecker
				port map(
					clock, reset, addr_impl, write, to_crc, from_crc
				);

end structure;