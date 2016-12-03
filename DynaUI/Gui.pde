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
color green = color(78, 191, 78);
color orange = color(226, 117, 0);

int offSetY = 5;
void Gui() {
  
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
  //  cp5.addButton("Reset")
  //    .setValue(0)
  //      .setPosition(500, 50)
  //        .setSize(60, 40)
  //          ;

  //--- Document ----
  cp5.addTextlabel("Document1")
    .setText("1:Slider; 2:IK; 3:Point Record; 4: Point Replay")
      .setPosition(420, 40)
        .setColorValue(black)
          .setFont(createFont("Georgia", 14))
            ;
  cp5.addTextlabel("Document2")
    .setText("5:Path Record; 6:Base Replay; 7:Frame Replay")
      .setPosition(420, 60)
        .setColorValue(black)
          .setFont(createFont("Georgia", 14))
            ;
  //For Record and Read File Name input
  cp5.addTextlabel("record")
    .setText("Record File Name(W:New,S:Save):")
      .setPosition(420, 100)
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
    .setText("Read File Name (4:point,6,7:path):")
      .setPosition(420, 130+offSetY)
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
              
//////////////////////////// DynaFrame
  cp5.addTextlabel("label3")
   .setText("DynaFrame Demo:")
   .setPosition(10, 270)
   .setColorValue(black)
   .setFont(createFont("Georgia", 14))
   ;
  cp5.addButton("frame_demo_1")
   .setPosition(10,300)
   .setSize(200,32)
   .setColorBackground(green)
   ;
  cp5.addButton("frame_demo_2")
   .setPosition(10,340)
   .setSize(200,32)
   .setColorBackground(green)
   ;
  //cp5.addButton("frame_demo_3")
  // .setPosition(10,380)
  // .setSize(200,32)
  // .setColorBackground(green)
  // ;
  //cp5.addButton("frame_demo_4")
  // .setPosition(10,420)
  // .setSize(200,32)
  // .setColorBackground(green)
  // ;
  
  //////////////////////////// DynaBase
  cp5.addTextlabel("label4")
   .setText("DynaBase Demo:")
   .setPosition(10, 460)
   .setColorValue(black)
   .setFont(createFont("Georgia", 14))
   ;
  cp5.addButton("base_demo_1")
   .setPosition(10,490)
   .setSize(200,32)
   .setColorBackground(orange)
   ;
  cp5.addButton("base_demo_2")
   .setPosition(10,530)
   .setSize(200,32)
   .setColorBackground(orange)
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