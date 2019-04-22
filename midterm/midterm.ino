#include <Servo.h>
// Version 7 
#define ANTI_NOISE 3
#define LASER_THRESHOLD 900
#define ROTATE_SERVO_SPEED 1
#define DANCE_REPEAT 1

#define MAX_ANGLE 135
const int HALF_MAX_ANGLE = MAX_ANGLE / 2;
#define FPS 30
#define WIN_ANIMATION_INTERVAL 2.f
#define LOSE_ANIMATION_INTERVAL 2.4f
#define LOSE_ANIMATION_MAGNITUDE 30
const int DELAY = 1000 / FPS;

#define LEFT_SERVO_PIN 9
#define RIGHT_SERVO_PIN 10
#define ROTATE_SERVO_PIN 11
#define LEFT_SENSOR_PIN A0
#define RIGHT_SENSOR_PIN A1
#define LIGHT_SENSOR_PIN A2
#define DEATH_SIGNAL_RECEIVE_PIN 12
#define DEATH_SIGNAL_TRANSMIT_PIN 13
#define RESET_SIGNAL_RECEIVE_PIN 6
#define RESET_SIGNAL_TRANSMIT_PIN 7

Servo leftServo;
Servo rightServo;
Servo rotateServo;
bool did_win;   // Distributed computing lol
bool did_lose;
bool is_master;
int win_dance_count;

void setup() {
    Serial.begin(9600);
    leftServo.attach(LEFT_SERVO_PIN);
    rightServo.attach(RIGHT_SERVO_PIN);
    rotateServo.attach(ROTATE_SERVO_PIN);
    pinMode(DEATH_SIGNAL_RECEIVE_PIN, INPUT);
    pinMode(DEATH_SIGNAL_TRANSMIT_PIN, OUTPUT);
    pinMode(RESET_SIGNAL_RECEIVE_PIN, INPUT);
    pinMode(RESET_SIGNAL_TRANSMIT_PIN, OUTPUT);
    resetStates();
    transmitReset();
}

void loop() {
    //Serial.println(analogRead(LIGHT_SENSOR_PIN)); ////
    if (checkReset()) return;
    if (!did_win && !did_lose) {
        checkDeath();
    }
    if (did_win) {
        if (win_dance_count >= DANCE_REPEAT) {
            resetStates();
            transmitReset();
            return;
        }
        winAnimation();
        win_dance_count ++;
        return;
    }
    if (did_lose) {
        loseAnimation();
        return;
    }
    handleUser();
    rotateTheServo();
    delay(15);
}

int last_left_angle;
int last_right_angle;
void handleUser() {
    int left_angle = myMap(analogRead(LEFT_SENSOR_PIN));
    int right_angle = myMap(analogRead(RIGHT_SENSOR_PIN));
    Serial.println(right_angle); ////
    if (abs(left_angle - last_left_angle) > ANTI_NOISE) {
        last_left_angle = left_angle;
        leftServo.write(left_angle);
    }
    if (abs(right_angle - last_right_angle) > ANTI_NOISE) {
        last_right_angle = right_angle;
        rightServo.write(right_angle);
    }
}

int myMap(int x) {  // I don't trust `map()`
    return int((float(x) / 1024.f) * float(MAX_ANGLE));
}

int rotate_servo_progress;
void rotateTheServo() {
    int output_angle = abs(rotate_servo_progress - 180);
    if (is_master) {
        rotateServo.write(output_angle);
    } else {
        rotateServo.write(180 - output_angle);
    }
    rotate_servo_progress -= ROTATE_SERVO_SPEED;
    if (rotate_servo_progress == 0) {
        rotate_servo_progress = 360;
    }
}

void transmitReset() {
    digitalWrite(RESET_SIGNAL_TRANSMIT_PIN, HIGH);
    Serial.print("Sending RESET signal... ");
    Serial.print("!reset");
    delay(50);
    Serial.println("Done. ");
    digitalWrite(RESET_SIGNAL_TRANSMIT_PIN, LOW);
    is_master = true;
}

bool checkReset() {
    if (digitalRead(RESET_SIGNAL_RECEIVE_PIN) == HIGH) {
        resetStates();
        Serial.println("RESET signal received.");
        Serial.print("!reset");
        delay(100);
        Serial.println("Reset success.");
        is_master = false;
        return true;
    }
    return false;
}

void resetStates() {
    did_lose = false;
    did_win = false;
    rotate_servo_progress = 360;
    digitalWrite(RESET_SIGNAL_TRANSMIT_PIN, LOW);
    digitalWrite(DEATH_SIGNAL_TRANSMIT_PIN, LOW);
    last_left_angle = -ANTI_NOISE - 1;
    last_right_angle = -ANTI_NOISE - 1;
}

void checkDeath() {
    did_win = digitalRead(DEATH_SIGNAL_RECEIVE_PIN);
    if (did_win) {
        Serial.println("DEATH signal received. ");
        Serial.println("!win");
        win_dance_count = 0;
        return;
    }
    // Serial.println(analogRead(LIGHT_SENSOR_PIN)); ////
    if (analogRead(LIGHT_SENSOR_PIN) < LASER_THRESHOLD) {
        did_lose = true;
        digitalWrite(DEATH_SIGNAL_TRANSMIT_PIN, HIGH);
        Serial.println("DEATH signal sent. ");
        Serial.println("!lose");
    }
}

const int WIN_N_FRAMES = int(float(FPS) * WIN_ANIMATION_INTERVAL);
void winAnimation() {
    for (int k = -1; k < 3; k += 2) {
        for (int i = 0; i < WIN_N_FRAMES; i ++) {
            delay(DELAY);
            if (checkReset()) return;
            float progressx2 = float(2 * i) / float(WIN_N_FRAMES);
            int angle = int((1.f - sq(progressx2 - 1.f)) * MAX_ANGLE);
            leftServo.write(angle);
            rightServo.write(MAX_ANGLE - angle);
            if (i < WIN_N_FRAMES / 2)  {
                rotateServo.write(HALF_MAX_ANGLE + int(progressx2 * HALF_MAX_ANGLE) * k);
            } else {
                rotateServo.write(HALF_MAX_ANGLE + int((2.f - progressx2) * HALF_MAX_ANGLE) * k);
            }
        }
    }
}

const int LOSE_N_FRAMES = int(float(FPS) * LOSE_ANIMATION_INTERVAL);
const int LOSE_FRAME_SEP_1 = int(float(LOSE_N_FRAMES) * 0.25f);
const int LOSE_FRAME_SEP_2 = int(float(LOSE_N_FRAMES) * 0.5f);
const int LOSE_FRAME_SEP_3 = int(float(LOSE_N_FRAMES) * 0.75f);
const float LOSE_DEGREE_PER_FRAME = LOSE_ANIMATION_MAGNITUDE / LOSE_FRAME_SEP_1;
void loseAnimation() {
    leftServo.write(0);
    rightServo.write(MAX_ANGLE);
    rotateServo.write(90);
    for (int i = 0; i < LOSE_N_FRAMES; i ++) {
        delay(DELAY);
        if (checkReset()) return;
        if (i < LOSE_FRAME_SEP_1) {
            leftServo.write(i * LOSE_DEGREE_PER_FRAME);
        } else if (i < LOSE_FRAME_SEP_2) {
            rightServo.write(MAX_ANGLE - (i - LOSE_FRAME_SEP_1) * LOSE_DEGREE_PER_FRAME);
        } else if (i < LOSE_FRAME_SEP_3) {
            leftServo.write((LOSE_FRAME_SEP_3 - i) * LOSE_DEGREE_PER_FRAME);
        } else {
            rightServo.write(MAX_ANGLE - (LOSE_N_FRAMES - i) * LOSE_DEGREE_PER_FRAME);
        }
    }    
}
