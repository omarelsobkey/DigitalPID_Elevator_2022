void PID_Init(void) {
  //  r = analogRead(A0); // read the desired value
  //  Serial.write(r); // send inital value to get the first y that will allow you to calculate the error signal

  n = 100; // number of samples

  r = 1; // set the desired value

  u_1 = 0;
  u_2 = 0;
  u_3 = 0;

  e_1 = 0;
  e_2 = 0;
  e_3 = 0;
}
