void PID(void) {
  Serial.write(r);

  // read the final value calculated at matlab
  while(!Serial.available());
  Serial.readBytes(y_buff, 3);
  y = (y_buff[1] << 8) | y_buff[0];

  // calculate the error (difference between output and desired output)
  e = r * 100 - y;

  e_buff[1] = (e & 0xFF00) >> 8;
  e_buff[0] = e & 0x00FF;

  // send the error signal to matlab to calculate the new calculated final value depending on the current error
  Serial.write(e_buff, 2);
}
