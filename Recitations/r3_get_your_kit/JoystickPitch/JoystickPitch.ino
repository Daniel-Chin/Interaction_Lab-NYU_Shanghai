void setup() {
  pinMode(A0, INPUT); // declare the ledPin as as OUTPUT
  pinMode(A1, INPUT); // declare the ledPin as as OUTPUT
  pinMode(10, OUTPUT);
  Serial.begin(9600);  // use the serial port
}

void loop() {
  int x = analogRead(A0);
  int y = analogRead(A1) / 4 + 100;
  tone(10, x + 220, y);
  delay(y);
  delay(100);
}
