static final int COM = 0;
static final int MAX_PITCH = 84;
static final int MIN_PITCH = 60;
static final String IP = "10.209.0.168";
static final int PORT = 2341;

// Code is modified from https://github.com/ElectronicCats/mpu6050/tree/master/examples/MPU6050_DMP6

/* ============================================
I2Cdev device library code is placed under the MIT license
Copyright (c) 2012 Jeff Rowberg

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
===============================================
*/

import processing.serial.*;
import toxi.geom.*;
import toxi.processing.*;
import processing.net.*; 

// NOTE: requires ToxicLibs to be installed in order to run properly.
// 1. Download from http://toxiclibs.org/downloads
// 2. Extract into [userdir]/Processing/libraries
//    (location may be different on Mac/Linux)
// 3. Run and bask in awesomeness

ToxiclibsSupport gfx;

Serial port;                         // The serial port
int last_heartbeat = 0;
boolean port_ready = false;
int n_packets = 0;

Client client; 

Quaternion quat = new Quaternion(1, 0, 0, 0);
Quaternion offsetQuat = new Quaternion(1, 0, 0, 0);

int pressure = 0;

void setup() {
  // fullScreen();
  size(400, 400); ////
  gfx = new ToxiclibsSupport(this);

  printArray(Serial.list());
  String port_name = Serial.list()[COM];
  port = new Serial(this, port_name, 38400);
  port.clear();
  println("Serial established. ");
  
  client = new Client(this, IP, PORT);
  println("Socket established. ");

  serialWaitFor("Send any character to begin DMP programming and demo:");
  // send single character to trigger DMP init/start
  // (expected by MPU6050_DMP6 example Arduino sketch)
  delay(100);
  port.write('r');
  serialWaitFor("LET US START");
  port_ready = true;
}

void serialWaitFor(String keyword) {
  String recved = "";
  while (recved == null || ! trim(recved).equals(keyword)) {
    recved = port.readStringUntil((int) '\n');
    if (recved != null) {
      print("From arduino:", recved);
    }
    delay(10);
  }
}

String serial_buffer = "";
void serialEvent(Serial port) {
  last_heartbeat = millis();
  if (! port_ready) return;
  n_packets = 0;
  String received = null;
  String temp_str = "Really Impossible To Accidentally Match";
  while (temp_str != null) {
    received = temp_str;
    temp_str = port.readStringUntil((int) '\n');
    n_packets ++;
  }
  if (received == null || received.equals("Really Impossible To Accidentally Match")) {
    // no packet
    return;
  }

  String[] serialInArray = split(trim(received), '\t');
  switch (serialInArray[0]) {
  case "err":
    print("Error: ");
    for (String x : serialInArray) {
      print(x + ' ');
    }
    println();
    break;
  case "quat":
    if (serialInArray.length != 5) {
      println("Expected 5 cells, got", serialInArray.length, ". Here:");
      printArray(serialInArray);
      return;
    }
    quat.set(
      float(serialInArray[1]), 
      float(serialInArray[2]), 
      float(serialInArray[3]), 
      float(serialInArray[4]) 
    );
    break;
  case "pres":
    if (serialInArray.length != 2) {
      println("Expected 2 cells, got", serialInArray.length, ". Here:");
      printArray(serialInArray);
      return;
    }
    pressure = int(serialInArray[1]);
    break;
  default:
    println("Unexpected packet:");
    printArray(serialInArray);
  }
}

void zeroGyro() {
  offsetQuat = quat.getConjugate();
}

void heartBeat() {
  if (millis() - last_heartbeat > 1000) {
    // resend single character to trigger DMP init/start
    // in case the MPU is halted/reset while applet is running
    port.write('r');
    last_heartbeat = millis();
  }
}

void draw() {
  heartBeat();
  
  Quaternion effective_quat = offsetQuat.multiply(quat);
  if (Float.isNaN(effective_quat.x)) {
    effective_quat = new Quaternion(1, 0, 0, 0);
    println("NaN handled");
  }
  float pitch = map(effective_quat.y, -.5, .3, MIN_PITCH, MAX_PITCH);
  pitch = constrain(pitch, MIN_PITCH, MAX_PITCH);
  float dynamic = map(pressure, 100900, 101500, 0f, 1f);
  dynamic = constrain(dynamic, 0f, 1f);
  
  client.write("d(");
  client.write(str(dynamic));
  client.write(")\n");
  client.write("p(");
  client.write(str(round(pitch)));
  client.write(")\n");
  
  background(255);
  drawAxis();
  scale(width, height);
}

void mousePressed() {
  zeroGyro();
}
