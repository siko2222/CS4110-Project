#include "platform.h"
#include "xil_printf.h"
#include "xparameters.h"
#include "xultrasonic.h"
#include "xgpio.h"
#include <xil_assert.h>
#include <xparameters_ps.h>
#include <xstatus.h>
#include "main.h"
#include <unistd.h>

int main()
{
    float distance;
    unsigned short state = STATE_FORWARD;

    unsigned int echo_state;
    unsigned int trigger_state;

    XGpio ultrasonic_gpio;
    XGpio motor_gpio;

    XUltrasonic ultrasonic_module = {
        .Control_BaseAddress = XPAR_ULTRASONIC_0_BASEADDR,
        .IsReady = 0
    };

    init_platform();

    XUltrasonic_Config* const config = XUltrasonic_LookupConfig(XPAR_XSLCR_0_DEVICE_ID);
    const int ret = XUltrasonic_CfgInitialize(&ultrasonic_module, config);
    Xil_AssertNonvoid(ret == XST_SUCCESS);

    // Initialize GPIO drivers
    XGpio_Config* const gpio_config = XGpio_LookupConfig(XPAR_XSLCR_0_DEVICE_ID);
    const int ultrasonic_gpio_status = XGpio_CfgInitialize(&ultrasonic_gpio, gpio_config, XPAR_ULTRASONIC_BASEADDR);
    Xil_AssertNonvoid(ultrasonic_gpio_status == XST_SUCCESS);

    const int motor_gpio_status = XGpio_CfgInitialize(&motor_gpio, gpio_config, XPAR_MOTOR_BASEADDR);
    Xil_AssertNonvoid(motor_gpio_status == XST_SUCCESS);

    // Set the pin directions
    XGpio_SetDataDirection(&ultrasonic_gpio, 1, ~(1 << ULTRASONIC_TRIGGER_PIN));    // Output
    XGpio_SetDataDirection(&ultrasonic_gpio, 1, 1 << ULTRASONIC_ECHO_PIN);          // Input

    while (1){
        echo_state = XGpio_DiscreteRead(&ultrasonic_gpio, 1) & (1 << ULTRASONIC_ECHO_PIN);
        trigger_state = XUltrasonic_Get_trigger_out(&ultrasonic_module);
        XGpio_DiscreteWrite(&ultrasonic_gpio, 1, (trigger_state << ULTRASONIC_TRIGGER_PIN));

        distance = XUltrasonic_Get_distance(&ultrasonic_module);

        XUltrasonic_Set_echo_in(&ultrasonic_module, echo_state);

        if(XUltrasonic_IsIdle(&ultrasonic_module))
                XUltrasonic_Start(&ultrasonic_module);

        while(!XUltrasonic_IsDone(&ultrasonic_module));

        switch (state) {
            case STATE_FORWARD:
                XGpio_DiscreteSet(&motor_gpio, 1, FORWARD_BITMASK);
                XGpio_DiscreteClear(&motor_gpio, 1, ~FORWARD_BITMASK);
                if (distance <= FORWARD_DISTANCE_THRESHOLD)
                    state = STATE_REVERSE;
                break;

            case STATE_REVERSE:
                XGpio_DiscreteSet(&motor_gpio, 1, REVERSE_BITMASK);
                XGpio_DiscreteClear(&motor_gpio, 1, ~REVERSE_BITMASK);
                if (distance >= REVERSE_DISTANCE_THRESHOLD)
                    state = STATE_TURN;
                break;

            case STATE_TURN:
                XGpio_DiscreteSet(&motor_gpio, 1, LEFT_BITMASK);
                XGpio_DiscreteClear(&motor_gpio, 1, ~LEFT_BITMASK);
                usleep(1200000);           // Wait 1.2 seconds
                state = STATE_FORWARD;
        }
    }

    cleanup_platform();
    return 0;
}