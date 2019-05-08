#include<Wire.h>
const int MPU_addr = 0x68; // I2C address of the MPU-6050
int16_t GyX, GyY, GyZ;
void setup() {
  Wire.begin();
  Wire.beginTransmission(MPU_addr);
  Wire.write(0x6B);  // PWR_MGMT_1 register
  Wire.write(0);     // set to zero (wakes up the MPU-6050)
  Wire.endTransmission(true);
  Serial.begin(9600);
}
void update() {
  Wire.beginTransmission(MPU_addr);
  Wire.write(0x43);  // starting with register 0x3B (ACCEL_XOUT_H)
  Wire.endTransmission(false);
  Wire.requestFrom(MPU_addr, 6, true); // request a total of 14 registers
  GyX = (Wire.read() << 8 | Wire.read()) + 100; // 0x43 (GYRO_XOUT_H) & 0x44 (GYRO_XOUT_L)
  GyY = (Wire.read() << 8 | Wire.read()) + 11; // 0x45 (GYRO_YOUT_H) & 0x46 (GYRO_YOUT_L)
  GyZ = (Wire.read() << 8 | Wire.read()) + 92; // 0x47 (GYRO_ZOUT_H) & 0x48 (GYRO_ZOUT_L)
}

long sX = 0; long sY = 0; long sZ = 0;
void loop() {
  int N = 16;
  for (int i = 0; i < N; i ++) {
    update();
    sX += GyX;
    sY += GyY;
    sZ += GyZ;
    delay(1);
  }
  Serial.print("[" + String(sX));
  Serial.print(", " + String(sY));
  Serial.println(", " + String(sZ) + "], ");
  
//  Serial.println(sX);
}
