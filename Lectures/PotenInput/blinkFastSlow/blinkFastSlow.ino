#include <Servo.h>
#define FPS 30
const int MSPF = 1000 / FPS;
const float SCALE = 4.f * PI / 1024.f / float(FPS);
float state = 0;
Servo s;

void setup() {
  // put your setup code here, to run once:
  s.attach(9);
  pinMode(A0, INPUT);
  Serial.begin(9600);
}

void loop() {
  // put your main code here, to run repeatedly:
  int reading = analogRead(A0);
  state += float(reading) * SCALE;
  if (state > 2.f * PI) {
    state -= 2.f * PI;
  }
  s.write(int(180 * ((sin(state) + 1.f) / 2.f)));
  delay(MSPF);
}
