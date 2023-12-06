----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/30/2023 08:27:27 AM
-- Design Name: 
-- Module Name: ultrasonic_control - arch
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ultrasonic_control is
port (
    clk, reset: in std_logic;
    trigger: out std_logic;
    echo: in std_logic;
    
    -- Trigger part
    trigger_delay_done: in std_logic;
    trigger_pulse_done: in std_logic;
    
    trigger_delay_ctr_en: out std_logic;
    trigger_pulse_ctr_en: out std_logic;
    
    -- Echo part
    echo_delay_done: in std_logic;
    echo_delay_ctr_en: out std_logic;
    
    echo_ctr_en: out std_logic;
    echo_ctr_rst: out std_logic;
    
    echo_reg_load: out std_logic
);
end ultrasonic_control;

architecture arch of ultrasonic_control is
    type state is (S0, S1, S2, S3, S4);
    signal present_state, next_state: state;
begin
    -- State description
    -- S0: Set trigger high for 15 us
    -- S1: Wait for a small delay to filter out unreliable echo
    -- S2: Wait for echo pulse to turn high, reset echo tick counter
    -- S3: Wait for echo pulse to turn low, load counter into register
    -- S4: Wait for at least 60ms before continuing
    
    -- State register
    process(clk, reset)
    begin
        if (reset='1') then
            present_state <= S0;
        elsif rising_edge(clk) then
            present_state <= next_state;
        end if;
    end process;
    
    
    -- Next-state and output logic
    process (present_state, 
             trigger_delay_done, trigger_pulse_done,
             echo, echo_delay_done)
    begin
        next_state <= present_state;
        
        trigger <= '0';
        trigger_delay_ctr_en <= '0';
        trigger_pulse_ctr_en <= '0';
        
        echo_delay_ctr_en <= '0';
        echo_ctr_en <= '0';
        echo_ctr_rst <= '0';
        echo_reg_load <= '0';
        
        case present_state is
        when S0 =>
            trigger_pulse_ctr_en <= '1';
            trigger <= '1';
            
            if trigger_pulse_done='1' then
                next_state <= S1;
            end if;
        when S1 =>
            -- Wait for a small delay to filter out unreliable echo
            echo_delay_ctr_en <= '1';
            
            if echo_delay_done='1' then
                next_state <= S2;
            end if;
        when S2 =>
            -- Wait for echo pulse to turn high, reset echo tick counter
            if echo='1' then
                next_state <= S3;
                echo_ctr_rst <= '1';
            end if;
        when S3 =>
            -- Wait for echo pulse to turn low, load counter into register
            echo_ctr_en <= '1';
            if echo='0' then
                next_state <= S4;
                echo_reg_load <= '1';
            end if;
        when S4 =>
            -- Wait for at least 60ms before repeating
            trigger_delay_ctr_en <= '1';
            
            if (trigger_delay_done='1') then
                next_state <= S0;
            end if;
        end case;
    end process;
end arch;
