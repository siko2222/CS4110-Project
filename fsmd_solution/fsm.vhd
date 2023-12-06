-- Listing 5.1 and 5.2
library ieee;
use ieee.std_logic_1164.all;
use IEEE.NUMERIC_STD.ALL;

-- Interface (I/O) of cicuit 
entity fsm is
   port(
      clk, reset: in std_logic;
      under_the_limit: in std_logic;
      control_signal : out std_logic_vector(2 downto 0); -- Control signal for the motor controller
      width_count: in std_logic_vector(19 downto 0) -- Duration of the pulse
   );
end fsm;

-- Functionality of circuit
architecture arch of fsm is
   type eg_state_type is (S0, S1, S2, S3); -- idle, driving, reversing, turn 90 degree left
   signal state_reg, state_next: eg_state_type;
   constant distance_after_reverse: natural := 60000; -- Number of clock cycles corresponding to about 10cm
   signal turn_left_timer_max: std_logic_vector(29 downto 0) := "000000000000110000110101000000"; --2 seconds real life, 2ms in simulation (S*100000) Replace S with desired milliseconds, then to binary
   signal turn_left_timer_done: std_logic; 
   signal turn_left_timer_reset: std_logic;
   signal turn_left_timer_enable: std_logic;
   
begin

   -- Timer for turning left for a duration corresponding to a 90 degree turn
    timer: entity work.timer(arch)
    port map(clk=>clk,
    rst=>turn_left_timer_reset,
    en=>turn_left_timer_enable,
    timer_max=>turn_left_timer_max,
    timer_done=>turn_left_timer_done);

   -- State register
   process(clk,reset)
   begin
      if (reset='1') then
         state_reg <= S0;
      elsif (clk'event and clk='1') then
         state_reg <= state_next;
      end if;
   end process;
   
   
   -- Next-state/output logic
   process(state_reg, under_the_limit, width_count, turn_left_timer_done)
   begin
      -- Default values for outputs
      state_next <= state_reg;  -- Default back to same state
      control_signal <= "000"; -- Default, motors at rest
      turn_left_timer_reset <= '0';
      turn_left_timer_enable <= '0';
      
      case state_reg is
         when S0 => 
            -- Set all motors off, then move to S1
            control_signal <= "000";
            state_next <= S1;
         when S1 =>
            -- Remain in S1 unless obstacle is detected. If detected, move to S2.
            control_signal <= "001";

            if under_the_limit = '1' then 
                state_next <= S2;
            end if;
         when S2 =>
            -- Reverse until distance to obstacle is Y cm, then move to S3
            control_signal <= "010"; 

            if unsigned(width_count) >= distance_after_reverse then
                state_next <= S3;
            end if;
         when S3 =>
            -- Turn 90 degree left, then move to S1
            control_signal <= "011";
            turn_left_timer_enable <= '1'; -- Start timer

            if turn_left_timer_done = '1' then 
                turn_left_timer_reset <= '1';
                state_next <= S1;
            end if;
      end case;
   end process;
end arch;