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

static final float AXIS_RATIO = .2;
static final float AXIS_VERTICAL_PADDING = .2;
void drawAxis() {
  fill(0);
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
  line(AXIS_MID, TOP, AXIS_MID, BOTTOM);
}

static final float PIANO_RATIO = .5;
static final float PIANO_VERTICAL_PADDING = 0f;
static final float PIANO_BLACK_RATIO = .65;
void drawPianoAndArrow() {
  pushMatrix();
  translate(PIANO_RATIO, PIANO_VERTICAL_PADDING);
  scale(1f - AXIS_RATIO - PIANO_RATIO, 1f - 2 * PIANO_VERTICAL_PADDING);
  
  int n_keys = MAX_PITCH - MIN_PITCH + 1;
  float key_height = 1f / n_keys;
  stroke(0);
  strokeWeight(2);
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
      if (remainder % 2 == 0) {
        black_or_white = true;
      }
    }
    
    // draw the rect
    fill(black_or_white ? 0 : 255);
    key_top = key_height * (MAX_PITCH - i);
    rect(0, key_top, PIANO_BLACK_RATIO, key_height);
    
    // draw the line
    if (black_or_white) {
      key_mid = key_top + key_height * .5;
      line(PIANO_BLACK_RATIO, key_mid, 1f, key_mid);
    } else if (remainder == 11 || remainder == 4) {
      line(PIANO_BLACK_RATIO, key_top, 1f, key_top);
    }
  }
  
  
  popMatrix();
}
