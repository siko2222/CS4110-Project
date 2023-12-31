-- Listing 4.5
library ieee;
use ieee.std_logic_1164.all;
entity reg_reset is
   generic(
      N: integer := 8
   );
   port(
      clk, reset, load: in std_logic;
      d: in std_logic_vector(N-1 downto 0);
      q: out std_logic_vector(N-1 downto 0)
   );
end reg_reset;

architecture arch of reg_reset is
begin
   process(clk,reset)
   begin
      if (reset='1') then
         q <=(others=>'0');
      elsif (rising_edge(clk) and load='1') then
         q <= d;
      end if;
   end process;
end arch;