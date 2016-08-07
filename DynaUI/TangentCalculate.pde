float[] TangentAngle(float[] data) {
  //float[] newData = new float[data.length];
  float[] newData = {
    data[0], data[1], 0
  };  //last number is the index
  float[] tanData = data;  // last number is tangent angle
  int index = 0;
  int newDataLength = 0;
  float angle = 0;
  float[] tangentAngle = new float[1] ;
  //---linear regression parameters
  int pn = 10; //linear regressiong point number
  float sumX;    // sum of x
  float sumY;    // sum of y
  float sumXX;   // sum of x*x
  float sumXY;   // sum of x*y
  float sumYY;   // sum of y*y 
  float a0, a1;

  //motors parameters
  float[] motorAngle = new float[2];
  float[] middlePoint = new float[2];
  float foreArmAngle;

  //  newData[0] = data[0];
  //  newData[1] = data[1];
  //  newData[2] = 0;//0 is the index of orignal data
  println("DataLength:"+data.length);
  for (int i=1; i< (data.length-1)/3; i++) {
    if (data[3*i]!=newData[index]||data[3*i+1]!=newData[index+1]) {
      index = index+3;
      newData =   append(newData, data[3*i]);
      newData = append(newData, data[3*i+1]);
      newData = append(newData, i);
      //angle = degrees(atan( (newData[index+1]-newData[index-2])/(newData[index]-newData[index-3]) ));
      //println("newData:"+newData[index]+","+newData[index+1]+","+newData[index+2]);
    }
  }

  for (int i = 0; i< newData.length/3-1; i++) {
    if (i<newData.length/3-9) {
      sumX =0;
      sumY =0;
      sumXX = 0;
      sumXY = 0;
      sumYY = 0;
      for (int j = i; j<pn+i; j++) {
        // println("j:"+j+",x:"+newData[j*3],",y:"+newData[j*3+1]);
        sumX = sumX+newData[j*3];
        sumY = sumY+newData[j*3+1];
        sumXX = sumXX + sq(newData[j*3]);
        sumXY = sumXY + newData[j*3]*newData[j*3+1];
        sumYY = sumYY + sq(newData[j*3]+1);
      }
      float xBar = sumX / pn;  
      float yBar = sumY / pn;  
      float YValue = pn * sumXY - sumX * sumY;
      float XValue = pn * sumXX - sumX  * sumX;
      a1 = YValue / XValue;
      //a0 = yBar - a1 * xBar;
      float tAngle = degrees(atan(a1));
      println(newData.length+",i:"+i+",a1:"+a1+",tanAngle:"+tAngle+",flag:"+newData[i*3+2]);
      // Check tAngle is NaN
      if (tAngle!=tAngle ) {
        if(YValue>0){
          tAngle = -90;
        }else {
          tAngle = 90;
        }
        
      }
      tangentAngle = append(tangentAngle, tAngle) ;
      tangentAngle = append(tangentAngle, newData[i*3+2]) ;
      // println("angle:"+tAngle+",flag:"+newData[i*3+2]);
    }
  }

  println("tangentAngle:"+tangentAngle.length+",tanData:"+tanData.length);
  int tIndex = 0;
  for (int i=0; i< (tanData.length-1)/3; i++) {
    if (i>=tangentAngle[2*(tIndex+1)+2]&&tIndex<(tangentAngle.length-1)/2-3) {
      tIndex = tIndex +1;
    }
    tanData[3*i+2] = tangentAngle[2*tIndex+1];
    motorAngle = IKControl(tanData[3*i], tanData[3*i+1], uppLength, downLength, mdLength);
    middlePoint[0] = rootL*cos(radians(motorAngle[0]));
    middlePoint[1] = rootL*sin(radians(motorAngle[0]));
    foreArmAngle = degrees(atan( (tanData[3*i+1]-middlePoint[1])/(tanData[3*i]-middlePoint[0]) ));
    float debugAngle = tanData[3*i+2];
    tanData[3*i+2] = -abs(tanData[3*i+2]-foreArmAngle);
    println("x:"+tanData[3*i]+",y:"+tanData[3*i+1]+",foreAngle:"+ foreArmAngle+",tanAngle:"+debugAngle+",endAngle:"+tanData[3*i+2]);
    //println("x:"+tanData[3*i]+",y:"+tanData[3*i+1]+",mx:"+middlePoint[0]+",my:"+middlePoint[1]+",foreAngle:"+ foreArmAngle+",tanAngle:"+tanData[3*i+2]+",endAngle:"+endAngle);
    //println("i:"+i+",tIndex:"+tIndex+",tanDataIndex:"+3*i+2+",x:"+tanData[3*i]+",y:"+tanData[3*i+1]+",angle:"+tanData[3*i+2]);
  }
  return tanData;
}

