// main.c
#include "xparameters.h"
#include "xgpio.h"
#include "poc_control.h"
#include "xil_printf.h" // Include for xil_printf

XGpio LEDInst; // GPIO Device driver instance

typedef enum {
    STATE_FORWARD,
    STATE_DETECT_OBJECT,
    STATE_REVERSE,
    STATE_TURN_LEFT
} CarState;

void RunTestSequence(XGpio *LEDInst);

int main() {
    int Status;

    /* Initialize the GPIO for LED */
    Status = XGpio_Initialize(&LEDInst, GPIO_DEVICE_ID);
    if (Status != XST_SUCCESS) {
        xil_printf("GPIO Initialization Failed\r\n");
        return XST_FAILURE;
    }
    xil_printf("GPIO Initialized Successfully\r\n");

    /* Set LEDs direction to outputs */
    XGpio_SetDataDirection(&LEDInst, LED_CHANNEL, 0x0);

    /* Run the test sequence */
    RunTestSequence(&LEDInst);

    return 0;
}

void RunTestSequence(XGpio *LEDInst) {
    CarState state = STATE_FORWARD;
    xil_printf("Starting Test Sequence\r\n");

    while (1) {
        switch (state) {
            case STATE_FORWARD:
                xil_printf("Moving Forward\r\n");
                MoveForward(LEDInst);
                state = STATE_DETECT_OBJECT;
                break;
            case STATE_DETECT_OBJECT:
                xil_printf("Detecting Object\r\n");
                if (DetectObject(LEDInst) == 1) {
                    xil_printf("Object Detected\r\n");
                    state = STATE_REVERSE;
}
                break;
            case STATE_REVERSE:
                xil_printf("Reversing\r\n");
                Reverse(LEDInst); // Adjust according to your actual function definition
                state = STATE_TURN_LEFT;
                break;
            case STATE_TURN_LEFT:
                xil_printf("Turning Left\r\n");
                TurnLeft(LEDInst);
                state = STATE_FORWARD;
                break;
            default:
                xil_printf("Unexpected State\r\n");
                break;
        }
    }
}

