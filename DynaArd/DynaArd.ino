/**
   For Dynamixel Control
   by andy, 2016
   Library:
  http://austinlpalmer.com/Projects/Documentr/#/home

*/
#define MOTORNUM 4


#include <DynamixelSerial1.h>

int pos[MOTORNUM];
int prePos[MOTORNUM];
int readPos[MOTORNUM];
//From root to end,protect motor from damage
int motorRange[MOTORNUM][2]  = {
  {100, 900},
  {230, 600},
  {0,1023},
  {0,1023},
  //{500,600},
  //{600,800},
  //{400, 768},
  //{300,550},
};



void setup() {
  // Inicialize the servo at 1Mbps and Pin Control 2
  Dynamixel.begin(1000000, 2);
  Serial.begin(9600);
  delay(1000);
  for (int i = 0; i < MOTORNUM; i++) {
    pos[i] = 512;
    Dynamixel.moveSpeed(i + 1, pos[i], 200);
  }

}

void loop() {
  readEvent(pos);

  if (!arrayCompare(pos, prePos)) {
    //sendEvent(readPos);
    arrayCopy(pos, prePos);
  }

  //  Dynamixel.moveSpeed(1, angleProtect(0, pos[0]), 200);
  Dynamixel.moveSpeed(1, angleProtect(0, angleProtect(0, pos[0])),100);
  Dynamixel.moveSpeed(2, angleProtect(1, angleProtect(1, pos[1])),100);
  Dynamixel.moveSpeed(3, angleProtect(2, angleProtect(2, pos[2])),200);
  Dynamixel.moveSpeed(4, angleProtect(3, angleProtect(3, 1020-pos[2])),200);

//    readPos[0] = Dynamixel.readPosition(1);
//    readPos[1] = Dynamixel.readPosition(2);
//   readPos[2] = Dynamixel.readPosition(3);
//      readPos[3] =Dynamixel.readPosition(4);
}


int angleProtect(int id, int angle) {
  if (angle < motorRange[id][0]) {
    angle = motorRange[id][0];
  } else if (angle > motorRange[id][1]) {
    angle = motorRange[id][1];
  }
  return angle;
}


boolean arrayCompare(int a1[MOTORNUM] , int a2[MOTORNUM] ) {
  for (int i = 0; i < MOTORNUM; i++) {
    if (a1[i] != a2[i])
      return false;
  }
  return true;
}

void arrayCopy(int a1[MOTORNUM] , int a2[MOTORNUM]) {
  for (int i = 0; i < MOTORNUM; i++) {
    a2[i] = a1[i];
  }
}
