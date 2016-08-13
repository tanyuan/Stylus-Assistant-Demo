/**
 * For GUI weidges script control
 * by andy, 2015
 * Library:
 * https://processing.org/reference/libraries/serial/
 */



float[] sliValue = new float[motorNum]; // the value of slider from UI
void GuiScript() {
  //get the value of sliders
  for (int i = 0; i<motorNum; i++) {
    sliValue[i] = cp5.getController("Motor"+str(i+1)).getValue();
  }
  text(values[0], 400, 20);
  //   isReset = cp5.getController("Reset").isPressed();

  txtLableState.setText(appState+shortCutHint);
  if (recordTxtField.isFocus()||readTxtField.isFocus()) {
    isInputing = true;
  } else {
    isInputing = false;
  }
}

void refresh() {
  background(255);
  fill(black);
  noStroke();
  ellipse(orignal.x, orignal.y, ellipseR, ellipseR);
  stroke(2);
  noFill();
  //ellipse(center.x, center.y, workSpaceR, workSpaceR );
  stroke(2);
  noFill();
  rect(wsOrignal.x, wsOrignal.y, wsLength.x, wsLength.y);
  //sample point 
  fill(black);
 // println("------");
  //mouseX-orignal.x, orignal.y-mouseY
  for (int i = 0; i<4; i++) {
    for (int j = 0; j<3; j++) {
      float pointX = wsOrignal.x+sampleInterval.x*(1+2*i);
      float pointY =  wsOrignal.y+sampleInterval.y*(1+2*j);
      ellipse(pointX, pointY, ellipseR/2, ellipseR/2);
      //println("x :"+(pointX-orignal.x)+",y:"+(orignal.y-pointY));
    }
  }
}

//======ShortCut Function
void keyReleased() {
  //Swich Silder and IK Control

  if (!isInputing) {
    if (key == '1') {    
      isSwitch = 1;
      appState = "Slider Control";
      initSnake();
    } 
    if (key == '2') {
      isSwitch = 2;
      appState= "IK Control";
      //initSnake();
    }
//------Point Record Control---------------
    if (key == '3') {
      isSwitch = 3;
      isReaded = false;
      appState= "Point Record Control";
      shortCutHint= "(Press 'w' to new file)";
      //initSnake();
    }
    
    // Record Point
    if (isSwitch == 3) {
      if (key=='w'|| key =='W') {
        writeFileName = recordTxtField.getText();
        readPath = createWriter(writeFileName+".txt");
        appState =appState + " : New TxtFile is "+writeFileName+".txt";
        shortCutHint= "(Press 'n' to record point; Press 's' to save file)";
        println("=====New File=====");
      }
      if (key == 'n' || key == 'N') {
        pointIdx = pointIdx +3;
        Recording3(readPath, upp.x, upp.y, heightValues);
        println("new point");
      }

      if (key =='S'|| key =='s') {
        isRecording = false;
        readPath.flush();  // Writes the remaining data to the file
        readPath.close();  // Finishes2 the file
        appState = "Path Record Control: " +writeFileName+".txt saved";
        shortCutHint= "";
      }
    }

// -------Point Replay Control-------------
    if (key == '4') {
      isSwitch = 4;
      isReaded = false;
      appState= "Point Replay Control";
      shortCutHint= "(Press 'n' to next Point; Press 'b' to last Point)";
    }
    if (isSwitch == 4) {
      if (key == 'n') {
        pointIdx = pointIdx +3;
      }
      if (key == 'b') {
        pointIdx = pointIdx -3;
      }
    }


// -------Path Record Control-------------
    if (key == '5') {
      isSwitch = 5;
      appState= "Path Record Control";
      shortCutHint= "(Press 'w' to new file)";
      //New Record File
    }
   // Record path
    if (isSwitch == 5) {
      if (key=='w'|| key =='W') {
        writeFileName = recordTxtField.getText();
        readPath = createWriter(writeFileName+".txt");
        shortCutHint= "(Press 's' to save file)";
        appState =appState + " : New TxtFile is "+writeFileName+".txt";
        isRecording = true;
        println("=====New File=====");
      }
      if (key =='S'|| key =='s') {
        isRecording = false;
        readPath.flush();  // Writes the remaining data to the file
        readPath.close();  // Finishes2 the file
        appState = "Path Record Control: " +writeFileName+".txt saved";
        shortCutHint= "";
      }
    }
    
// -------DynaBase Path Replay Control-------------    
    if (key == '6') {
      isSwitch = 6;
      appState= "DynaBase Path Replay Control";
      //New Record File
    }

// -------DynaFrame Path Replay Control------------- 
    if (key == '7') {
      isSwitch = 7;
      appState= "Dynaframe Path Replay Control";
      //New Record File
    }

    if (key == 'f') {
      heightValues = heightValues+10;
    }
    if (key == 'v') {
      heightValues = heightValues-10;
    }
  }
}


void flowIK(int[] data) {
  for (int i = 0; i<motorNum; i++) {
    cp5.getController("Motor"+str(i+1)).setValue(data[i]);
  }
}

