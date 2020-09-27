library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity HWSWCRC is
	port(
		CLOCK_50 		: in std_logic;
		KEY			: in std_logic_vector(0 downto 0);
		
		DRAM_DQ : INOUT STD_LOGIC_VECTOR (31 DOWNTO 0);
		DRAM_ADDR : OUT STD_LOGIC_VECTOR (12 DOWNTO 0);
		DRAM_BA : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
		DRAM_CAS_N, DRAM_RAS_N, DRAM_CLK : OUT STD_LOGIC;
		DRAM_CKE, DRAM_CS_N, DRAM_WE_N : OUT STD_LOGIC;
		DRAM_DQM : OUT STD_LOGIC_VECTOR (3 DOWNTO 0)
	);
end HWSWCRC;


architecture structure of HWSWCRC is
    component nios_crc is
        port (
            clk_clk          : in    std_logic;
            reset_reset      : in    std_logic;
            sdram_clk_clk    : out   std_logic;
            sdram_wire_addr  : out   std_logic_vector(12 downto 0);
            sdram_wire_ba    : out   std_logic_vector(1 downto 0);
            sdram_wire_cas_n : out   std_logic;
            sdram_wire_cke   : out   std_logic;
            sdram_wire_cs_n  : out   std_logic;
            sdram_wire_dq    : inout std_logic_vector(31 downto 0);
            sdram_wire_dqm   : out   std_logic_vector(3 downto 0);
            sdram_wire_ras_n : out   std_logic;
            sdram_wire_we_n  : out   std_logic
        );
    end component nios_crc;

begin
    u0 : component nios_crc
        port map (
            clk_clk          => CLOCK_50,          --        clk.clk
            reset_reset      => NOT KEY(0),      --      reset.reset
            sdram_clk_clk    => DRAM_CLK,    --  sdram_clk.clk
            sdram_wire_addr  => DRAM_ADDR,  -- sdram_wire.addr
            sdram_wire_ba    => DRAM_BA,    --           .ba
            sdram_wire_cas_n => DRAM_CAS_N, --           .cas_n
            sdram_wire_cke   => DRAM_CKE,   --           .cke
            sdram_wire_cs_n  => DRAM_CS_N,  --           .cs_n
            sdram_wire_dq    => DRAM_DQ,    --           .dq
            sdram_wire_dqm   => DRAM_DQM,   --           .dqm
            sdram_wire_ras_n => DRAM_RAS_N, --           .ras_n
            sdram_wire_we_n  => DRAM_WE_N   --           .we_n
        );

end structure;