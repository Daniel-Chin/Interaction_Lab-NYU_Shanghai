static final int HOW_MANY = 150;
static final int PADDING = 50;
static final int FONT_SIZE = 212;
char[] CH = new char[10];

float[] x = new float[HOW_MANY];
float[] y = new float[HOW_MANY];
float[] v_x = new float[HOW_MANY];
float[] v_y = new float[HOW_MANY];
int[] hue = new color[HOW_MANY];

float population = 1.01;
float STEP_population = - .01;

void setup() {
  size(600, 600);
  background(0);
  textFont(createFont("楷体", FONT_SIZE));
  stroke(255);
  colorMode(HSB);
  rectMode(CENTER);
  ellipseMode(CENTER);
  // textSize(36);
  for (int i = 0; i < HOW_MANY; i ++) {
    x[i] = random(width);
    y[i] = random(height);
    
    v_x[i] = int(random(2)) * 2 - 1;
    v_y[i] = int(random(2)) * 2 - 1;
    
    hue[i] = int(random(255));
  }
  loadCH();
}

void draw() {
  fill(color(0, 0, 255, 10));
  stroke(g.fillColor);
  rect(PADDING / 2, height / 2, PADDING, height);
  rect(width - PADDING / 2, height / 2, PADDING, height);
  rect(width / 2, PADDING / 2,width, PADDING);
  rect(width / 2, height - PADDING / 2, height, PADDING);
  
  translate(PADDING, PADDING);
  scale(float(width - 2 * PADDING) / width, float(height - 2 * PADDING) / height);
  stroke(0);
  if (population > 100 && STEP_population < 0) {
    echoClear("low");
  } else if (population < 1) {
    echoClear("low");
  } else {
    echoClear("mid");
  }

  float new_population = population + STEP_population;
  if (population >= 10) {
    new_population += 3 * STEP_population;
  }
  if (population >= 20) {
    new_population += 4 * STEP_population;
  }
  if (population >= 40) {
    new_population += 8 * STEP_population;
  }
  if (population >= 60) {
    new_population += 16 * STEP_population;
  }
  if (population >= 80) {
    new_population += 32 * STEP_population;
  }
  if (new_population >= HOW_MANY || new_population <= 0) {
    STEP_population = - STEP_population;
  }
  if (int(new_population) != int(population)) {
    if (int(new_population) > int(population)) {
      fill(color(hue[int(population)], 255, 255));
      stroke(g.fillColor);
      ellipse(x[int(population)], y[int(population)], 50, 50);
    } else {
      fill(255);
    }
    text(toCH(str(int(new_population))), width / 2 - .5 * FONT_SIZE * str(int(new_population)).length(), height / 2);
  }
  population = new_population;
  
  for (int i = 0; i < int(population); i ++) {
    x[i] = x[i] + v_x[i];
    y[i] = y[i] + v_y[i];
    
    fill(color(hue[i], 255, 255));
    stroke(g.fillColor);
    if (x[i] <= 0 || x[i] >= width) {
      rect(x[i] + v_x[i] * PADDING, y[i], PADDING * 2, 10);
      v_x[i] = - v_x[i];
    }
    if (y[i] <= 0 || y[i] >= height) {
      rect(x[i], y[i] + v_y[i] * PADDING, 10, PADDING * 2);
      v_y[i] = - v_y[i];
    }
    
    hue[i] = (hue[i] + 1) % 256;
    
    rect(x[i], y[i], 10, 10);
  }
}

String toCH(String num) {
  String buffer = "";
  for (int i = 0; i < num.length(); i ++) {
    buffer += CH[int(num.charAt(i)) - int('0')];
  }
  return buffer;
}

void loadCH() {
  String[] lines = loadStrings("CH.txt");
  for (int i = 0; i < 10; i ++) {
    CH[i] = lines[0].charAt(i);
  }
}
