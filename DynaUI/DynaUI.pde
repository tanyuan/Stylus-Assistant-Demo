import processing.serial.*;
import controlP5.*;
Serial myPort;  // Create object from Serial class

//---------Motor Calibration Setting-----------
PVector screen = new PVector(19.7, 14.9);   //Screen Size (cm)
PVector wsOrig = new PVector(-12.4, 20.3);  // workspace original  (cm)
float uppL = 19.3;  //Root arm  19.3
float mdL = 2.55;
float downL = 20.3;   //Fore Arm  20
byte motorNum = 4;
//---------Motor Calibration Setting END-------

int a ;
boolean isReset;
int values[] = new int[motorNum];  //for serial output data
int preValues[] = new int[motorNum];
int motorAngle[]=new int[motorNum];
int heightValues = 0;
String portName;
int[] initState = {
  512, 512, 512, 512
};
int[] initState0 = {
  512, 512, 512, 512
};
int isSwitch = 1; 

//----- GUI Parameters Setting-------
PVector orignal = new PVector(600, 750);
float cmTopx = 25;
PVector wsOrignal = new PVector(wsOrig.x*cmTopx+orignal.x, orignal.y-wsOrig.y*cmTopx);  //Rect WorkSpace
PVector wsLength = new PVector(screen.x*cmTopx, screen.y*cmTopx); 
PVector sampleInterval = new PVector(wsLength.x/8, wsLength.y/6);
int ellipseR =20;
//----- GUI Parameters Setting END-------

PVector upp = new PVector(0, 0);
PVector down = new PVector(0, 0);

// Parameters of Arm robot
float workSpaceR = (uppL+downL)*2*cmTopx;
float uppLength = uppL*cmTopx;
float downLength = downL*cmTopx;
float mdLength = mdL*cmTopx;
float rootL = sqrt(sq(uppLength)+sq(mdLength)); //root point to middle point

float[] servoAngle = new float[2];
float [] data = {
  300, 300, 512
};
float [] tanData = {
  300, 300, 512
};
int pointIdx = 0;

PrintWriter readPath;
PrintWriter writePath;
String appState = "Slider Control";
String readFileName  = "readPath";
String writeFileName = "readPath";
boolean isInputing = false;
boolean isRecording = false;
boolean isReaded = false;

void setup() {
  println(wsOrignal.x, wsOrignal.y);
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
  } 


  // Write Point
  else if (isSwitch == 3) {
    if (mousePressed) {
      IKDraw();
      values = angleMap(servoAngle, heightValues);
    }
  }



  // Replay Point
  else if (isSwitch == 4) {
    if (!isReaded) {
      readFileName = readTxtField.getText();
      data = Reading(readFileName);
      isReaded = true;
    }
    if (pointIdx<data.length-1 && pointIdx>=0) {
      servoAngle = IKControl(data[pointIdx], data[pointIdx+1], uppLength, downLength, mdLength);
      values = angleMap(servoAngle, int(data[pointIdx+2]));
    } else {
      pointIdx = 0;
    }
  }
  
  // Write Path
  else if (isSwitch == 5) {
    if (mousePressed) {
      IKDraw();
      //Prepare to sending values
      values = angleMap(servoAngle, heightValues);
      if (isRecording) {
        Recording3(readPath, upp.x, upp.y, heightValues);
      }
    }
  }
  
  
  // Replay DynaBase Path
  else if (isSwitch == 6) {
    if (!isReaded) {
      readFileName = readTxtField.getText();
      data = Reading(readFileName);
      tanData = TangentAngle(data);
      //exit();
      isReaded = true;
    }
    if (pointIdx<data.length-1 && pointIdx>=0) {
      //println("---"+pointIdx);
      servoAngle = IKControl(tanData[pointIdx], tanData[pointIdx+1], uppLength, downLength, mdLength);
      values = angleMap(servoAngle, int(tanData[pointIdx+2]));
      pointIdx = pointIdx +3;
      println("a0:"+values[0]+",a1:"+values[1]+",a2:"+values[2]);
    } else {
      pointIdx = 0;
      println("-----");
      delay(1000);
    }
  }



  // Replay DynaFrame Path
  else if (isSwitch == 7) {
    if (!isReaded) {
      readFileName = readTxtField.getText();
      data = Reading(readFileName);
      tanData = AddZDimension(data);
      isReaded = true;
    }
    if (pointIdx<data.length-1 && pointIdx>=0) {
      //println("---"+pointIdx);
      servoAngle = IKControl(tanData[pointIdx], tanData[pointIdx+1], uppLength, downLength, mdLength);
      values = angleMap(servoAngle, int(tanData[pointIdx+2]));
      pointIdx = pointIdx +3;
      println("a0:"+values[0]+",a1:"+values[1]+",a2:"+values[2]);
    } else {
      pointIdx = 0;
      println("-----");
      delay(1000);
    }
  }



  // Sending data to arduino
  if (!arrayCompare(values, preValues)) {
    sendEvent(values);
    arrayCopy(values, preValues);
    //motorAngle = readEvent();
  }
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

