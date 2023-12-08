-- Listing 6.3 modified
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pwm_reader is
   port(
      clk, rst, write, pwm_in: in std_logic;
      threshold_limit: in std_logic_vector(19 downto 0);
      under_the_limit, trigger_out: out std_logic;
      width_count: out std_logic_vector(19 downto 0)
   );
end pwm_reader;

architecture arch of pwm_reader is
   signal top_clr, top_cnt, top_ld: std_logic;
   signal top_ucq, top_hrq, top_trq: std_logic_vector(19 downto 0);

begin
    -- Up counter
    counter: entity work.up_counter(arch)
    port map(clk=>clk, rst=>rst, uc_clr=>top_clr, 
             uc_cnt=>top_cnt, uc_q=>top_ucq);
   
    -- Hold register
    hold_reg: entity work.reg(arch)
    port map(clk=>clk, rst=>rst,
		     reg_ld=>top_ld, reg_d=>top_ucq,
		     reg_q=>top_hrq);
	
	-- Threshold register
    threshold_reg: entity work.reg(arch)
    port map(clk=>clk, rst=>rst,
		     reg_ld=>write, reg_d=>threshold_limit,             
		     reg_q=>top_trq);
               
    -- Comparator circuit
    under_the_limit <= '1' when ((top_hrq < top_trq) and (unsigned(top_hrq) /= 0))  else '0'; --under_the_limit <= '1' when  top_hrq < top_trq  else '0';
	
	-- Control path (FSM)
    control_path: entity work.pwm_fsm(arch)
    port map(clk=>clk, rst=>rst, pwm_in=>pwm_in, 
		     clear=>top_clr, count=>top_cnt, load=>top_ld, trigger_out=>trigger_out);  

	-- Width measurement output
	width_count <= top_hrq;
	
end arch;
