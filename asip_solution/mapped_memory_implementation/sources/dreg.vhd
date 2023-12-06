-- josemmf@usn.no | 2023.10
-- 8 x 8 RAM with read always enabled
-- triple address bus (2 to read, 1 to write), dual data out bus, single data in bus
-- Modified from XST 8.1i rams_07, adapted from listing 11.1

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity dreg is
   generic(
      DRADDR_WIDTH: integer:=3;
      DRDATA_WIDTH: integer:=8
   );
   port(
      clk: in std_logic;
      dr_wr_ctr: in std_logic;
      dwr_addr, dr1_addr, dr2_addr: in std_logic_vector(DRADDR_WIDTH-1 downto 0);
      dwr_din: in std_logic_vector(DRDATA_WIDTH-1 downto 0);
      dr1_dout, dr2_dout: out std_logic_vector(DRDATA_WIDTH-1 downto 0)
    );
end dreg;

architecture arch of dreg is
   type ram_type is array (2**DRADDR_WIDTH-1 downto 0)
        of std_logic_vector (DRDATA_WIDTH-1 downto 0);
   signal ram: ram_type;

begin
   process (clk)
   begin
      if rising_edge(clk) then
         if (dr_wr_ctr='1') then
            ram(to_integer(unsigned(dwr_addr))) <= dwr_din;
         end if;
      end if;
   end process;
   dr1_dout <= ram(to_integer(unsigned(dr1_addr)));
   dr2_dout <= ram(to_integer(unsigned(dr2_addr)));

end arch;