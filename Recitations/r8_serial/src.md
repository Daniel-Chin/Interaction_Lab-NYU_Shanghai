Instructor: <b>Marcele</b>  

This is a write up for Interaction Lab SP18 [Recitation on Processing Animation](https://wp.nyu.edu/shanghai-ima-interaction-lab/recitation-7-processing-animation/) on Apr 12, 2019.  

[video width="272" height="272" mp4="https://wp.nyu.edu/shanghai-ima-documentation/wp-content/uploads/sites/13761/2019/04/hw_demo.mp4"][/video]  
[video width="272" height="272" mp4="https://wp.nyu.edu/shanghai-ima-documentation/wp-content/uploads/sites/13761/2019/04/r7_demo.mp4"][/video]  

## What I learnt
I learnt how to work with the [PVector class](https://processing.org/reference/PVector.html). It was really convenient for what I was trying to do.  

## Interesting thing
From line 64 to line 73 of InkLeak.pde, I used Linear Algebra to smartly orient the special effect. It was such an enjoyable moment when I pieced together my half-unsure Math knowledge from high school, and see my program correctly automated.  
```
class Node {
  // mode code omitted
  public void orientWith(Node that) {
    PVector perpendi = new PVector(this.y - that.y, that.x - this.x);
    if (
      PVector.fromAngle(this.angle).dot(perpendi)
      * PVector.fromAngle(that.angle).dot(perpendi)
      < 0
    ) {
      this.angle += PI;
    }
  }
}
```

Yet another proof of the famous saying, "Math is power". 

## Source Code
### Homework
```
static final float SPEED = .05;
static final float WEIGHT = .06;
float progress = 0f;

void setup() {
  size(600, 600);
  colorMode(HSB, 100);
  rectMode(CENTER);
}
void draw() {
  strokeWeight(WEIGHT);
  scale(width, height);
  background(0, 0, 100);
  progress += SPEED;
  float _size = (sin(progress) + 1f) * .3 + .15;
  stroke(int(progress * 30) % 100, 100, 100);
  PVector position = new PVector(mouseX / float(width), mouseY / float(height));
  float radius = _size / 2f + WEIGHT / 2f;
  if (position.x < radius) {
    position.x = radius;
  }
  if (position.x + radius > 1f) {
    position.x = 1f - radius;
  }
  if (position.y < radius) {
    position.y = radius;
  }
  if (position.y + radius > 1f) {
    position.y = 1f - radius;
  }
  rect(position.x, position.y, _size, _size);
  strokeWeight(.03);
  line(position.x, position.y, mouseX / float(width), mouseY / float(height));
}
```

### Recitation creation
I used two sketch files.  
<b>InkLeak.pde</b> is a library I wrote for an eariler lecture, see my [Github](https://github.com/Daniel-Chin/Processing/blob/master/InkLeakLib/InkLeak.pde).  
<b>r7_interactive_animation.pde</b> is the main code. The content is here:  
```
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
```
