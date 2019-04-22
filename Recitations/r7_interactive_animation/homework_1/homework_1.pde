static final float SPEED = .05;
float progress = 0f;

void setup() {
  size(600, 600);
}
void draw() {
  scale(width, height);
  background(255);
  strokeWeight(.05);
  progress += SPEED;
  float _size = (sin(progress) + 1f) * .3 + .1;
  rectMode(CENTER);
  rect(.5, .5, _size, _size);
}
