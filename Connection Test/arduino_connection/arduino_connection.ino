/*
   notes
   Serial.print -> sends ascii even if number it converts it to string then to array of ascii values (15 -> "15" -> {49 53})
   Serial.write -> sends the same as u write (75 -> 75)
*/
#include <LiquidCrystal.h>
LiquidCrystal lcd(10, 9, 8, 7, 6, 5);

byte msg[4];
int val;
int count = 1;
int r = 1;
byte y_buff[4], e_buff[4];
int y;

void setup() {
  Serial.begin(9600);
  lcd.begin(16, 2);
  lcd.print("Start");
}

void loop() {

}

void test1() {
  if (Serial.available()) {
    // Serial.read(); -> reads only 1 byte
    // Serial.parseInt(); -> reads only 1 byte
    // Serial.parseFloat(); -> reads only one byte
    Serial.readBytes(msg, 3); // reads as much bytes as you want

    // concatenating the bytes to get the final value
    val = (msg[1] << 8) | (msg[0]);

    // print the recieved value on lcd to make sure its right
    lcd.clear();
    lcd.print(val);
  }
}

void test2() {
  for (; count < 101; count++) {
    if (count == 50) {
      r = -1 * r; // to create a square wave
    }
    Serial.write(r); // send the desired value

    while (!Serial.available()); // wait for data to be recieved as readbytes dont wait
    Serial.readBytes(y_buff, 3); // read data
    y = (y_buff[1] << 8) | y_buff[0]; // concat data

    // Serial.write(e); -> it only sends 1 byte
    // split data into 2 bytes
    e_buff[1] = (y & 0xFF00) >> 8;
    e_buff[0] = y & 0x00FF;
    Serial.write(e_buff, 2);
  }
}
