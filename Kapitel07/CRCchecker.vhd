library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity CRCchecker is
	port(
		clk : in std_logic;
		reset : in std_logic;
		addr : in std_logic;
		write_enable : in std_logic;
		write_data : in std_logic_vector(31 downto 0);
		read_data : out std_logic_vector(31 downto 0)
	);
end CRCchecker;


architecture behaviour of CRCchecker is
	signal enable : std_logic;
	
	signal reset_impl : std_logic;
	signal addr_impl : std_logic;
	signal write_enable_impl : std_logic;
	signal read_data_impl : std_logic_vector(31 downto 0);
	signal write_data_impl : std_logic_vector(31 downto 0);
	
	signal count : std_logic_vector(4 downto 0);
	
	signal msg : std_logic_vector(31 downto 0);
	signal gen : std_logic_vector(7 downto 0);

begin 
	-- assign required signals and create required entities
	reset_impl <= reset;
	addr_impl <= addr;
	write_enable_impl <= write_enable;
	write_data_impl <= write_data;
	read_data <= read_data_impl;
	
	
	process(clk, enable, msg, gen)
	begin
		if rising_edge(clk) and enable = '1' and reset = '0' then -- sync to clock and crc component active!
			if msg(msg'high) = '1' then -- check if uppermost bit is equal to one
				msg(msg'high downto msg'high-8) <= (msg(msg'high downto msg'high-8) xor gen); --xor with gen polynom
			else
				if count < 25 then 
					msg(msg'high downto msg'high-8) <= msg(msg'high-1 downto msg'high-8-1); --shift by one position
					msg(msg'low) <= '0'; --shift in zero
					
					count <= count + 1; --increment counter
				else 
					enable <= '0'; --reset enable bit when finished
					gen <= (gen'high downto gen'low => '0');
				end if;
			end if;
		elsif rising_edge(clk) and enable = '0' and reset = '0' then --syn to clock and crc component disabled!
			if write_enable_impl = '1' then 
				if addr_impl = '0' then 
					msg <= write_data_impl;
				else 
					gen <= write_data_impl(write_data_impl'high downto write_data_impl'high - 7);
					enable <= write_data_impl(write_data_impl'low); 
				end if;
			else 
				if addr_impl = '0' then
					read_data_impl <= msg;
				else 
					read_data_impl <= gen & (23 downto 0 => '0');
				end if;
			end if;
		elsif rising_edge(clk) and reset = '1' then --sync to clock and reset (sync resets easier for the synth.)
			enable <= '0';
			msg <= (msg'high downto msg'low => '0');
			gen <= (gen'high downto gen'low => '0');
		end if;
	end process;

end behaviour;
