final int ECHO = 20;
final int STROKE = 1;
final int RAND = 60;
final float SPEED = .1f;
final int ECHO_MODE = 2;
final int BORDER = 100;
final int BD = RAND;
final boolean NOISE = false;

void setup() {
    size(1200, 650);
}

float x = 0;
float y = 0;
int border_i = BORDER;
boolean done_border = false;
void draw() {
    if (!done_border && border_i >= 1) {
        border_i --;
        if (border_i == 0) {
            done_border = true;
            println("border done");
        }
    }
    clsWithEcho();
    stroke(0);
    int x1 = RAND * 2;
    int y1 = x1;
    int x2 = width - x1;
    int y2 = height - y1;
    for (int i = 0; i < STROKE; i ++) {
        x += SPEED; y += SPEED;
        line(x1 + myRandom(true), y1 - myRandom(true), x2 + myRandom(false), y2 - myRandom(false));
    }
}

int myRandom(boolean flag) {
    if (NOISE) {
        if (flag) {
            return int(noise(x, 0) * RAND * 2) - RAND;
        } else {
            return int(noise(0, y) * RAND * 2) - RAND;
        }
    } else {
        return int(random(-RAND, RAND));
    }
}

int echoPhase = 0;
void clsWithEcho() {
    stroke(255);
    if (ECHO_MODE == 0) {
        int times = int(height / ECHO);
        int r;
        for (int i = 0; i < times; i ++) {
            r = int(random(height));
            line(0, r, width, r);
        }
    } else if (ECHO_MODE == 1) {
        echoPhase ++;
        if (echoPhase > ECHO) {
            echoPhase = 0;
        }
        for (int i = echoPhase; i < height; i += ECHO) {
            line(0, i, width, i);
        }
    } else if (ECHO_MODE == 2) {
        int times = int(height / ECHO);
        if (done_border) {
            for (int i = 0; i < times; i ++) {
                line(BD + int(random(width - 2*BD)), BD + int(random(height - 2*BD)), BD + int(random(width - 2*BD)), BD + int(random(height - 2*BD)));
            }
        } else {
            for (int i = 0; i < times; i ++) {
                line(int(random(width)), int(random(height)), int(random(width)), int(random(height)));
            }
        }
    }
}
