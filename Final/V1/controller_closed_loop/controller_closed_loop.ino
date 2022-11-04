/*
    send initial value
    loop:
      recieve feedback
      calculate the error
      send the current error
*/

#include "Variables.h"
#include "Initialize.h"
#include "PID.h"

int count = 1;

void setup() {
  Serial.begin(9600);
  PID_Init();
}

void loop() {
  for (; count < 101; count++) {
    if (count == 50) {
      r = -1 * r;
    }
    PID();
  }
}
