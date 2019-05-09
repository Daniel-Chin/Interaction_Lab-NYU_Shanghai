static final int NUM_OF_VALUES = 6;
float[] values = new float[NUM_OF_VALUES];
boolean got_nan = false;

void setup() {
  size(600, 600, P3D);
  setupSerial();
  port.readStringUntil((int) ';');
}

void draw() {
  String myString = null;
  String temp_str = "Really Impossible To Accidentally Match";
  int n_packets = 0;
  while (temp_str != null) {
    myString = temp_str;
    temp_str = port.readStringUntil((int) ';');
    n_packets ++;
  }
  if (myString.equals("Really Impossible To Accidentally Match")) {
    return;
  }

  String[] serialInArray = split(trim(myString), '\n');
  if (serialInArray.length == NUM_OF_VALUES + 1) {
    for (int i = 0; i < NUM_OF_VALUES; i ++) {
      values[i] = float(trim(serialInArray[i]));
      if (! (values[i] > -2)) {
        values[i] = 0f;
        got_nan = true;
      }
    }
  } else {
    println("it happened");
    println(serialInArray.length);
    println(serialInArray);
  }
  onUpdate(n_packets);
}

void onUpdate(int n_packets) {
  // printArray(values);
  background(0);
  pushMatrix();
  translate(width * .5, height * .5, 0);
  scale(width * .3, - height * .3, 1);
  rotateX(- PI / 2f + .1);
  strokeWeight(.1);
  
  float x1 = values[0];
  float y1 = values[1];
  float z1 = values[2];
  float x2 = values[3];
  float y2 = values[4];
  float z2 = values[5];
  
  float x3 = x1 + x2;
  float y3 = y1 + y2;
  float z3 = z1 + z2;
  
  stroke(#ffffff);  // origin
  line(0, 0, .001, .001);

  fill(#333333);
  stroke(#888888);
  beginShape();
  vertex(0, 0, 0);
  vertex(x1, y1, 0);
  vertex(x3, y3, 0);
  vertex(x2, y2, 0);
  vertex(0, 0, 0);
  endShape();
  
  fill(#777777);
  stroke(#ff8800);
  beginShape();
  vertex(0, 0, 0);
  vertex(x1, y1, z1);
  stroke(#ffffff);
  vertex(x3, y3, z3);
  vertex(x2, y2, z2);
  stroke(#0088ff);
  vertex(0, 0, 0);
  endShape();
  
  popMatrix();
  textSize(40);
  fill(255);
  if (got_nan) {
    text("NaN", 0, 0, 100, 100);
    got_nan = false;
  } else {
    text("packets dumped: " + str(n_packets - 1), 0, 0, width, 100);
    textSize(20);
    String buffer = "values: ";
    for (int i = 0; i < NUM_OF_VALUES; i ++) {
      buffer += str(values[i]) + ", ";
    }
    text(buffer, 0, 100, width, 200);
  }
}
