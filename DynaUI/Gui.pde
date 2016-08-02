/**
 * for processing gui 
 * by andy, 2012
 * Library:
 * www.sojamo.de/libraries/controlp5
 */

ControlP5 cp5; //for UI
Textlabel txtLableState;
Textfield recordTxtField, readTxtField;


color black = color(0);
color white = color(255);
color blue = color(0, 174, 239);

int offSetY = 5;
void Gui() {
  size (800, 800);
  noStroke();
  smooth();  
  cp5 = new ControlP5(this);

  cp5.addTextlabel("label1")
    .setText("PortName:"+portName)
      .setPosition(10, 5+offSetY)
        .setColorValue(black)
          .setFont(createFont("Georgia", 14))
            ;

  txtLableState = cp5.addTextlabel("label2")
    .setText(appState)
      .setPosition(10, 5+offSetY*5)
        .setColorValue(black)
          .setFont(createFont("Georgia", 14))
            ;


  //Reset Button
  cp5.addButton("Reset")
    .setValue(0)
      .setPosition(500, 50)
        .setSize(60, 40)
          ;



  //For Record and Read File Name input
  cp5.addTextlabel("record")
    .setText("Record File Name(S:Save):")
      .setPosition(500, 100)
        .setColorValue(black)
          .setFont(createFont("Georgia", 14))
            ;
  recordTxtField = cp5.addTextfield("recordTxtField")
    .setPosition(700, 100)
      .setSize(80, 25)
        .setText(writeFileName)
          .setFont(createFont("Georgia", 14))
            //.set
            ;

  cp5.addTextlabel("read")
    .setText("Read File Name (3:path,4:point):")
      .setPosition(500, 130+offSetY)
        .setColorValue(black)
          .setFont(createFont("Georgia", 14))
            ;
  readTxtField = cp5.addTextfield("readTxtField")
    .setText(readFileName)
      .setPosition(700, 130+offSetY)
        .setSize(80, 25)
          .setAutoClear(false)
            .setFont(createFont("Georgia", 14))
              //.set
              ;



  // Motor Control Sliders 
  for (int i=0; i<motorNum; i++) {
    cp5.addSlider("Motor"+str(i+1))
      .setPosition(10, 50*(i+1))
        .setSize(400, 40)
          .setRange(0, 1023)
            .setValue(512)
              .setSliderMode(Slider.FLEXIBLE)
                // use Slider.FIX or Slider.FLEXIBLE to change the slider handle
                // by default it is Slider.FIX
                //.setNumberOfTickMarks(7)
                //set marks
                ;
  }
}

