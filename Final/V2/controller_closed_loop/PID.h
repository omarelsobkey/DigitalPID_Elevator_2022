void PID(void) {
  Serial.write(r);

  delay(0.01);
  u = (5.3859 * e_1 + 3.9686 * e_2 + 3.1182 * e_3 - u_1 + u_2 + u_3);
  u_buff[1] = (u & 0xFF00) >> 8;
  u_buff[0] = u & 0x00FF;
  // send the error signal to matlab to calculate the new calculated final value depending on the current error
  Serial.write(u_buff, 2);

  // read the final value calculated at matlab
  while (!Serial.available());
  Serial.readBytes(y_buff, 3);
  y = (y_buff[1] << 8) | y_buff[0];

  // calculate the error (difference between output and desired output)
  e = r * 100 - y;

  e_3 = e_2;
  e_2 = e_1;
  e_1 = e;

  u_3 = u_2;
  u_2 = u_1;
  u_1 = u;
}
