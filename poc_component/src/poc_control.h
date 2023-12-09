#ifndef POC_CONTROL_H
#define POC_CONTROL_H

#include "xgpio.h"

/* Definitions */
#define GPIO_DEVICE_ID XPAR_XSLCR_0_DEVICE_ID
#define LED_CHANNEL 1
#define LED_DELAY 10000000
#define QUICK_FLASH_DELAY 5000000
#define SLOW_FLASH_DELAY 15000000
#define THRESHOLD 10
#define SPEED_OF_SOUND 343 // Speed of sound in meters per second


extern XGpio LEDInst; // Declare LEDInst as extern




/* Function prototypes */
void MoveForward(XGpio *LEDInst);
int DetectObject(XGpio *LEDInst);
void Reverse(XGpio *LEDInst);
void TurnLeft(XGpio *LEDInst);

#endif // POC_CONTROL_H

