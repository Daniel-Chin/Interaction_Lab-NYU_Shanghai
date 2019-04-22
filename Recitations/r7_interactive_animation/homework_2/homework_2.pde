static final float SPEED = .05;
float progress = 0f;

void setup() {
  size(600, 600);
  colorMode(HSB, 100);
  rectMode(CENTER);
  strokeWeight(.05);
}
void draw() {
  scale(width, height);
  background(0, 0, 100);
  progress += SPEED;
  float _size = (sin(progress) + 1f) * .3 + .1;
  stroke(int(progress * 30) % 100, 100, 100);
  rect(.5, .5, _size, _size);
}
