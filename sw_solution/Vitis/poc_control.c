#include "poc_control.h"
#include "xgpio.h"
#include "xscutimer.h"
#include "xil_printf.h"


//#define TRIG_PIN_ID    // Define the GPIO pin for the Trigger
//#define ECHO_PIN_ID    // Define the GPIO pin for the Echo
#define TIMER_DEVICE_ID XPAR_SCUTIMER_DEVICE_ID // Define the Timer Device ID

XScuTimer_Config *TimerConfig;
XScuTimer TimerInstance;

void MoveForward(XGpio *LEDInst) {
    XGpio_DiscreteWrite(LEDInst, LED_CHANNEL, 0xFFFF);
    for (volatile int Delay = 0; Delay < LED_DELAY; Delay++);
}

/*
int ReadSensor() {
    unsigned int startTime, endTime;
    int distance;

    // Initialize the SCU Timer
    TimerConfig = XScuTimer_LookupConfig(TIMER_DEVICE_ID);
    XScuTimer_CfgInitialize(&TimerInstance, TimerConfig, TimerConfig->BaseAddr);

    // Start the timer
    XScuTimer_Start(&TimerInstance);

    // Send trigger pulse
    XGpio_DiscreteWrite(&LEDInst, LED_CHANNEL, 1 << TRIG_PIN_ID);
    // Short delay
    for (volatile int i = 0; i < 10; i++);
    XGpio_DiscreteWrite(&LEDInst, LED_CHANNEL, 0);

    // Wait for echo to start
    while (XGpio_DiscreteRead(&LEDInst, ECHO_PIN_ID) == 0);

    // Record start time
    startTime = XScuTimer_GetCounterValue(&TimerInstance);

    // Wait for echo to end
    while (XGpio_DiscreteRead(&LEDInst, ECHO_PIN_ID) == 1);

    // Record end time
    endTime = XScuTimer_GetCounterValue(&TimerInstance);

    // Stop the timer
    XScuTimer_Stop(&TimerInstance);

    // Calculate duration
    unsigned int duration = endTime - startTime;

    // Convert duration to distance
    distance = (duration / 2) / SPEED_OF_SOUND;

    return distance;
}
*/

int DetectObject(XGpio *LEDInst) {
    
    (void)LEDInst; // Suppress unused parameter warning
    //int objectDetected = 0;
    //int sensorValue = ReadSensor();

    static int counter = 0;

    // Increment the counter each time the function is called
    counter++;

    // Simulate object detection every N calls
    // For example, let's say every 10th call to this function simulates an object detection
    if (counter % 10 == 0) {
        xil_printf("Simulated Object Detected\r\n");
        return 1; // Simulate detection
    }

    return 0; // No object detected
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
