#define SAMPLE 20
#define MAX 70
#define MIN 49
static int RANGE = MAX - MIN + 1;

void setup() {
  Serial.begin(9600);
}

void loop() {
  int freq[RANGE] = {0};
  int reading;
  for (int i = 0; i < SAMPLE; i ++) {
    reading = analogRead(A0);
    delay(1);
    if (reading < MIN) reading = MIN;
    if (reading > MAX) reading = MAX;
    freq[reading - MIN] += 1;
  }
  int winner = -1;
  int winner_freq = -1;
  for (int i = 0; i < RANGE; i ++) {
    if (freq[i] > winner_freq) {
      winner = i;
      winner_freq = freq[i];
    }
  }
  Serial.print(float(winner) / float(RANGE));
  Serial.write(10);
  delay(100);
}
