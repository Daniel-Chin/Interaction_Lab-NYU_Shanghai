static final int NUM_OF_VALUES = 6;
float[] values = new float[NUM_OF_VALUES];

void setup() {
  size(500, 500);
  setupSerial();
  port.readStringUntil((int) ';');
}

void draw() {
  String myString = null;
  String temp_str = "Really Impossible To Accidentally Match";
  while (temp_str != null) {
    myString = temp_str;
    temp_str = port.readStringUntil((int) ';');
  }
  if (myString.equals("Really Impossible To Accidentally Match")) {
    return;
  }

  String[] serialInArray = split(trim(myString), '\n');
  if (serialInArray.length == NUM_OF_VALUES + 1) {
    for (int i = 0; i < NUM_OF_VALUES; i ++) {
      values[i] = float(trim(serialInArray[i]));
    }
  } else {
    println("it happened");
    println(serialInArray.length);
    println(serialInArray);
  }
  onUpdate();
}

void onUpdate() {
  printArray(values);
  background(0);
  translate(width * .5, height * .5);
  scale(width * .3, - height * .3);
  strokeWeight(.02);
  
  float x1 = values[0];
  float y1 = values[1];
  float z1 = values[2];
  float x2 = values[3];
  float y2 = values[4];
  float z2 = values[5];
  
  stroke(#ffffff);
  line(0, 0, .001, .001);
  stroke(#ff8800);
  fill(#ff0000);
  line(x1, y1, x1 + z1/2, y1 + z1/2);
  rect(x1, y1, .04, .04);
  stroke(#0088ff);
  fill(#0000ff);
  line(x2, y2, x2 + z2/2, y2 + z2/2);
  rect(x2, y2, .04, .04);
}
