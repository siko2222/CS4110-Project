#ifndef APPLICATION_H
#define APPLICATION_H

#define STATE_INIT 0
#define STATE_FORWARD 1
#define STATE_REVERSE 2
#define STATE_TURN 3

#define FORWARD_DISTANCE_THRESHOLD 100
#define REVERSE_DISTANCE_THRESHOLD 150

#define ULTRASONIC_TRIGGER_PIN 0
#define ULTRASONIC_ECHO_PIN 1

#define MOTOR_FRONT_LEFT_EN_PIN 0
#define MOTOR_FRONT_LEFT_IN1_PIN 1
#define MOTOR_FRONT_LEFT_IN2_PIN 2

#define MOTOR_FRONT_RIGHT_EN_PIN 3
#define MOTOR_FRONT_RIGHT_IN1_PIN 4
#define MOTOR_FRONT_RIGHT_IN2_PIN 5

#define MOTOR_REAR_RIGHT_EN_PIN 6
#define MOTOR_REAR_RIGHT_IN1_PIN 7
#define MOTOR_REAR_RIGHT_IN2_PIN 8

#define MOTOR_REAR_LEFT_EN_PIN 9
#define MOTOR_REAR_LEFT_IN1_PIN 10
#define MOTOR_REAR_LEFT_IN2_PIN 11

#define FORWARD_BITMASK 0b011011011011
#define REVERSE_BITMASK 0b101101101101
#define LEFT_BITMASK    0b101011011101

int main();
#endif