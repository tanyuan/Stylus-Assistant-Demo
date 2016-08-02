//float[] IKControl(float x, float y, float a, float b, ) {
//  // Angle Variables
//  float A;            //Angle oppposite side a (between b and c)
//  float B;            //Angle oppposite side b
//  float C;            //Angle oppposite side c
//  float theta;        //Angle formed between line from origin to (x,y) and the horizontal
//  //int[MOTORNUMBER] servo_angle; //Angle result of 2 joints
//
//  // Distance variables
//  float c;            // Hypotenuse legngth in cm
//  //float pi = PI;  //Store pi in a less annoying format
//  float[] servoIKPos = new float[2];
//
//  c = sqrt( sq(x) + sq(y) );  
//  B = degrees(acos( (sq(b) - sq(a) - sq(c)) / (-2 * a * c) )) ;    // Law of cosines: Angle opposite upper arm section
//  C = degrees(acos( (sq(c) - sq(b) - sq(a)) / (-2 * a * b) ));    // Law of cosines: Angle opposite hypotenuse
//  theta = degrees(asin( abs(y) / abs(c) ));                                 // Solve for theta to correct for lower joint's impact on upper joint's angle
//  if (x >= 0 && y >= 0) 
//    //if(C<90) C=90;
//    servoIKPos[0] =  B + theta;                   // Find necessary angle. Add Correction
//    servoIKPos[1] =  C - 90;                         // Find neceesary angle. Add Correction
//  } else if (x < 0 && y > 0) {
//    //if(C<90) C=90;
//    servoIKPos[0] =  180 - theta + B;                  // Find necessary angle. Add Correction
//    servoIKPos[1] =  C - 90;                          // Find neceesary angle. Add Correction
//  } else if (x < 0 && y < 0) {
//    //if(C<90) C=90;
//    servoIKPos[0] =  180-theta-B;                   // Find necessary angle. Add Correction
//    servoIKPos[1] =  C-90;                         // Find neceesary angle. Add Correction
//  } else {
//    //if(C<90) C=90;
//    servoIKPos[0] =    theta-B;                   // Find necessary angle. Add Correction
//    servoIKPos[1] =  C - 90;                         // Find neceesary angle. Add Correction
//  }
//  return servoIKPos;
//}
//
//
//void IKDraw() {
//  //x = x0 - cx; y = cy - y0
//  //x0 = x+cx ; y0 = cy-y
//  // x0 y0 is original axes, x y is offset axes
//  //x0 = x+cx ; y0 = y+cy
//  //x = x0-cx ; y = y0-cy
//  upp.set(mouseX-orignal.x, mouseY-orignal.y);
//  //println("up is "+upp);
//  ellipse(mouseX, mouseY, ellipseR, ellipseR);
//  servoAngle = IKControl(upp.x, -upp.y, uppLength, downLength);
//  //printArray(servoAngle);
//  down.x = downLength*cos(radians(servoAngle[0]));
//  down.y = downLength*sin(radians(servoAngle[0]));
//  line(orignal.x, orignal.y, down.x+orignal.x, orignal.y+down.y);
//  line(mouseX, mouseY, down.x+orignal.x, orignal.y+down.y);
//  //println("down is "+down);
//  ellipse(down.x+orignal.x, orignal.y+down.y, ellipseR, ellipseR);
//}
//
//int[] angleMap(float [] ikAngle, int zAngle) {
//  int[] dynaAngle = initState;
//  //printArray(initState) ;
//  dynaAngle[0] = int(map(ikAngle[0], -150, 150, 1023, 0));
//  dynaAngle[1] = int(map(ikAngle[1], -150, 150, 0, 1023));
//  dynaAngle[2] = zAngle;
//  dynaAngle[3] = zAngle; 
//  return dynaAngle;
//}

