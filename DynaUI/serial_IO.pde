/**
 * For aruidno IO
 * by andy, 2015
 * Library:
 * www.sojamo.de/libraries/controlp5
 */
void sendEvent(int data[]) {
  myPort.clear();
  myPort.write(0xfe);
  for (int i = 0; i<motorNum; i++) {
    print("data["+i+"]: "+data[i]+", ");
    myPort.write(data[i]/256);
    myPort.write(data[i]%256);
  }
  println("");
  delay(100);
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
        
      }
    }
    println("data output "+data[0]+","+data[1]);
  }
  return data;
}