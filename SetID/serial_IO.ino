/**
   For aruidno IO
   by andy, 2015
   Library:
   https://processing.org/reference/libraries/serial/
*/
void rwEvent(int input[MOTORNUM],int output[MOTORNUM]) {
  if (Serial.available() > 0) {
    //0xff is a header marker

    //Reading data from processing
    if (Serial.read() == 0xfe) {
      for (int i = 0; i < MOTORNUM; i++) {
        while (Serial.available() <= 0);
        input[i] = Serial.read();
        input[i] = 4*input[i];
      }
      //Sending data to processing
      Serial.write(0xff);
      for (int i = 0; i < MOTORNUM; i++) {
        Serial.write(output[i]);
      }
    }
  }
}







