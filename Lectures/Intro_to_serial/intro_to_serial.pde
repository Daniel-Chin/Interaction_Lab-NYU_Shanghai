import processing.serial.*;

int last_millis = millis();
static final int BEAT = 600;

Serial port;
static final int COM = 0;

static final int HOW_MANY = 150;
static float BASE = pow(HOW_MANY, 16f / 1024f); 
static final int PADDING = 50;
static final int FONT_SIZE = 212;
char[] CH = new char[10];

float[] x = new float[HOW_MANY];
float[] y = new float[HOW_MANY];
float[] v_x = new float[HOW_MANY];
float[] v_y = new float[HOW_MANY];
int[] hue = new color[HOW_MANY];

int population = 0;

void setup() {
  size(600, 600);
  {
    int i = 0;
    for (String s : Serial.list()) {
      println(i, s);
      i ++;
    }
  }
  port = new Serial(this, Serial.list()[COM], 9600);
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
  int delta = millis() - last_millis;
  if (delta > BEAT) {
    last_millis += delta;
  }
  float propo = delta / 2000f;
  pushMatrix();
  translate(propo / 2f * width, propo / 2f * height);
  scale(1f - propo);

  fill(color(0, 0, 255, 10));
  stroke(g.fillColor);
  rect(PADDING / 2, height / 2, PADDING, height);
  rect(width - PADDING / 2, height / 2, PADDING, height);
  rect(width / 2, PADDING / 2,width, PADDING);
  rect(width / 2, height - PADDING / 2, height, PADDING);
  translate(PADDING, PADDING);
  scale(float(width - 2 * PADDING) / width, float(height - 2 * PADDING) / height);

  updatePopulation();
  
  stroke(0);
  if (population > 100) {
    echoClear("low");
  } else if (population < 1) {
    echoClear("low");
  } else {
    echoClear("mid");
  }
  popMatrix();
  translate(PADDING, PADDING);
  scale(float(width - 2 * PADDING) / width, float(height - 2 * PADDING) / height);

  for (int i = 0; i < int(population); i ++) {
    x[i] = x[i] + v_x[i];
    y[i] = y[i] + v_y[i];
    
    fill(color(hue[i], 255, 150));
    stroke(g.fillColor);
    if (x[i] <= 0 || x[i] >= width) {
      rect(x[i] + v_x[i] * PADDING, y[i], PADDING * 2, 10);
      v_x[i] = - v_x[i];
    }
    if (y[i] <= 0 || y[i] >= height) {
      rect(x[i], y[i] + v_y[i] * PADDING, 10, PADDING * 2);
      v_y[i] = - v_y[i];
    }
    
    fill(color(hue[i], 255, 255));
    stroke(g.fillColor);
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

int to_discard = 0;
int readArduino() {
  int result = -1;
  String buffer;
  boolean good = true;
  for (int i = 0; i < to_discard; i ++) {
    port.read();
  }
  to_discard = 0;
  while (port.available() > 0) {
    buffer = "";
    for (int i = 0; i < 4; i ++) {
      if (port.available() == 0) {
        to_discard = 4 - i;
        good = false;
        break;
      }
      buffer += port.readChar();
    }
    if (good) result = int(buffer);
  }
  return result;
}

void updatePopulation() {
  int value = readArduino();
  if (value == -1) return;
  int new_population = int(pow(BASE, value / 16f)) - 1;
  new_population = max(min(new_population, HOW_MANY), 0);
  println(new_population);
  if (int(new_population) != int(population)) {
    if (int(new_population) > int(population)) {
      fill(color(hue[int(population)], 255, 255));
      stroke(g.fillColor);
      ellipse(x[int(population)], y[int(population)], 100, 100);
    } else {
      fill(255);
    }
    text(toCH(str(int(new_population))), width / 2 - .5 * FONT_SIZE * str(int(new_population)).length(), height / 2);
  }
  population = new_population;  
}

void mousePressed() {
  last_millis = millis();
}
