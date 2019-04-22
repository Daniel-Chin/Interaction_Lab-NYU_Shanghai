static final float SPEED = .05;
static final float WEIGHT = .06;
float progress = 0f;

void setup() {
  size(600, 600);
  colorMode(HSB, 100);
  rectMode(CENTER);
}
void draw() {
  {  // a black border, for better WordPress display. 
    background(0, 0, 0);
    translate(30, 30);
    scale(.9, .9);
  }
  scale(width, height);
  fill(0, 0, 100);
  noStroke();
  rect(.5, .5, 1, 1);
  strokeWeight(WEIGHT);
  progress += SPEED;
  float _size = (sin(progress) + 1f) * .3 + .15;
  stroke(int(progress * 30) % 100, 100, 100);
  PVector position = new PVector(mouseX / float(width), mouseY / float(height));
  float radius = _size / 2f + WEIGHT / 2f;
  if (position.x < radius) {
    position.x = radius;
  }
  if (position.x + radius > 1f) {
    position.x = 1f - radius;
  }
  if (position.y < radius) {
    position.y = radius;
  }
  if (position.y + radius > 1f) {
    position.y = 1f - radius;
  }
  rect(position.x, position.y, _size, _size);
  strokeWeight(.03);
  line(position.x, position.y, mouseX / float(width), mouseY / float(height));
}
