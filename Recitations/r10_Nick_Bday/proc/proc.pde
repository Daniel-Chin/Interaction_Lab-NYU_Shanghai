import processing.serial.*;
import processing.video.*;

final int COM = 0;

Serial port;
Capture cam;
float temp = 0;

void setup() {
  size(1300, 600);
  surface.setTitle("Nick Bday");

  String[] ports = Serial.list();
  printArray(ports);
  port = new Serial(this, ports[COM], 9600);
  port.bufferUntil(10);
  println("Connected to " + ports[COM]);  

  cam = new Capture(this);
  cam.start();
}

void draw() {
  // println("enter draw");
  pushMatrix();
  if (cam.available()) {
    cam.read();
  }
  int b = 0;
  if (temp < .5) {
    b = int((.5 - temp) * 512);
  }
  int r = 0;
  if (temp > .5) {
    r = int((temp - .5) * 512);
  }
  translate(width, 0);
  scale(-1, 1);

  noTint();
  image(cam, 0, 0, width, height);
  
  tint(r, 0, b, 190);
  image(cam, 0, 0, width, height);
  
  popMatrix();
  // println("exit draw");
}

void serialEvent(Serial port) {
  String line = port.readStringUntil(10);
  if (line != null) {
    onTempChange(float(line));
  }
}

void onTempChange(float temp) {
  this.temp = temp;
  //this.temp = float(mouseX) / float(width);  // debug with mouseX
  println(temp);
}
