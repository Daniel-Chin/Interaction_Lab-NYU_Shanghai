import processing.video.*;

Capture cam;

void setup() {
  size(1300, 600);
  cam = new Capture(this);
  cam.start();
}

void draw() {
  if (cam.available()) {
    translate(width, 0);
    scale(-1, 1);
    cam.read();
  }
  int X = 40;
  for (int i = 0; i < 5; i ++) {
    image(cam, X * i, X * i, width - X * i*2, height - X * i*2);
  }
}
