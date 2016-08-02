/**
 * For aruidno IO
 * by andy, 2015
 * Library:
 * www.sojamo.de/libraries/controlp5
 */
void sendEvent(int data[]) {
  myPort.write(0xfe);
  for (int i = 0; i<motorNum; i++) {
    //println("i is "+i+" : "+data[i]);
    myPort.write(data[i]/256);
    myPort.write(data[i]%256);
  }
}

int[] readEvent() {
  int multiplier = 0;
  int remainder = 200;
  int data[] = new int[motorNum];
  if (myPort.available()>0) {
    if (myPort.read() == 0xff) {
      for (int i = 0; i<motorNum; i++) {
        multiplier = myPort.read(); // Empty loop to avoid non-sense values
        remainder = myPort.read(); // Empty loop to avoid non-sense values
        data[i] = 256 * multiplier + remainder;
        println("data"+i + ":"+data[i]);
      }
    }
  }
  return data;
}

