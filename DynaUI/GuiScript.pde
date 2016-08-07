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

  txtLableState.setText(appState);
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
  for (int i = 0; i<4; i++) {
    for (int j = 0; j<3; j++) {
      ellipse(wsOrignal.x+sampleInterval.x*(1+2*i), wsOrignal.y+sampleInterval.y*(1+2*j), ellipseR/2, ellipseR/2);
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
    if (key == '3') {
      isSwitch = 3;
      isReaded = false;
      appState= "Point Replay Control";
      //initSnake();
    }

    if (key == '4') {
      isSwitch = 4;
      isReaded = false;
      appState= "Path Replay Control";
    }

    if (key == '5') {
      isSwitch = 5;
      appState= "Path Record Control";
      //New Record File
    }

    if (key == '6') {
      isSwitch = 6;
      appState= "Point Record Control";
      //New Record File
    }


    if (key == '7') {
      isSwitch = 7;
      appState= "DynaBase Path Record Control";
      //New Record File
    }

    // Record path
    if (isSwitch == 5) {
      if (key=='w'|| key =='W') {
        writeFileName = recordTxtField.getText();
        readPath = createWriter(writeFileName+".txt");
        appState =appState + " : New TxtFile is "+writeFileName+".txt";
        isRecording = true;
        println("=====New File=====");
      }
      if (key =='S'|| key =='s') {
        isRecording = false;
        readPath.flush();  // Writes the remaining data to the file
        readPath.close();  // Finishes2 the file
        appState = "Path Record Control: " +writeFileName+".txt saved";
      }
    }

    // Record dynaBase Data
    if (isSwitch == 7) {
      if (key=='w'|| key =='W') {
        writeFileName = recordTxtField.getText();
        readPath = createWriter(writeFileName+".txt");
        appState =appState + " : New TxtFile is "+writeFileName+".txt";
        isRecording = true;
        println("=====New File=====");
      }
      if (key =='S'|| key =='s') {
        isRecording = false;
        readPath.flush();  // Writes the remaining data to the file
        readPath.close();  // Finishes2 the file
        appState = "Path Record Control: " +writeFileName+".txt saved";
        
      }
    }



    if (isSwitch == 6) {
      if (key=='w'|| key =='W') {
        writeFileName = recordTxtField.getText();
        readPath = createWriter(writeFileName+".txt");
        appState =appState + " : New TxtFile is "+writeFileName+".txt";
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
      }
    }



    if (key == 'f') {
      heightValues = heightValues+10;
    }
    if (key == 'v') {
      heightValues = heightValues-10;
    }


    if (isSwitch ==3) {
      if (key == 'n') {
        pointIdx = pointIdx +3;
        println(pointIdx);
      }
    }


    if (key == 'b') {
      if (isSwitch ==3) {
        pointIdx = pointIdx -2;
        println(pointIdx);
      }
    }
  }
}



void flowIK(int[] data) {
  for (int i = 0; i<motorNum; i++) {
    cp5.getController("Motor"+str(i+1)).setValue(data[i]);
  }
}

