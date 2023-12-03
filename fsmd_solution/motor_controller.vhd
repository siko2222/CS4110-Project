library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Interface (I/O) of cicuit 
entity motor_controller is
    Port (
        control_signal : in std_logic_vector(2 downto 0);
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
        rearRight_en : out std_logic
    );
end motor_controller;

-- Functionality of circuit
architecture arch of motor_controller is   
begin
   -- When the control_signal changes --> change output pattern
    process(control_signal)
    begin
        case control_signal is
            when "001" =>  -- Forward
                -- Set motor outputs for forward motion
                frontLeft_in1 <= '1';
                frontLeft_in2 <= '0';
                frontRight_in1 <= '1';
                frontRight_in2 <= '0';
                rearLeft_in1 <= '1';
                rearLeft_in2 <= '0';
                rearRight_in1 <= '1';
                rearRight_in2 <= '0';
                -- Enable all motors
                frontLeft_en <= '1';
                frontRight_en <= '1';
                rearLeft_en <= '1';
                rearRight_en <= '1';

            when "010" =>  -- Reverse
                -- Set motor outputs for reverse motion
                frontLeft_in1 <= '0';
                frontLeft_in2 <= '1';
                frontRight_in1 <= '0';
                frontRight_in2 <= '1';
                rearLeft_in1 <= '0';
                rearLeft_in2 <= '1';
                rearRight_in1 <= '0';
                rearRight_in2 <= '1';
                -- Enable all motors
                frontLeft_en <= '1';
                frontRight_en <= '1';
                rearLeft_en <= '1';
                rearRight_en <= '1';

            when "011" =>  -- Turn Left
                -- Set motor outputs for turning to the left
                frontLeft_in1 <= '0';
                frontLeft_in2 <= '1';
                frontRight_in1 <= '1';
                frontRight_in2 <= '0';
                rearLeft_in1 <= '0';
                rearLeft_in2 <= '1';
                rearRight_in1 <= '1';
                rearRight_in2 <= '0';
                -- Enable all motors
                frontLeft_en <= '1';
                frontRight_en <= '1';
                rearLeft_en <= '1';
                rearRight_en <= '1';

            when others =>  -- Stop or Undefined Control Signal
                -- Disable all motors
                frontLeft_in1 <= '0';
                frontLeft_in2 <= '0';
                frontRight_in1 <= '0';
                frontRight_in2 <= '0';
                rearLeft_in1 <= '0';
                rearLeft_in2 <= '0';
                rearRight_in1 <= '0';
                rearRight_in2 <= '0';
                frontLeft_en <= '0';
                frontRight_en <= '0';
                rearLeft_en <= '0';
                rearRight_en <= '0';
        end case;
    end process;
end arch;