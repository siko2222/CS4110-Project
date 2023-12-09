#ifndef ULTRASONIC_H
#define ULTRASONIC_H

#include <stdbool.h>

#define S_TRIGGERING 0
#define S_LISTENING 1
#define S_DELAY 2

extern const float CLOCK_FREQUENCY;
extern const float SPEED_OF_SOUND;
extern const float TRIGGER_PULSE_TICKS;
extern const float MEASUREMENT_DELAY_TICKS;


void ultrasonic(bool *trigger_out, bool *echo_in, float *distance);

#endif