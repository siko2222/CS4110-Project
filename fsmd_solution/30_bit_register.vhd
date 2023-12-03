-- Listing 4.5 modified
library ieee;
use ieee.std_logic_1164.all;

entity reg_30 is
   generic(N: integer := 30);
   port(clk, rst, reg_30_ld: in std_logic;
        reg_30_d: in std_logic_vector(N-1 downto 0);
        reg_30_q: out std_logic_vector(N-1 downto 0));
end reg_30;

architecture arch of reg_30 is

begin
   process(clk,rst)
   begin
      if (rst='1') then
         reg_30_q <=(others=>'0');
      elsif rising_edge(clk) then
			if (reg_30_ld='1') then
				reg_30_q <= reg_30_d;
			end if;
      end if;
   end process;
   
end arch;