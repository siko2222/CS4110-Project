-- Listing 6.3 modified
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Interface (I/O) of cicuit 
entity movement_control is
   port(clk, rst, pwm_in: in std_logic;
   limit, trigger_out: out std_logic;
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
end movement_control;

-- Functionality of circuit
architecture arch of movement_control is
  signal under_the_limit: std_logic;
  signal width_cnt: std_logic_vector(19 downto 0);
  signal threshold_limit: std_logic_vector(19 downto 0) := "00001100001101010000"; -- Currently using 50000 (ca 8,5 cm)
  signal write: std_logic := '1';
  signal control_signal : std_logic_vector(2 downto 0);
begin
   
	-- Instantiate PWM reader
    pwm_reader: entity work.pwm_reader(arch)
    port map(clk=>clk,
    rst=>rst,
    write=>write,
    pwm_in=>pwm_in,
    under_the_limit=>under_the_limit,
    threshold_limit=>threshold_limit,
    width_count=>width_cnt,
    trigger_out=>trigger_out
    );
	
	-- Instantiate motor controller
	motor_controller: entity work.motor_controller(arch)
    port map(
    control_signal=>control_signal,
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
    rearRight_en=>rearRight_en
    );
	
	-- Instantiate FSM control path
    control_path: entity work.fsm(arch)
    port map(clk=>clk, reset=>rst, under_the_limit=>under_the_limit, control_signal=>control_signal, width_count=>width_cnt);
    
    -- Set the limit output to be the value of the signal under_the_limit
    limit <= under_the_limit;
    	
end arch;