static final int N = 7;
static final int DELAY = 3000;
PImage[] img;

void setup() {
  size(600, 600);
  img = new PImage[N];
  for (int i = 0; i < N; i ++) {
    img[i] = loadImage('d' + str(i) + ".jpg");
  }
  background(#0000ff);
  delay(DELAY);
}
void draw() {
  int i = min((millis() - DELAY) / 1000, N - 1);
  tint(255, 4);
  translate(width / 2, height / 2);
  rotate(millis() * .00001 * pow(1.1, (millis() - DELAY - 1000) * .002));
  translate(- width / 2, - height / 2);
  image(img[i], 0, 0, width, height);
  /*
  switch (millis() / 1000) {
  case 0:
    tint(255, 1);
    image(img[0], 0, 0, width, height);
    break;
  }*/
}

/*int s = 0;
 PImage bigImage;
 
 void setup() {
 size(600,600);
 bigImage = requestImage("Relax.jpg");
 }
 
 void draw() {
 if (bigImage.width == 0) {
 background(#0000ff);
 } else if (bigImage.width == -1) {
 // This means an error occurred during image loading
 background(#ff0000);
 } else {
 // Image is ready to go, draw it
 int N = 3;
 int w = width / N;
 int h = height / N;
 textSize(30);
 fill(0);
 for (int i = 0; i < sq(N); i ++) {
 tint(255,i + 1);
 image(bigImage, (i % N) * w, (i / N) * h, w, h);
 text(str(i),(i % N) * w, (i / N) * h, w, h);
 }
 s++;
 println(s);
 }
 }
/*
 import processing.video.*;
 Movie myMovie;
 
 void setup() {
 size(480, 480);
 myMovie = new Movie(this, "demo.mp4");
 myMovie.play();
 }
 void draw() {
 if (myMovie.available()) {
 myMovie.read();
 }
 image(myMovie, 0, 0);
 delay(1000);
 }
 */
/*

 PImage bigImage;
 
 void setup() {
 size(600,600);
 bigImage = requestImage("https://images-cf.mheducation.com/connect/prod/paamweb/us-east-1a/v1694/img/mhe-connect-logo.png");
 }
 
 void draw() {
 if (bigImage.width == 0) {
 background(#0000ff);
 } else if (bigImage.width == -1) {
 // This means an error occurred during image loading
 background(#ff0000);
 } else {
 // Image is ready to go, draw it
 background(255);
 image(bigImage, 0, 0, width,height);
 }
 }
 */
