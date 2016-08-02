float[] Reading(String fileName) {
  float[] data;
  float[] preData = {
    300, 300,512
  };
  String[] stuff = loadStrings(fileName+".txt");
  println(readFileName+".txt");
  //printArray(data);
  if (stuff == null) {
    data = preData;
    //data[1] = 575;
  } else {
    data = float(split(stuff[0], ','));
  }
  return data;
}


void Recording3(PrintWriter path, float x, float y, int z) {
  path.print(x);  // Write the coordinate to the file
  path.print(",");
  path.print(y);
  path.print(",");
  path.print(z);
  path.print(",");
  println("Recording:"+x+","+y+","+z);
}

