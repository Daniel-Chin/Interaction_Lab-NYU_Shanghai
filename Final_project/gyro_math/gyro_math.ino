#include<Wire.h>

#define MPU_ADDR 0x68 // I2C address of the MPU-6050
#define RADIENT_PER_MILLIS 0.00000013333333333

int16_t GyX, GyY, GyZ;

long last_read_when;

double x1 = 1, y1 = 0, z1 = 0;
double x2 = 0, y2 = 1, z2 = 0;

void setup() {
  Wire.begin();
  Wire.beginTransmission(MPU_ADDR);
  Wire.write(0x6B);  // PWR_MGMT_1 register
  Wire.write(0);     // set to zero (wakes up the MPU-6050)
  Wire.endTransmission(true);
  Serial.begin(9600);
  last_read_when = millis();
}

void readSensor() {
  Wire.beginTransmission(MPU_ADDR);
  Wire.write(0x43);  // starting with register 0x43
  Wire.endTransmission(false);
  Wire.requestFrom(MPU_ADDR, 6, true); // request a total of 6 registers
  GyX = (Wire.read() << 8 | Wire.read()) + 111; // 0x43 (GYRO_XOUT_H) & 0x44 (GYRO_XOUT_L)
  GyY = (Wire.read() << 8 | Wire.read()) + 15; // 0x45 (GYRO_YOUT_H) & 0x46 (GYRO_YOUT_L)
  GyZ = (Wire.read() << 8 | Wire.read()) + 108; // 0x47 (GYRO_ZOUT_H) & 0x48 (GYRO_ZOUT_L)
}

void update() {
  readSensor();
  int delta_time = millis() - last_read_when;
  last_read_when += delta_time;
  double ratio = RADIENT_PER_MILLIS * delta_time;
  
  handleX(&x1, &y1, &z1, &x2, &y2, &z2, GyX * ratio);
  handleX(&x2, &y2, &z2, &x1, &y1, &z1, GyY * ratio);
  
  // handle Z
  double delta_z = GyZ * ratio;
  double cos_z = cos(delta_z);
  double sin_z = sin(delta_z);
  
  double x1_ = x1 * cos_z + x2 * sin_z;
  double y1_ = y1 * cos_z + y2 * sin_z;
  double z1_ = z1 * cos_z + z2 * sin_z;
  double x2_ = - x1 * sin_z + x2 * cos_z;
  double y2_ = - y1 * sin_z + y2 * cos_z;
  double z2_ = - z1 * sin_z + z2 * cos_z;
  
  x1 = x1_;
  y1 = y1_;
  z1 = z1_;
  x2 = x2_;
  y2 = y2_;
  z2 = z2_;
}

void handleX(
  double *_x1, double *_y1, double *_z1, 
  double *_x2, double *_y2, double *_z2, float delta_x
) {
  // Base Vectors
  double xsq_plus_ysq = sq(*_x1) + sq(*_y1);
  double ysq_plus_zsq = sq(*_y1) + sq(*_z1);
  double v_multiplier, w_multiplier, vx, vy, vz, wx, wy, wz;
  if (xsq_plus_ysq > ysq_plus_zsq) {  // Choose the proper base veectors to avoid 0 / 0
    v_multiplier = 1 / sqrt(xsq_plus_ysq);
    w_multiplier = 1 / sqrt(
      sq(*_z1) * xsq_plus_ysq + sq(xsq_plus_ysq)
    );
    vx = *_y1 * v_multiplier;
    vy = - *_x1 * v_multiplier;
    vz = 0;
    wx = *_x1 * *_z1 * w_multiplier;
    wy = *_y1 * *_z1 * w_multiplier;
    wz = - xsq_plus_ysq * w_multiplier;
  } else {
    v_multiplier = 1 / sqrt(ysq_plus_zsq);
    w_multiplier = 1 / sqrt(
      sq(*_x1) * ysq_plus_zsq + sq(ysq_plus_zsq)
    );
    vx = 0;
    vy = *_z1 * v_multiplier;;
    vz = - *_y1 * v_multiplier;
    wx = - ysq_plus_zsq * w_multiplier;
    wy = *_x1 * *_y1 * w_multiplier;
    wz = *_x1 * *_z1 * w_multiplier;
  }
  
  // Base change
  double v2 = vx * *_x2 + vy * *_y2 + vz * *_z2;
  double w2 = wx * *_x2 + wy * *_y2 + wz * *_z2;
  // Serial.print("v2 ");
  // Serial.println(v2);
  // Serial.print("w2 ");
  // Serial.println(w2);
  
  // vector to angle
  double angle = acos(v2);
  if (isnan(angle)) {
    if (v2 >= 1) {
      angle = 0;
    } else {
      angle = PI;
    }
  }
  if (w2 < 0) {
    angle = - angle;
  }
  // Serial.print("angle ");
  // Serial.println(angle);
  
  // rotate
  angle += delta_x;
  // Serial.print("delta_x ");
  // Serial.println(delta_x * 5000000);
  // Serial.print("angle ");
  // Serial.println(angle);
  
  // angle to vector
  double v2_ = cos(angle);
  double w2_ = sin(angle);
  // Serial.print("v2_ ");
  // Serial.println(v2_);
  // Serial.print("w2_ ");
  // Serial.println(w2_);
  
  // change base back
  *_x2 = vx * v2_ + wx * w2_;
  *_y2 = vy * v2_ + wy * w2_;
  *_z2 = vz * v2_ + wz * w2_;
}

void loop() {
  long sec = millis();
  // long mil, taken;
  while (millis() - sec < 60) {
    // mil = millis();
    update();
    // taken = millis() - mil;
    // Serial.print("one calc takes ms: ");
    // Serial.println(taken);
    delay(1);
  }
  Serial.println(x1);
  Serial.println(y1);
  Serial.println(z1);
  Serial.println(x2);
  Serial.println(y2);
  Serial.println(z2);
  Serial.println(";");
  delay(1);
}
