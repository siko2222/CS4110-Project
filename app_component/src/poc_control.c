#include "poc_control.h"

void MoveForward(XGpio *LEDInst) {
    XGpio_DiscreteWrite(LEDInst, LED_CHANNEL, 0xFFFF);
    for (volatile int Delay = 0; Delay < LED_DELAY; Delay++);
}

void DetectObject(XGpio *LEDInst) {
    for (int i = 0; i < 2; i++) {
        XGpio_DiscreteWrite(LEDInst, LED_CHANNEL, 0xFFFF);
        for (volatile int Delay = 0; Delay < QUICK_FLASH_DELAY; Delay++);
        XGpio_DiscreteWrite(LEDInst, LED_CHANNEL, 0x0000);
        for (volatile int Delay = 0; Delay < QUICK_FLASH_DELAY; Delay++);
    }
}

void Reverse(XGpio *LEDInst) {
    for (int i = 0; i < 3; i++) {
        XGpio_DiscreteWrite(LEDInst, LED_CHANNEL, 0xFFFF);
        for (volatile int Delay = 0; Delay < SLOW_FLASH_DELAY; Delay++);
        XGpio_DiscreteWrite(LEDInst, LED_CHANNEL, 0x0000);
        for (volatile int Delay = 0; Delay < SLOW_FLASH_DELAY; Delay++);
    }
}

void TurnLeft(XGpio *LEDInst) {
    for (int i = 0; i < 16; i++) {
        XGpio_DiscreteWrite(LEDInst, LED_CHANNEL, 1 << i);
        for (volatile int Delay = 0; Delay < LED_DELAY; Delay++);
    }
}
