import processing.serial.*;

static final int SELECTION_ZOOM = 3;
static final float DICT_Y = .2;
int DICT_HEIGHT;
float UNIT_WIDTH;
int FONT_SIZE;

Serial port;
static final int COM = 0;

String buffer = "";
int ascii = 100;

void setup() {
  size(1200, 550);
  
  UNIT_WIDTH = width / float(26 - 1 + SELECTION_ZOOM);
  FONT_SIZE = int(UNIT_WIDTH);
  DICT_HEIGHT = int(FONT_SIZE * SELECTION_ZOOM * 1.5);
  
  {
    int i = 0;
    for (String s : Serial.list()) {
      println(i, s);
      i ++;
    }
  }
  port = new Serial(this, Serial.list()[COM], 9600);
  surface.setTitle("Difficult Keyboard");
}

void draw() {
    readArduino();
    
    background(255);
    fill(0);
    rect(0, 0, width, DICT_Y * height);
    textAlign(CENTER, CENTER);
    fill(255);
    textSize(DICT_Y * height / 2f);
    text("Very Inconvenient Keyboard", 0, 0, width, DICT_Y * height);
    fill(0);
    
    float cursor = 0f;
    float w;
    float y;
    for (int i = (int)'a'; i <= (int)'z'; i ++) {
        if (ascii == i) {
            textSize(FONT_SIZE * SELECTION_ZOOM);
            w = UNIT_WIDTH * SELECTION_ZOOM;
            y = DICT_Y * height - DICT_HEIGHT / 2f / float(SELECTION_ZOOM);
        } else {
            textSize(FONT_SIZE);
            w = UNIT_WIDTH;
            y = DICT_Y * height;
        }
        text("" + char(i), cursor, y, w, DICT_HEIGHT);
        cursor += w;
    }
    textAlign(CENTER, CENTER);
    fill(#0000ff);
    text(buffer, 0, DICT_Y + DICT_HEIGHT, width, height - (DICT_Y + DICT_HEIGHT));
}

void readArduino() {
    while (port.available() > 0) {
        ascii = port.read();
    }
    println("ascii =", ascii);
}

void keyPressed() {
  buffer += char(ascii);
}
