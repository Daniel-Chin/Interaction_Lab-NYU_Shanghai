import processing.serial.*;

Serial port;

void setupSerial(int com) {
  printArray(Serial.list());
  port = new Serial(this, Serial.list()[com], 9600);
  port.clear();
}

void setupSerial() {
  setupSerial(0);
}
