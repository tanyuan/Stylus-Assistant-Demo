import processing.serial.*;
import controlP5.*;
Serial myPort;  // Create object from Serial class
byte motorNum = 4;
int a ;
boolean isReset;
int values[] = new int[motorNum];  //for serial output data
int preValues[] = new int[motorNum];
int motorAngle[]=new int[motorNum];
int heightValues = 512;
String portName;
int[] initState = {
  512, 512, 512, 512
};
int[] initState0 = {
  512, 512, 512, 512
};

int isSwitch = 1; 

PVector orignal = new PVector(600, 750);
float cmTopx = 30;
PVector wsOrignal = new PVector(50, 250);  //Rect WorkSpace
PVector wsLength = new PVector(20*cmTopx, 15*cmTopx);  //iPad Weight 20; Height 15;
int ellipseR =20;
PVector upp = new PVector(0, 0);
PVector down = new PVector(0, 0);

// Parameters of Arm robot
float uppL = 20;
float mdL = 2.2;
float downL = 19.3;
float workSpaceR = (uppL+downL)*2*cmTopx;
float uppLength = uppL*cmTopx;
float downLength = downL*cmTopx;
float mdLength = mdL*cmTopx;

float[] servoAngle = new float[2];
float [] data = {
  300, 300, 512
};
int pointIdx = 0;

PrintWriter readPath;
PrintWriter writePath;
String appState = "Slider Control";
String readFileName  = "readPath";
String writeFileName = "writePath";
boolean isInputing = false;
boolean isRecording = false;
boolean isReaded = false;

void setup() {
  portName = Serial.list()[3]; //change the 0 to a 1 or 2 etc. to match your port
  myPort = new Serial(this, portName, 9600);
  delay(1000);
  Gui();
}

void draw() {
  GuiScript(); // get and set Slider Value
  refresh();
  //====SLIDER control=====
  if (isSwitch == 1) {
    for (int i = 0; i<motorNum; i++) {
      values[i] = int(sliValue[i]);
      //println(isSwitch);
    }
    //println("valuse[0] is "+values[0]);
  }// IK Control
  else if (isSwitch == 2) {
    if (mousePressed) {
      IKDraw();
    }
    values = angleMap(servoAngle, heightValues);
  } // Replay Point
  



  if (!arrayCompare(values, preValues)) {
    sendEvent(values);
    arrayCopy(values, preValues);
  }
  motorAngle = readEvent();
}


public boolean arrayCompare(int[] a1, int[] a2) {
  if (a1==null || a2==null) return false;
  if (a1.length != a2.length) return false;
  for (int i=0; i<a1.length; i++) {
    if (a1[i] != a2[i])
      return false;
  }
  return true;
}

void initSnake() {
  sendEvent(initState0);
  flowIK(initState0);
}

