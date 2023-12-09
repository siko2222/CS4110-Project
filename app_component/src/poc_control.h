#ifndef POC_CONTROL_H
#define POC_CONTROL_H

/* Include Files */
#include "xgpio.h"

/* Definitions */
#define GPIO_DEVICE_ID XPAR_AXI_GPIO_0_DEVICE_ID /* GPIO device ID */
#define LED_CHANNEL 1                          /* GPIO port for LEDs */
#define LED_DELAY 10000000                     /* Software delay length */
#define QUICK_FLASH_DELAY 5000000              /* Delay for quick flash */
#define SLOW_FLASH_DELAY 15000000              /* Delay for slow flash */

/* Function prototypes */
void MoveForward(XGpio *LEDInst);
void DetectObject(XGpio *LEDInst);
void Reverse(XGpio *LEDInst);
void TurnLeft(XGpio *LEDInst);

#endif // MOTOR_LED_CONTROL_H
