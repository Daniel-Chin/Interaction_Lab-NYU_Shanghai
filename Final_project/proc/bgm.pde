import processing.sound.*;

Bgm bgm;

class Bgm {
  static final float START = .137;
  static final float SECOND_PER_CHORD = 3.2; // 1.60025;
  static final float END = 396;

  SoundFile file;
  long when_started;

  Bgm(PApplet p) {
    file = new SoundFile(p, "back.mp3");
  }

  void play() {
    file.jump(START);
    when_started = millis();
  }

  void stop() {
    file.pause();
  }

  static String[] CHORD_PROGRESSION = {"Am", "F", "C", "G"};
  String update() {
    float time = (millis() - when_started) * .001;
    if (time > END) {
      play();
      return update();
    }
    int chord_i = int(time / SECOND_PER_CHORD) % 4;
    return CHORD_PROGRESSION[chord_i];
  }
}
