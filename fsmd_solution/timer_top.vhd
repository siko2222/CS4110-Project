-- Listing 6.3 modified
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Interface (I/O) of cicuit 
entity timer is
   generic(N: integer := 30);
   port(clk, rst, en: in std_logic;
        timer_max: in std_logic_vector(N-1 downto 0);
        timer_done: out std_logic);
end timer;

-- Functionality of circuit
architecture arch of timer is
   signal top_clr, top_cnt: std_logic;
   signal top_ucq, top_hrq, top_trq: std_logic_vector(N-1 downto 0);

begin
    -- Up counter
    counter: entity work.up_counter_30(arch)
    port map(clk=>clk, rst=>rst, uc_clr=>top_clr, 
             uc_cnt=>top_cnt, uc_q=>top_ucq);
   
    -- Hold register
    hold_reg_30: entity work.reg_30(arch)
    port map(clk=>clk, rst=>rst,
		     reg_30_ld=>'1', reg_30_d=>top_ucq,
		     reg_30_q=>top_hrq);
	
	-- Threshold register
    threshold_reg_30: entity work.reg_30(arch)
    port map(clk=>clk, rst=>rst,
		     reg_30_ld=>'1', reg_30_d=>timer_max,             
		     reg_30_q=>top_trq);
               
    -- Comparator circuit
    timer_done <= '1' when top_hrq >= top_trq else '0';
	
	-- Ccontrol path (FSM)
    control_path: entity work.timer_fsm(arch)
    port map(clk=>clk,rst=>rst, 
		     clear=>top_clr, count=>top_cnt, en=>en);
	
end arch;