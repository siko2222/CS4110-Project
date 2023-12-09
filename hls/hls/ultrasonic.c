#include "ultrasonic.h"

const float SPEED_OF_SOUND = 340;
const float CLOCK_FREQUENCY = 100e6;
const float TRIGGER_PULSE_TICKS = 10000;
const float MEASUREMENT_DELAY_TICKS = 100e6/4;

void ultrasonic(bool *trigger_out, bool *echo_in, float *distance) {
    #pragma HLS INTERFACE mode=s_axilite port=ultrasonic
    #pragma HLS INTERFACE mode=s_axilite port=trigger_out
    #pragma HLS INTERFACE mode=s_axilite port=echo_in
    #pragma HLS INTERFACE mode=s_axilite port=distance
    #pragma HLS PIPELINE

    static unsigned int measurement_cycle_ctr = 0;
    static unsigned int echo_start_tick = 0;
    static unsigned short state = 0;

    switch (state) {
        case S_TRIGGERING:
            *trigger_out = 1;

            if (measurement_cycle_ctr > TRIGGER_PULSE_TICKS){
                state = S_LISTENING;
                *trigger_out = 0;
                echo_start_tick = 0;
            }
            break;

        case S_LISTENING:
            if (*echo_in == 1 && echo_start_tick == 0) {
                echo_start_tick = measurement_cycle_ctr;
            } else if (*echo_in == 0 && echo_start_tick > 0) {
                *distance = ((measurement_cycle_ctr - echo_start_tick) * SPEED_OF_SOUND * 1000) / (2 * CLOCK_FREQUENCY);
                state = S_DELAY;
            }
            break;

        case S_DELAY:
            if (measurement_cycle_ctr == MEASUREMENT_DELAY_TICKS){
                state = S_TRIGGERING;
                measurement_cycle_ctr = 0;
            }
            break;
    }

    (measurement_cycle_ctr)++;
}