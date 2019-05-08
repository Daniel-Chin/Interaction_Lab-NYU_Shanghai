import processing.sound.*;
Amplitude amp;
SoundFile f;
AudioIn mic;

void setup() {
  size(500,500);
  //f = new SoundFile(this, "1.mp3");
  //f.loop();
  mic = new AudioIn(this, 0);
  mic.start();
  amp = new Amplitude(this);
  amp.input(mic);
}
void draw() {
  float t = amp.analyze() * 2;
  println(t);
  //background(0);
  noStroke();
  fill(255 * t);
  rect(height * (.5 - t / 2f), height * (.5 - t / 2f), width*t, height * t);
}
