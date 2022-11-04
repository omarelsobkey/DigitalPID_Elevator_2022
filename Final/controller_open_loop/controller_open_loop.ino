int r;
int count = 1;

void setup() {
  Serial.begin(9600);
  r = 1;
}

void loop() {
  // send the desired value
  for (; count < 101; count++) {
    if (count == 50) r = -1;
    Serial.write(r);
  }
}
