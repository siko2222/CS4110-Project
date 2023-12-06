--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY tb_OneCycleCPU IS
END tb_OneCycleCPU;
 
ARCHITECTURE behavior OF tb_OneCycleCPU IS 
 
    -- Component Declaration for the Unit Under Test (UUT) 
    COMPONENT OneCycleCPU
    GENERIC (
        ULTRASONIC_TRIGGER_DELAY_TICKS: integer := 66666;
        ULTRASONIC_TRIGGER_PULSE_TICKS: integer := 1;
        ULTRASONIC_ECHO_DELAY: integer := 30;
        CLOCK_FREQ: integer := 666666
--        CLOCK_FREQ: integer := 100_000_000
    );
    PORT(
        clk, rst, ultrasonic_receiver: in std_logic;
        ultrasonic_trigger: out std_logic
    );
    END COMPONENT;
    
    --Inputs
    signal clk : std_logic;
    signal rst : std_logic;
   
    signal ultrasonic_receiver : std_logic;
   
    --Outputs
    signal ultrasonic_trigger : std_logic;

    -- Clock period definitions
    constant clk_period : time := 10 ns;
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
    uut: OneCycleCPU PORT MAP (
          clk => clk,
          rst => rst,
          ultrasonic_receiver => ultrasonic_receiver,
          ultrasonic_trigger => ultrasonic_trigger 
    );

    -- Clock process definitions
    clk_process: process
    begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
    end process;
 

    -- Stimulus process
    stim_proc: process
    begin		
      rst <= '1';
      wait for clk_period;	
	  rst <= '0';
      wait for clk_period*100000000*1024;
    end process;


--     Echo test
--    echo_proc: process
--    begin
--        ultrasonic_receiver <= '0';
--        wait until ultrasonic_trigger='1';
--        wait for clk_period*117650;
            
--        ultrasonic_receiver <= '1';
--        wait for clk_period*117650;
        
--        ultrasonic_receiver <= '0';
--        wait until ultrasonic_trigger='1';
--        wait for clk_period*58825;
            
--        ultrasonic_receiver <= '1';
--        wait for clk_period*58825;
        
--        ultrasonic_receiver <= '0';
--        wait until ultrasonic_trigger='1';
--        wait for clk_period*88240;
            
--        ultrasonic_receiver <= '1';
--        wait for clk_period*88240;
--    end process;--    
    
-- for 666_666 CF
echo_proc: process
    begin
        ultrasonic_receiver <= '0';
        wait until ultrasonic_trigger='1';
        wait for clk_period*780;
            
        ultrasonic_receiver <= '1';
        wait for clk_period*780;
        
        ultrasonic_receiver <= '0';
        wait until ultrasonic_trigger='1';
        wait for clk_period*390;
            
        ultrasonic_receiver <= '1';
        wait for clk_period*390;
        
        ultrasonic_receiver <= '0';
        wait until ultrasonic_trigger='1';
        wait for clk_period*520;
            
        ultrasonic_receiver <= '1';
        wait for clk_period*520;
    end process;
    
    



END;
