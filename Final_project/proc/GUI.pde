void drawTristan() {
  background(255);
  fill(0); 
  rectMode(CENTER);
  rect(width/4, height/2, 20, 800);
  strokeWeight(3);
  line(width/8, 200, width/8, 800);
  //noStroke();
  beginShape(); //"Triangle near "HIGH"
  vertex(75, 200);
  vertex(60, 230);
  vertex(90, 230);
  vertex(75, 200);
  endShape();
  fill(255);
  beginShape();
  vertex(200, 600);
  vertex(400, 597);
  vertex(400, 603);
  vertex(200, 600);
  endShape();
  fill(0);
  textSize(32);
  text("HIGH", width/16, 125); 
  text("LOW", width/16, 900); 
}

void drawDebug(float pitch, float dynamic) {
  background(#ff00ff);
  fill(0);
  textSize(30);
  text("pitch " + str(pitch), 0, 0, width, 100);
  text("dynamic " + str(dynamic), 0, 100, width, 200);
  text("n_packets " + str(n_packets), 0, 200, width, 300);
}

static final float AXIS_RATIO = .3;
static final float AXIS_VERTICAL_PADDING = .2;
void drawAxis() {
  fill(0);
  stroke(0);
  textSize(48);
  textAlign(CENTER, CENTER);
  float AXIS_WIDTH = width * AXIS_RATIO;
  float AXIS_LEFT = width - AXIS_WIDTH;
  float AXIS_MID = width - AXIS_WIDTH / 2;
  float ARROW_SIZE = height * .02;
  float TOP = height * AXIS_VERTICAL_PADDING;
  float BOTTOM = height * (1f - AXIS_VERTICAL_PADDING);
  float TEXT_HEIGHT = g.textSize * 2;
  
  text("HIGH", AXIS_LEFT, TOP - TEXT_HEIGHT, AXIS_WIDTH, TEXT_HEIGHT);
  text("LOW", AXIS_LEFT, BOTTOM, AXIS_WIDTH, TEXT_HEIGHT);
  
  beginShape(); // HIGH arrow
  vertex(AXIS_MID, TOP);
  vertex(AXIS_MID - ARROW_SIZE, TOP + ARROW_SIZE * 2);
  vertex(AXIS_MID + ARROW_SIZE, TOP + ARROW_SIZE * 2);
  vertex(AXIS_MID, TOP);
  endShape();

  beginShape(); // LOW arrow
  vertex(AXIS_MID, BOTTOM);
  vertex(AXIS_MID - ARROW_SIZE, BOTTOM - ARROW_SIZE * 2);
  vertex(AXIS_MID + ARROW_SIZE, BOTTOM - ARROW_SIZE * 2);
  vertex(AXIS_MID, BOTTOM);
  endShape();
  
  strokeWeight(4);
  line(AXIS_MID, TOP + ARROW_SIZE, AXIS_MID, BOTTOM - ARROW_SIZE);
}

static final float PIANO_RATIO = .4;
static final float PIANO_VERTICAL_PADDING = .07;
static final float PIANO_BLACK_RATIO = .65;
static final float POINTER_PADDING = .1;
static final float POINTER_RATIO = -.6;
float previous_pitch = 60;
int commitment = 0;
void drawPianoAndArrow(float pitch, float dynamic) {
  if (DEBUG_NO_ARDUINO) {
    pitch = map(mouseY, PIANO_VERTICAL_PADDING * height, (1 - PIANO_VERTICAL_PADDING) * height, MAX_PITCH, MIN_PITCH);
  }
  float saved_pitch = pitch;
  if (abs(pitch - previous_pitch) > 1f) {
    if (commitment < 3) {
      commitment ++;
      pitch = previous_pitch;
    } else {
      previous_pitch = pitch;
    }
  } else {
    commitment = 0;
    previous_pitch = pitch;
  }

  pushMatrix();
  translate(PIANO_RATIO, PIANO_VERTICAL_PADDING);
  scale(1f - AXIS_RATIO - PIANO_RATIO, 1f - 2 * PIANO_VERTICAL_PADDING);
  strokeWeight(.01);
  
  int n_keys = MAX_PITCH - MIN_PITCH + 1;
  float key_height = 1f / n_keys;
  int remainder;
  boolean black_or_white;
  float key_mid;
  float key_top;
  for (int i = MIN_PITCH; i <= MAX_PITCH; i ++) {
    remainder = i % 12;
    black_or_white = false;
    if (remainder < 5) {
      if (remainder % 2 == 1) {
        black_or_white = true;
      }
    } else {
        black_or_white = true;
      }
    }
    
    // draw the rect
    if (round(pitch) == i) {
      fill(black_or_white ? 100 : 200);
    } else {
      fill(black_or_white ? 0 : 255);
    }
    key_top = key_height * (MAX_PITCH - i);
    stroke(0);
    rect(0, key_top, PIANO_BLACK_RATIO, key_height);
    if (! black_or_white) {
      noStroke();
      rect(0, key_top, PIANO_BLACK_RATIO + g.strokeWeight * 4, key_height - g.strokeWeight);
    }

    // draw the line
    stroke(0);
    if (black_or_white) {
      key_mid = key_top + key_height * .5;
      line(PIANO_BLACK_RATIO, key_mid, 1f, key_mid);
    } else if (remainder == 11 || remainder == 4) {
      line(PIANO_BLACK_RATIO, key_top, 1f, key_top);
    }
  }
  line(0, 0, 1, 0);
  line(0, 1, 1, 1);
  line(0, 0, 0, 1);
  line(1, 0, 1, 1);
  
  translate(- POINTER_PADDING, 0);
  scale(- POINTER_RATIO, 1f);
  fill(255 * dynamic);
  float pointer_y = map(pitch, MIN_PITCH, MAX_PITCH, 1 - key_height / 2, key_height / 2);
  beginShape();
  vertex(0, pointer_y);
  vertex(- 1, pointer_y + .05);
  vertex(- 1, pointer_y - .05);
  vertex(0, pointer_y);
  endShape();

  popMatrix();
}

float b1x = .05;
float b1y = .1;
float b1w = .3;
float b1h = .1;
float b2x = .05;
float b2y = .3;
float b2w = .3;
float b2h = .1;
void drawButtons() {
  fill(255);
  stroke(0);
  strokeWeight(5);
  rect(b1x * width, b1y * height, b1w * width, b1h * height, 10);
  rect(b2x * width, b2y * height, b2w * width, b2h * height, 10);
  fill(0);
  textSize(20);
  text("calibrate", b1x * width, b1y * height, b1w * width, b1h * height);
  text("expert mode: " + (is_expert ? "on" : "off"), b2x * width, b2y * height, b2w * width, b2h * height);
}
void mousePressed() {
  float x = mouseX / float(width);
  float y = mouseY / float(height);
  if (
    b1x < x && x < b1x + b1w
  &&
    b1y < y && y < b1y + b1h
  ) {
    zeroGyro();
  }
  if (
    b2x < x && x < b2x + b2w
  &&
    b2y < y && y < b2y + b2h
  ) {
    is_expert = ! is_expert;
  }
}
