library ieee;
use ieee.std_logic_1164.all;

entity pwm_fsm is
   port(
      clk, rst: in std_logic;
      pwm_in: in std_logic;  -- Input signal (echo)
      trigger_out: out std_logic;  -- Trigger signal to the HC-SR04
      clear, count, load: out std_logic 
   );
end pwm_fsm;


architecture arch of pwm_fsm is
   type state_type is (s0, s1, s2, s3); -- States: s0: idle, s1: trigger, s2: wait, s3: count
   signal st_reg, st_next: state_type;
   signal trigger_timer_max: std_logic_vector(29 downto 0) := "000000000000000000001111101000"; -- (S*100000) Replace S with desired milliseconds, then to binary
   signal trigger_timer_done: std_logic; 
   signal trigger_timer_reset: std_logic;
   signal trigger_timer_enable: std_logic;
begin

-- instantiate timer
    timer: entity work.timer(arch)
    port map(clk=>clk,
    rst=>trigger_timer_reset,
    en=>trigger_timer_enable,
    timer_max=>trigger_timer_max,
    timer_done=>trigger_timer_done);

   -- state register
   process(clk, rst)
   begin
      if rst = '1' then
         st_reg <= s0;
      elsif rising_edge(clk) then
         st_reg <= st_next;
      end if;
   end process;

   -- next-state/output logic
   process(st_reg, pwm_in, trigger_timer_done)
   begin
      -- Default values for outputs
      st_next <= st_reg;  -- default back to same state
      clear <= '0';
      count <= '0';
      load <= '0';
      trigger_out <= '0';
      trigger_timer_reset <= '0';
      trigger_timer_enable <= '0';
      
      case st_reg is
         when s0 =>  -- Idle state
            clear <= '1';
            st_next <= s1;
         when s1 =>  -- Trigger state
            trigger_out <= '1';
            trigger_timer_enable <= '1';
            if trigger_timer_done = '1' then
               trigger_timer_enable <= '0';
               trigger_timer_reset <= '1';
               trigger_out <= '0';
               st_next <= s2;
            end if;
            
         when s2 =>  -- Wait state -- trigger should be 0 when entering s2
            if pwm_in = '1' then
               st_next <= s3;
            end if;

         when s3 =>  -- Count state
            count <= '1';
            if pwm_in = '0' then
               load <= '1';
               st_next <= s0;
            end if;
      end case;
   end process;
end arch;
