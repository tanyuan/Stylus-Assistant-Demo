/**
   For aruidno IO
   by andy, 2015
   Library:
   https://processing.org/reference/libraries/serial/
*/
void readEvent(int input[MOTORNUM]) {
  if (Serial.available() > 0) {
    //0xff is a header marker
    //Reading data from processing
    if (Serial.read() == 0xfe) {
      for (int i = 0; i < MOTORNUM; i++) {
        while (Serial.available() <= 0);
        int multiplier = Serial.read(); // Empty loop to avoid non-sense values
        while (Serial.available() <= 0);
        int remainder = Serial.read();
        input[i] = 256 * multiplier + remainder;
      }
    }
  }
}

void sendEvent(int output[MOTORNUM]) {
  //Sending data to processing
  Serial.write(0xff);
  for (int i = 0; i < MOTORNUM; i++) {
    Serial.write(output[i] / 256);
    Serial.write(output[i] % 256);
  }
}







