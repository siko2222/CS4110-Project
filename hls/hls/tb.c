#include "ultrasonic.h"
#include <stdio.h>

#define SIMULATION

void print_short_info(bool trigger, bool echo, float distance){
    printf("\t---\n\tTrigger = %d\n\tEcho = %d\n\tDistance = %fmm\n", trigger, echo, distance);
}

int main() {
    unsigned int predefined_echos_tick = 58824;
    bool trigger_out = 0;
    bool echo_out = 0;
    float measured_distance;

    trigger_out = 0;
    echo_out = 0;
    measured_distance = 0;

    printf("\n\nTEST %d\n", predefined_echos_tick);
    ultrasonic(&trigger_out, &echo_out, &measured_distance);
    print_short_info(trigger_out, echo_out, measured_distance);

    for (int i = 0; i < TRIGGER_PULSE_TICKS; i++){
        ultrasonic(&trigger_out, &echo_out, &measured_distance);
    }

    ultrasonic(&trigger_out, &echo_out, &measured_distance);
    print_short_info(trigger_out, echo_out, measured_distance);

    echo_out = 1;
    for (int i = 0; i < predefined_echos_tick; i++){
        ultrasonic(&trigger_out, &echo_out, &measured_distance);
    }
    print_short_info(trigger_out, echo_out, measured_distance); 

    echo_out = 0;
    ultrasonic(&trigger_out, &echo_out, &measured_distance);
    print_short_info(trigger_out, echo_out, measured_distance); 

    return 0;
}