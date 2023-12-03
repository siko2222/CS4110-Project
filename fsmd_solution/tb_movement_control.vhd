--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY tb_movement_control IS
END tb_movement_control;
 
ARCHITECTURE behavior OF tb_movement_control IS 
 
    -- Component Declaration for the Unit Under Test (UUT) 
    COMPONENT movement_control
    PORT(clk, rst, pwm_in: in std_logic;
   limit,trigger_out: out std_logic;
   frontLeft_in1 : out std_logic;
   frontLeft_in2 : out std_logic;
   frontLeft_en : out std_logic;
   frontRight_in1 : out std_logic;
   frontRight_in2 : out std_logic;
   frontRight_en : out std_logic;
   rearLeft_in1 : out std_logic;
   rearLeft_in2 : out std_logic;
   rearLeft_en : out std_logic;
   rearRight_in1 : out std_logic;
   rearRight_in2 : out std_logic;
   rearRight_en : out std_logic);
    END COMPONENT;
    
   --Inputs
   signal clk : std_logic;
   signal rst : std_logic:= '0';
   signal pwm_in : std_logic;
   
 	--Outputs
 	signal trigger_out: std_logic;
 	signal frontLeft_in1 :std_logic;
    signal frontLeft_in2 :std_logic;
    signal frontLeft_en : std_logic;
    signal frontRight_in1 : std_logic;
    signal frontRight_in2 : std_logic;
    signal frontRight_en : std_logic;
    signal rearLeft_in1 : std_logic;
    signal rearLeft_in2 : std_logic;
    signal rearLeft_en : std_logic;
    signal rearRight_in1 : std_logic;
    signal rearRight_in2 : std_logic;
    signal rearRight_en : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: movement_control PORT MAP (
    clk => clk,
    rst => rst,
    pwm_in => pwm_in,
    frontLeft_in1=>frontLeft_in1,
    frontLeft_in2=>frontLeft_in2,
    frontLeft_en=>frontLeft_en,
    frontRight_in1=>frontRight_in1,
    frontRight_in2=>frontRight_in2,
    frontRight_en=>frontRight_en,
    rearLeft_in1=>rearLeft_in1,
    rearLeft_in2=>rearLeft_in2,
    rearLeft_en=>rearLeft_en,
    rearRight_in1=>rearRight_in1,
    rearRight_in2=>rearRight_in2,
    rearRight_en=>rearRight_en,
    trigger_out=>trigger_out);

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;

   -- Stimulus process
   stim_proc: process
   begin
    -- Reset 
    rst <= '1';
    wait for clk_period;	
	rst <= '0';
    wait for clk_period;	
    
    -- Input signal to be over limit, no obstacle (under_the_limit=0)
    wait for 10us; -- Trigger pulse of 10us
    pwm_in <= '1';
	wait for 600us; -- Echo signal of 600us
	pwm_in <= '0';
	
	wait for 10us; -- Trigger pulse of 10us
	pwm_in <= '1';
	wait for 400us; -- Echo signal of 400us
	pwm_in <= '0';
	
	wait for 10us;
	pwm_in <= '1';
	wait for 700us; -- Echo signal of 400us
	pwm_in <= '0';
	
	wait for 10us; -- Trigger pulse of 10us
	pwm_in <= '1';
	wait for 400us; -- Echo signal of 400us
	pwm_in <= '0';
	
	wait for 3ms;
   end process;

END;
