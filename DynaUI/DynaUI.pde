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
PVector screen = new PVector(19.7,14.9);
PVector wsOrig = new PVector(-12.4,20.3);  // workspace original  (cm)
float cmTopx = 25;
PVector wsOrignal = new PVector(wsOrig.x*cmTopx+orignal.x,orignal.y-wsOrig.y*cmTopx);  //Rect WorkSpace

PVector wsLength = new PVector(screen.x*cmTopx, screen.y*cmTopx);  
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
  println(wsOrignal.x,wsOrignal.y);
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
      //println("angle0:"+servoAngle[0],",angle1:"+servoAngle[1]);
      values = angleMap(servoAngle, heightValues);
    }
    
    
  } // Replay Point
  
  
  else if (isSwitch == 3) {
    if (!isReaded) {
      readFileName = readTxtField.getText();
      data = Reading(readFileName);
      isReaded = true;
    }
    if (pointIdx<data.length-1 && pointIdx>=0) {
      println(data[pointIdx]+" , "+data[pointIdx+1]);
      servoAngle = IKControl(data[pointIdx], data[pointIdx+1], uppLength, downLength,mdLength);
      values = angleMap(servoAngle, int(data[pointIdx+2]));
    } else {
      pointIdx = 0;
    }
  }
  // Replay Path
  else if (isSwitch == 4) {
    if (!isReaded) {
      readFileName = readTxtField.getText();
      data = Reading(readFileName);
      isReaded = true;
    }
    if (pointIdx<data.length-1 && pointIdx>=0) {
      println("---"+pointIdx);
      servoAngle = IKControl(data[pointIdx], data[pointIdx+1], uppLength, downLength,mdLength);
      values = angleMap(servoAngle, int(data[pointIdx+2]));
      pointIdx = pointIdx +3;

      printArray(values);
    } else {
      pointIdx = 0;
      delay(1000);
    }
  }

  // Write Path
  else if (isSwitch == 5) {
    if (mousePressed) {
      IKDraw();
      values = angleMap(servoAngle, heightValues);
      if (isRecording) {
        Recording3(readPath, upp.x, upp.y, heightValues);
      }
    }
  }


  // Write Point
  else if (isSwitch == 6) {
    if (mousePressed) {
      IKDraw();
    }
    values = angleMap(servoAngle, heightValues);
  }



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

