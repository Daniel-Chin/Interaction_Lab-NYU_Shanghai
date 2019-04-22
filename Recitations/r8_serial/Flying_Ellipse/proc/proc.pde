import processing.serial.*;
import java.util.Arrays;

boolean error = false;
int px = -1;
int py = -1;

String myString = null;
Serial myPort;

int NUM_OF_VALUES = 2;   /** YOU MUST CHANGE THIS ACCORDING TO YOUR PROJECT **/
int[] sfdliuenlfdbgkjafbljbs;      /** this array stores values from Arduino **/

void setup() {
  size(1200, 550);
  setupSerial();
  background(0);
  stroke(255);
}

void draw() {
  updateSerial();
  printArray(sfdliuenlfdbgkjafbljbs);
  if (error) {
    println("We got incredible error here.");
  }
  if (sfdliuenlfdbgkjafbljbs[0] != -1) {
    int x = sfdliuenlfdbgkjafbljbs[0];
    int y = sfdliuenlfdbgkjafbljbs[1];
    if (px == -1) {
      px = x;
      py = y;
    }
    line(px, py, x, y);
    px = x;
    py = y;
  }
}



void setupSerial() {
  printArray(Serial.list());
  myPort = new Serial(this, Serial.list()[0], 9600);

  myPort.clear();
  // Throw out the first reading,
  // in case we started reading in the middle of a string from the sender.
  myString = myPort.readStringUntil((int) '\n');
  myString = null;

  sfdliuenlfdbgkjafbljbs = new int[NUM_OF_VALUES];
  Arrays.fill(sfdliuenlfdbgkjafbljbs, -1);
}

void updateSerial() {
  while (myPort.available() > 0) {
    myString = myPort.readStringUntil((int) '\n');
    if (myString != null) {
      String[] serialInArray = split(trim(myString), ',');
      if (serialInArray.length == NUM_OF_VALUES) {
        sfdliuenlfdbgkjafbljbs[0] = int(map(int(serialInArray[0]), 0, 1024, 0, width));
        sfdliuenlfdbgkjafbljbs[1] = int(map(int(serialInArray[1]), 0, 1024, 0, height));
      } else {
        error = true;
      }
    }
  }
}
