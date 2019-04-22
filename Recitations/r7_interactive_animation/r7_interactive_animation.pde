final int RADIUS = 66;
final float NOISE_MAG = .1f;
final float NOISE_SPEED = .02f;

float rotation = 0f;
float V = 4;
PVector pos;
float orient;
float noise_i = 0;
int echo_i = 0;
String echo_mode = "high";
Timer t;
int counter = 5;
boolean legacy = true;
boolean legacy_phase = false;

void setup() {
  size(713, 577);
  background(#233333);
  pos = new PVector(width/2, height/2);
  orient = PI / 4f;
  t = new Timer();
  background(255);
}

void draw() {
  strokeWeight(1);
  float target_rotation = new PVector(mouseX - width/2, mouseY - height/2).heading();
  if (target_rotation - rotation > PI) {
    rotation += PI*2f;
  } else if (rotation - target_rotation > PI) {
    rotation -= PI*2f;
  }
  rotation = rotation * .99 + target_rotation * .01;
  translate(width / 2, height / 2);
  rotate(rotation);
  scale(0.5);
  noise_i += NOISE_SPEED;
  orient += (noise(noise_i) - .5f) * NOISE_MAG;
  PVector v = PVector.fromAngle(orient);
  v.mult(V);
  pos.add(v);
  if (pos.x < 0 + RADIUS || pos.x >= width - RADIUS) {
    orient = PI - orient;
    pos.x = .95 * pos.x + .05 * (width/2);
    acc();
  }
  if (pos.y < 0 + RADIUS || pos.y >= height - RADIUS) {
    orient = - orient;
    pos.y = .95 * pos.y + .05 * (width/2);
    acc();
  }
  while (orient < 0) {
    orient += 2 * PI;
  }
  while (orient > PI * 2) {
    orient -= 2 * PI;
  }
  noStroke();
  fill(255);
  ellipse(pos.x, pos.y, RADIUS * 2, RADIUS * 2);
  stroke(#233333);
  if (legacy) {
    clsWithEcho();
  } else {
    echoClear(echo_mode);
  }
  /*while (t.spin(1000)) {
   counter --;
   text(str(counter), width/2, height/2);
   }*/
  stroke(255);
  strokeWeight(10);
  noFill();
  rect(0, 0, width, height);
}

void acc() {
  counter --;
  if (counter == 0) {
    switch (echo_mode) {
    case "low":
      echo_mode = "high";
      background(255);
      V = 4;
      counter = 5;
      break;
    case "high":
      echo_mode = "low";
      background(255);
      V = 7;
      counter = 9;
      break;
    }
    if (legacy_phase) {
      legacy = ! legacy;
      legacy_phase = false;
    } else {
      legacy_phase = true;
    }
  }
  if (counter % 2 == 0) {
    fill(#3EFFB6);
  } else {
    fill(#FFC0CB);
  }
  textSize(1300 * pow(2.718, float(-counter) / 2.5f));
  text(str(counter), width/2 - 128, height * .5);
}

final int ECHO = 20;
final int ECHO_MODE = 0;
int echoPhase = 0;
void clsWithEcho() {
  if (ECHO_MODE == 0) {
    int times = int(height / ECHO);
    int r;
    for (int i = 0; i < times; i ++) {
      r = int(random(height));
      line(0, r, width, r);
    }
  } else if (ECHO_MODE == 1) {
    echoPhase ++;
    if (echoPhase > ECHO) {
      echoPhase = 0;
    }
    for (int i = echoPhase; i < height; i += ECHO) {
      line(0, i, width, i);
    }
  } else if (ECHO_MODE == 2) {
    int times = int(height / ECHO);
    for (int i = 0; i < times; i ++) {
      line(int(random(width)), int(random(height)), int(random(width)), int(random(height)));
    }
  }
}
