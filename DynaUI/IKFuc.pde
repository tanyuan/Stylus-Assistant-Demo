float[] IKControl(float x, float y, float l1, float l2, float l ) {
  // Angle Variables
  float A;            //distance between end and root
  float B;            //upp arm length
  float gamma;        //offset angle of upp arm
  float phi;          //end point angle
  float alpha;        
  float beta;       
  float[] servoIKPos = new float[2];  

  A = sq(x)+sq(y);
  B = sq(l1)+sq(l);
  gamma = degrees(atan(l/l1));
  phi = degrees(atan( abs(y)/abs(x) ));
  alpha = degrees(acos( (A+B-sq(l2)) / (2*sqrt(A)*sqrt(B)) ));
  beta = degrees(acos( (B+sq(l2)-A) / (2*sqrt(B)*l2) ));

  //println("beta:"+beta);

  //First Quadrant
  if (x >= 0 && y >= 0) {
    servoIKPos[0] = phi+gamma+alpha;  
    servoIKPos[1] = beta - 90 - gamma; 

    //Second Quadrant
  } else if (x < 0 && y >=0) {
    servoIKPos[0] = 180-(phi - alpha - gamma);
    servoIKPos[1] = beta - 90 - gamma;
  }  
  return servoIKPos;
}




void IKDraw() {
  //x = x0 - cx; y = cy - y0
  //x0 = x+cx ; y0 = cy-y
  // x0 y0 is original axes, x y is offset axes
  //x0 = x+cx ; y0 = y+cy
  //x = x0-cx ; y = y0-cy
  upp.set(mouseX-orignal.x, orignal.y-mouseY);
  //println("up is "+upp);

  //End Point Drawing
  ellipse(mouseX, mouseY, ellipseR, ellipseR);
  servoAngle = IKControl(upp.x, upp.y, uppLength, downLength, mdLength);
  //printArray(servoAngle);
  down.x = rootL*cos(radians(servoAngle[0]));
  down.y = rootL*sin(radians(servoAngle[0]));
  line(orignal.x, orignal.y, down.x+orignal.x, orignal.y-down.y);
  line(mouseX, mouseY, down.x+orignal.x, orignal.y-down.y);

  float foreArmAngle = degrees(atan( (down.y-upp.y)/(down.x-upp.x) ));
  //Middle Point Drawing
  ellipse(down.x+orignal.x, orignal.y-down.y, ellipseR, ellipseR);
  //println("upp.x:"+upp.x+",upp.y:"+upp.y+",down.x:"+down.x+",down.y:"+down.y+",angle:"+foreArmAngle);
}


int[] angleMap(float [] ikAngle, int zAngle) {
  int[] dynaAngle = initState;
  //printArray(initState) ;
  dynaAngle[0] = int(map(ikAngle[0]-180, -150, 150, 0, 1023));
  dynaAngle[1] = int(map(ikAngle[1], -150, 150, 0, 1023));
  
  dynaAngle[2] = int(map(zAngle, -150, 150, 0, 1023));
  //println("dynaAngle:"+dynaAngle[0]+",dynaAngle[1]:"+dynaAngle[1]+",daynaAngle[2]:"+dynaAngle[2]);
  //dynaAngle[2] = zAngle;
//  dynaAngle[3] = zAngle; 
  return dynaAngle;
}







