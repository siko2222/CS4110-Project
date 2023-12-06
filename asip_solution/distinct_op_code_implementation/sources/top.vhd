-- josemmf@usn.no | 2023.10
-- Listing 6.3 modified

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity OneCycleCPU is
   generic(
      PCDATA_WIDTH: integer:=8;
      IMADDR_WIDTH: integer:=5;
      IMDATA_WIDTH: integer:=24;
      DRADDR_WIDTH: integer:=3;
      DRDATA_WIDTH: integer:=8;
      DMADDR_WIDTH: integer:=8;
      DMDATA_WIDTH: integer:=8;
      OPCODE_WIDTH: integer:=7;
      
      CLOCK_FREQ: integer := 100000000;
      SOUND_SPEED: integer := 340;

      -- ULTRASONIC SPECIFIC
      ULTRASONIC_TRIGGER_DELAY_TICKS: integer := 25_000_000;    -- Trigger delay of 250ms
      ULTRASONIC_TRIGGER_PULSE_TICKS: integer := 1000;
      ULTRASONIC_ECHO_DISTANCE_FACTOR: integer := 1000;         -- Convert to millimeters (1m * 1000 = 1000mm)
      ULTRASONIC_ECHO_MINIMUM_DISTANCE: integer := 10;          -- Filter out distance less than specified
      ULTRASONIC_ECHO_DELAY: integer := 5900;                   -- Delay before listening for echo of approx. 1cm
      MOTOR_PWM_FREQUENCY: integer := 100                       -- 100Hz motor pwm frequency
   );
   port(
      clk, rst: in std_logic;
      
      -- Ultrasonic specific
      ultrasonic_receiver: in std_logic;
      ultrasonic_trigger: out std_logic;
      
      -- Motors
      mfl_en, mfl_in1, mfl_in2: out std_logic;
      mfr_en, mfr_in1, mfr_in2: out std_logic;
      mrr_en, mrr_in1, mrr_in2: out std_logic;
      mrl_en, mrl_in1, mrl_in2: out std_logic
-- Optional leds to indicate the distance measurement:
--      led_dist_0, led_dist_50, led_dist_100, led_dist_150, led_dist_200, led_dist_250: out std_logic
   );
end OneCycleCPU;

architecture arch of OneCycleCPU is
   signal dr_wr_ctr, dm_wr_ctr, alu_zero, alu_gt, alu_eq: std_logic;
   signal pc_mux_ctr, dreg_mux_ctr: std_logic;
   signal alu_mux_ctr: std_logic_vector(1 downto 0);
   signal pc_in, pc_out: std_logic_vector(PCDATA_WIDTH-1 downto 0);
   signal opcd_out: std_logic_vector(IMDATA_WIDTH-1 downto 0); 
   signal dr1_dout, dr2_dout: std_logic_vector(DRDATA_WIDTH-1 downto 0);
   signal alu_mux_out, alu_dout: std_logic_vector(DRDATA_WIDTH-1 downto 0);
   signal dm_dout, dr_mux_out: std_logic_vector(DMDATA_WIDTH-1 downto 0);
   signal alu_ctr_in: std_logic_vector(OPCODE_WIDTH-1 downto 0);
   
   -- Hardware counter specific
   signal ctr_rst, ctr_precision_max_tick: std_logic;
   signal ctr_duration: std_logic_vector(DRDATA_WIDTH-1 downto 0);

   -- Ultrasonic specifc
   signal trigger_delay_ctr_en, trigger_delay_done: std_logic;
   signal trigger_pulse_ctr_en, trigger_pulse_done: std_logic;
   
   signal echo_delay_ctr_en, echo_delay_done: std_logic;
   signal echo_ctr_en, echo_ctr_rst: std_logic;
   signal echo_reg_load: std_logic;

   signal echo_ctr_q: std_logic_vector(23 downto 0);
   signal echo_reg_out: std_logic_vector(23 downto 0);

   signal distance_intermediate: integer;
   signal distance_to_object: std_logic_vector(7 downto 0);
   
   -- Motor specific
   signal mfl_load, mfr_load, mrr_load, mrl_load: std_logic;
   signal mfl_reg_out, mfr_reg_out, mrr_reg_out, mrl_reg_out: std_logic_vector(DRDATA_WIDTH-1 downto 0);
   signal pwm_ctr_q: std_logic_vector(20 downto 0);
   signal mfl_magnitude, mfr_magnitude, mrr_magnitude, mrl_magnitude: unsigned(DMDATA_WIDTH-1 downto 0);
begin

    -- instantiate program counter
    pc: entity work.pc(arch)
    port map(clk=>clk, rst=>rst, reg_d=>pc_in, 
             reg_q=>pc_out);
   
    -- instantiate instruction memory
    imem: entity work.imem(arch)
    port map(im_addr=>pc_out(4 downto 0), im_dout=>opcd_out);
	
	-- instantiate data registers
    dreg: entity work.dreg(arch)
    port map(clk=>clk, dr_wr_ctr=>dr_wr_ctr, dwr_addr=>opcd_out(9 downto 7), 
		     dr1_addr=>opcd_out(12 downto 10), dr2_addr=>opcd_out(15 downto 13),              
		     dwr_din=>dr_mux_out, dr1_dout=>dr1_dout, dr2_dout=>dr2_dout);
	
	-- instantiate ALU
    alu: entity work.alu(arch)
    port map(alu_din_hi=>dr1_dout, alu_din_lo=>alu_mux_out,             
		     alu_ctr_in=>alu_ctr_in, alu_dout=>alu_dout, alu_zero=>alu_zero, alu_gt=>alu_gt, alu_eq=>alu_eq);
	
	-- instantiate data memory
    dmem: entity work.dmem(arch)
    port map(clk=>clk, dm_wr_ctr=>dm_wr_ctr, 
		     dm_addr=>alu_dout, dm_din=>dr2_dout, dm_dout=>dm_dout);
		                       
	-- instantiate FSM control path
    control: entity work.control(arch)
    port map(clk=>clk, rst=>rst, alu_zero=>alu_zero, alu_gt=>alu_gt, alu_eq=>alu_eq,
		     pc_mux_ctr=>pc_mux_ctr, alu_mux_ctr=>alu_mux_ctr, dreg_mux_ctr=>dreg_mux_ctr,
		     ctr_rst=>ctr_rst,
		     mfl_load=>mfl_load, mfr_load=>mfr_load, mrr_load=>mrr_load, mrl_load=>mrl_load,
		     opcode=>opcd_out(OPCODE_WIDTH-1 downto 0), dreg_write=>dr_wr_ctr, dmem_write=>dm_wr_ctr, alu_ctr=>alu_ctr_in);
	
	-- Glue logic at top level: pc_mux
	pc_in <= std_logic_vector(unsigned(pc_out) + 1) when pc_mux_ctr='1' else 
	         std_logic_vector(unsigned(pc_out) + unsigned(opcd_out(23 downto 16))) when opcd_out(23)='0' else
             std_logic_vector(unsigned(pc_out) - not(unsigned(opcd_out(23 downto 16))-1))  ;
             
	-- Glue logic at top level: alu_mux
	alu_mux_out <= dr2_dout when alu_mux_ctr="00" else 
	               opcd_out(23 downto 16) when alu_mux_ctr="01" else
	               distance_to_object when alu_mux_ctr="10" else	              
	               ctr_duration when alu_mux_ctr="11";

	-- Glue logic at top level: dr_mux
	dr_mux_out <= alu_dout when dreg_mux_ctr='1' else dm_dout;  
	
	----- Hardware timer -----
	precision_counter: entity work.mod_m_counter(arch)
	generic map(N=>24, M=>CLOCK_FREQ/100) -- 0.01 second counter
	port map(clk=>clk, en=>'1', reset=>ctr_rst, max_tick=>ctr_precision_max_tick);
		
	duration_counter: entity work.mod_m_counter(arch)
	generic map(N=>DRDATA_WIDTH, M=>256) -- Up to 2.55 seconds
	port map(clk=>clk, reset=>ctr_rst, en=>ctr_precision_max_tick, q=>ctr_duration);
	
	----- Ultrasonic transducer -----	
	trigger_delay_ctr: entity work.mod_m_counter(arch)
	generic map(N=>25, M=>ULTRASONIC_TRIGGER_DELAY_TICKS) -- 100 millisecond per transmission
	port map(clk=>clk, en=>trigger_delay_ctr_en, reset=>rst, max_tick=>trigger_delay_done);

    trigger_pulse_ctr: entity work.mod_m_counter(arch)
    generic map(N=>10, M=>ULTRASONIC_TRIGGER_PULSE_TICKS) -- 15 microsecond trigger pulse
    port map(clk=>clk, en=>trigger_pulse_ctr_en, reset=>rst, max_tick=>trigger_pulse_done);
    
    echo_delay_ctr: entity work.mod_m_counter(arch)
    generic map(N=>14, M=>ULTRASONIC_ECHO_DELAY)
    port map(clk=>clk, en=>echo_delay_ctr_en, reset=>rst, max_tick=>echo_delay_done);

    echo_ctr: entity work.mod_m_counter(arch)
    generic map(N=>24, M=>10000000) -- Received pulse should not exceed 0.1 second...
    port map(clk=>clk, en=>echo_ctr_en, reset=>echo_ctr_rst, q=>echo_ctr_q);
    
    echo_reg: entity work.reg_reset(arch)
    generic map(N=>24)
    port map(clk=>clk, load=>echo_reg_load, reset=>rst,
        d=>echo_ctr_q, q=>echo_reg_out);

    ultrasonic_control: entity work.ultrasonic_control(arch)
    port map(clk=>clk, reset=>rst,
             trigger=>ultrasonic_trigger, echo=>ultrasonic_receiver,
             -- Trigger
             trigger_delay_ctr_en=>trigger_delay_ctr_en, trigger_delay_done=>trigger_delay_done,
             trigger_pulse_ctr_en=>trigger_pulse_ctr_en, trigger_pulse_done=>trigger_pulse_done,
             -- Echo
             echo_delay_ctr_en=>echo_delay_ctr_en, echo_delay_done=>echo_delay_done,
             echo_ctr_en=>echo_ctr_en, echo_ctr_rst=>echo_ctr_rst,
             
             echo_reg_load=>echo_reg_load
     );             

    distance_intermediate <= to_integer(
        (unsigned(echo_reg_out) * ULTRASONIC_ECHO_DISTANCE_FACTOR * SOUND_SPEED) / (2 * CLOCK_FREQ)
    );
    
    distance_to_object <= (others => '1') when distance_intermediate > 255 else
                          std_logic_vector(to_unsigned(distance_intermediate, DRDATA_WIDTH));
                          
-- Commented out optional led indicators for distance to object
--    led_dist_0 <= '1' when distance_intermediate > 0 else '0';
--    led_dist_50 <= '1' when distance_intermediate > 50 else '0';
--    led_dist_100 <= '1' when distance_intermediate > 100 else '0';
--    led_dist_150 <= '1' when distance_intermediate > 150 else '0';
--    led_dist_200 <= '1' when distance_intermediate > 200 else '0';
--    led_dist_250 <= '1' when distance_intermediate > 250 else '0';

    ----- Motors  -----
    motor_pwm_ctr: entity work.mod_m_counter(arch)
    generic map(N=>21, M=>CLOCK_FREQ/MOTOR_PWM_FREQUENCY) -- Period of counter to be 100Hz
    port map(clk=>clk, reset=>rst, en=>'1', q=>pwm_ctr_q);
    
    motor_front_left_reg: entity work.reg_reset(arch)
    generic map(N=>DRDATA_WIDTH)
    port map(
        clk=>clk, reset=>rst, load=>mfl_load, d=>dr2_dout, q=>mfl_reg_out
    );
    
    motor_front_right_reg: entity work.reg_reset(arch)
    generic map(N=>DRDATA_WIDTH)
    port map(
        clk=>clk, reset=>rst, load=>mfr_load, d=>dr2_dout, q=>mfr_reg_out
    );
    
    motor_rear_right_reg: entity work.reg_reset(arch)
    generic map(N=>DRDATA_WIDTH)
    port map(
        clk=>clk, reset=>rst, load=>mrr_load, d=>dr2_dout, q=>mrr_reg_out
    );
    
    motor_rear_left_reg: entity work.reg_reset(arch)
    generic map(N=>DRDATA_WIDTH)
    port map(
        clk=>clk, reset=>rst, load=>mrl_load, d=>dr2_dout, q=>mrl_reg_out
    );
    
    -- Calculate magnitudes
    mfl_magnitude <= unsigned('0' & mfl_reg_out(DRDATA_WIDTH-2 downto 0)) when mfl_reg_out(DRDATA_WIDTH-1)='0' else
                unsigned('0' & not(mfl_reg_out(DRDATA_WIDTH-2 downto 0))) + 1;
    mfr_magnitude <= unsigned('0' & mfr_reg_out(DRDATA_WIDTH-2 downto 0)) when mfr_reg_out(DRDATA_WIDTH-1)='0' else
                unsigned('0' & not(mfr_reg_out(DRDATA_WIDTH-2 downto 0))) + 1;
    mrr_magnitude <= unsigned('0' & mrr_reg_out(DRDATA_WIDTH-2 downto 0)) when mrr_reg_out(DRDATA_WIDTH-1)='0' else
                unsigned('0' & not(mrr_reg_out(DRDATA_WIDTH-2 downto 0))) + 1;
    mrl_magnitude <= unsigned('0' & mrl_reg_out(DRDATA_WIDTH-2 downto 0)) when mrl_reg_out(DRDATA_WIDTH-1)='0' else
                unsigned('0' & not(mrl_reg_out(DRDATA_WIDTH-2 downto 0))) + 1;
    
    mfl_en <= '1' when unsigned(pwm_ctr_q) < (to_integer(mfl_magnitude) * (CLOCK_FREQ/MOTOR_PWM_FREQUENCY)) / 100 else '0';
    mfl_in1 <= '1' when mfl_reg_out(DRDATA_WIDTH-1)='0' else '0';
    mfl_in2 <= '0' when mfl_reg_out(DRDATA_WIDTH-1)='0' else '1';
    
    mfr_en <= '1' when unsigned(pwm_ctr_q) < (to_integer(mfr_magnitude) * (CLOCK_FREQ/MOTOR_PWM_FREQUENCY)) / 100 else '0';
    mfr_in1 <= '1' when mfr_reg_out(DRDATA_WIDTH-1)='0' else '0';
    mfr_in2 <= '0' when mfr_reg_out(DRDATA_WIDTH-1)='0' else '1';
    
    mrr_en <= '1' when unsigned(pwm_ctr_q) < (to_integer(mrr_magnitude) * (CLOCK_FREQ/MOTOR_PWM_FREQUENCY)) / 100 else '0';
    mrr_in1 <= '1' when mrr_reg_out(DRDATA_WIDTH-1)='0' else '0';
    mrr_in2 <= '0' when mrr_reg_out(DRDATA_WIDTH-1)='0' else '1';
    
    mrl_en <= '1' when unsigned(pwm_ctr_q) < (to_integer(mrl_magnitude) * (CLOCK_FREQ/MOTOR_PWM_FREQUENCY)) / 100 else '0';
    mrl_in1 <= '1' when mrl_reg_out(DRDATA_WIDTH-1)='0' else '0';
    mrl_in2 <= '0' when mrl_reg_out(DRDATA_WIDTH-1)='0' else '1';
end arch;