/* Sweep
  by BARRAGAN <http://barraganstudio.com>
  This example code is in the public domain.

  modified 8 Nov 2013
  by Scott Fitzgerald
  http://www.arduino.cc/en/Tutorial/Sweep
*/
#define MOTORNUM 4


#include <Servo.h>
#include <DynamixelSerial1.h>
int oldID = 1;
int newID = 3;
int pin = 0;

Servo myservo[MOTORNUM];  // create servo object to control a servo
int pos[MOTORNUM];
int readPos[MOTORNUM];
void setup() {
  // Inicialize the servo at 1Mbps and Pin Control 2
  Dynamixel.begin(1000000, 2);
  Serial.begin(9600);
  delay(1000);
  for (int i = 0; i < MOTORNUM; i++) {
    //myservo[i].attach(i + 2); //servo motors begin form pin2
    pos[i] = 160;
  }
  Dynamixel.setID (1, 4) ;
  //Dynamixel.reset (3) ;
}

void loop() {
  if (pin < 100) {
    Serial.print("-------:");
    Serial.println(pin);
    Serial.println( Dynamixel.ping (pin)) ;
    Serial.println( Dynamixel.ping (pin)) ;
    Serial.println( Dynamixel.ping (pin)) ;
    Serial.println( Dynamixel.ping (pin)) ;
    Serial.println( Dynamixel.ping (pin)) ;
    Serial.println( Dynamixel.ping (pin)) ;
    Serial.println( Dynamixel.ping (pin)) ;
    Serial.println( Dynamixel.ping (pin)) ;
  }
  pin = pin + 1;
  //  delay(1000);
  //  Dynamixel.move(5, 100);
  //  delay(100);
  //  Dynamixel.move(5, 200);
  //  delay(100);
  //Serial.println( Dynamixel.ping (1)) ;
  delay(1000);
  //  Dynamixel.move(2, 512);
  //  delay(1000);
  //  Dynamixel.move(2, 0);
  //  delay(1000);
  // Serial.println( Dynamixel.ping (4)) ;
  // Serial.println( Dynamixel.ping (3)) ;
  //  Serial.println( Dynamixel.ping (1)) ;
  // Dynamixel.move(1, 512);
  //  delay(5);
  //  Dynamixel.move(2, 400);
  //  delay(5);
  //  Dynamixel.move(3, 400);
  //  delay(5);
  //  Dynamixel.move(4, 400);
  //  delay(3000);
  //  Dynamixel.move(1, 1023);
  //  delay(5);
  //  Dynamixel.move(2, 450);
  //  delay(5);
  //  Dynamixel.move(3, 800);
  //  delay(5);
  //  Dynamixel.move(1, 410);
  // Dynamixel.move(4, 800);
  //delay(1000);



}
