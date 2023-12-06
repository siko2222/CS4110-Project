-- josemmf@usn.no | 2023.10
-- Listing 4.5 modified

library ieee;
use ieee.std_logic_1164.all;

entity pc is
   generic(
      PCDATA_WIDTH: integer:=8
   );
   port(clk, rst: in std_logic;
        reg_d: in std_logic_vector(PCDATA_WIDTH-1 downto 0);
        reg_q: out std_logic_vector(PCDATA_WIDTH-1 downto 0));
end pc;

architecture arch of pc is
begin
   process(clk,rst)
   begin
      if (rst='1') then
         reg_q <=(others=>'0');
      elsif rising_edge(clk) then
		 reg_q <= reg_d;
      end if;
   end process;
   
end arch;