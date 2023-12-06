-- Listing 4.5 modified
library ieee;
use ieee.std_logic_1164.all;

entity reg is
   port(clk, rst, reg_ld: in std_logic;
        reg_d: in std_logic_vector(19 downto 0);
        reg_q: out std_logic_vector(19 downto 0));
        
end reg;

architecture arch of reg is

begin
   process(clk,rst)
   begin
      if (rst='1') then
         reg_q <=(others=>'0');
      elsif rising_edge(clk) then
			if (reg_ld='1') then
				reg_q <= reg_d;
			end if;
      end if;
   end process;
   
end arch;