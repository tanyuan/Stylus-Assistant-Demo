float[] Reading(String fileName) {
  float[] data;
  float[] preData = {
    512, 512,0
  };
  String[] stuff = loadStrings(fileName+".txt");
  println(readFileName+".txt");
  //printArray(data);
  if (stuff.length == 0) {
    data = preData;
    println("File:"+fileName+" is null.");
  } else {
    println(stuff);
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

void Recording2(PrintWriter path, float x, float y) {
  path.print(x);  // Write the coordinate to the file
  path.print(",");
  path.print(y);
  path.print(",");
  println("Recording:"+x+","+y);
}