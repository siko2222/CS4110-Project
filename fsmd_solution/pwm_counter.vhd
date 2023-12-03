-- Listing 4.10 modified 
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity up_counter is
   generic(N: integer := 20);
   port(clk, rst: in std_logic;
        uc_clr, uc_cnt: in std_logic;
        uc_q: out std_logic_vector(N-1 downto 0));
end up_counter;

architecture arch of up_counter is
   signal r_reg: unsigned(N-1 downto 0);
   signal r_next: unsigned(N-1 downto 0);
   
begin
   -- register
   process(clk,rst)
   begin
      if (rst='1') then
         r_reg <= (others=>'0');
      elsif rising_edge(clk) then
         r_reg <= r_next;
      end if;
   end process;
   
   -- next-state logic
   r_next <= 
             r_reg + 1     when uc_cnt = '1' else
             (others => '0') when uc_clr = '1' else
             r_reg;
             
   -- output logic
   uc_q <= std_logic_vector(r_reg);
   
end arch;