library ieee;
use ieee.std_logic_1164.all;
entity timer_fsm is
   port(
      clk, rst, en: in std_logic;
      clear, count: out std_logic
   );
end timer_fsm;

architecture arch of timer_fsm is
   type state_type is (s0, s1);
   signal st_reg, st_next: state_type;
begin
   -- state register
   process(clk,rst)
   begin
      if (rst='1') then
         st_reg <= s0;
      elsif rising_edge(clk) then
         st_reg <= st_next;
      end if;
   end process;
   
   -- next-state/output logic
   process(st_reg, en)
   begin
      st_next <= st_reg;  -- default back to same state
      clear <= '0';  -- all outputs default to '0'  
      count <= '0';   
	  
      case st_reg is
         when s0 =>
            clear <= '1';
			st_next <= s1;
			
         when s1 =>
         if en = '1' then
            count <= '1';
         end if;
      end case;
      
   end process;
   
end arch;
