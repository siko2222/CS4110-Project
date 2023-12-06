-- josemmf@usn.no | 2023.10
-- Single-port 256 x 8 RAM with read always enabled
-- Modified from XST 8.1i rams_07, adapted from listing 11.1

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity dmem is
   generic(
      DMADDR_WIDTH: integer:=8;
      DMDATA_WIDTH: integer:=8
   );
   port(
      clk: in std_logic;
      dm_wr_ctr: in std_logic;
      dm_addr: in std_logic_vector(DMADDR_WIDTH-1 downto 0);
      dm_din: in std_logic_vector(DMDATA_WIDTH-1 downto 0);
      dm_dout: out std_logic_vector(DMDATA_WIDTH-1 downto 0);
      
      -- Application specific memory mappings
      dm_distance_in: in std_logic_vector(DMDATA_WIDTH-1 downto 0);
      dm_hw_ctr_in: in std_logic_vector(DMDATA_WIDTH-1 downto 0);
      dm_hw_ctr_rst: out std_logic;
      dm_mfl_out, dm_mfr_out, dm_mrr_out, dm_mrl_out: out std_logic_vector(DMDATA_WIDTH-1 downto 0)
    );
end dmem;

architecture arch of dmem is
   type ram_type is array (2**DMADDR_WIDTH-1 downto 0)
        of std_logic_vector (DMDATA_WIDTH-1 downto 0);
   signal ram: ram_type;
   constant zero_vector: std_logic_vector(DMDATA_WIDTH-1 downto 0) := (others=>'0');

begin
   process (clk)
   begin
      if rising_edge(clk) then
         if (dm_wr_ctr='1') then
            ram(to_integer(unsigned(dm_addr))) <= dm_din;
         end if;
         -- Application specific memory mapping: reset the clr counter
         if ram(2**DMADDR_WIDTH-5) /= zero_vector then
            ram(2**DMADDR_WIDTH-5) <= (others=>'0');
         end if;
         -- Application specific memory mappings
         ram(2**DMADDR_WIDTH-7) <= dm_distance_in;
         ram(2**DMADDR_WIDTH-6) <= dm_hw_ctr_in;
      end if;
   end process;
   dm_dout <= ram(to_integer(unsigned(dm_addr)));

   -- Application specific memory mappings
   dm_hw_ctr_rst <= '0' when ram(2**DMADDR_WIDTH-5) = zero_vector else '1';
   dm_mfl_out <= ram(2**DMADDR_WIDTH-4);
   dm_mfr_out <= ram(2**DMADDR_WIDTH-3);
   dm_mrr_out <= ram(2**DMADDR_WIDTH-2);
   dm_mrl_out <= ram(2**DMADDR_WIDTH-1);
end arch;