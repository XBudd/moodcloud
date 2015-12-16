// Colin Budd
// 12/8/15

// skyColor Class
class skyColor {

  PImage img; 
  PImage cropImg;
  PImage cornerCropImg;
  int time;
  boolean evenOdd = true; //start with assumption that assuming that it is even for sky
  int wait = 250;
  color skyColor;
  int skyColorR;
  int skyColorB;
  int skyColorG;
int counter = 0;
  color getSkyColor() {
    return skyColor;
  }
  
  int getSkyColorR() {
    return skyColorR;
  }
  
  int getSkyColorB() {
    return skyColorB;
  }
  
  int getSkyColorG() {
    return skyColorG;
  }
  int getContours() {
    return contoursCount;
  }
  PImage getImage() {
    return cropImg;
  }

  int getEvenOdd() {
    int x =0; //even
    if (!evenOdd) {
      x = 1; //odd
    }
    return x;
  }

  void findSkyColor() {

    time = millis(); // store current time;

    //Load initial image
    img = loadImage("http://cs1.pixelcaster.com/cornell/cornell.jpg");  // Load the image into the program  
    cropImg = img.get(400, 0, 1150, 350); //get sky
    cornerCropImg = cropImg.get(1130, 330, 20, 20); //get corner
    skyColor = getAverageColor(cropImg);

    if (contourSize() > contoursCount+1) {
      println("this image has MORE contours....changing evenOdd val...");
      evenOdd = !evenOdd;
      println ("even?  = " + evenOdd);
    } else { //correct image laoded
      skyColor =  getAverageColor(cropImg);
      contoursCount = contourSize();
      //clear arraylist
      contoursClear();
    }
  }



  color getAverageColor(PImage img) {

    img.loadPixels();

    int r = 0, g = 0, b = 0;
    for (int i=0; i<img.pixels.length; i++) {
      color c = img.pixels[i];
      r += c>>16&0xFF;
      g += c>>8&0xFF;
      b += c&0xFF;
    }
    r /= img.pixels.length;
    g /= img.pixels.length;
    b /= img.pixels.length;
    
    skyColorR = r;
    skyColorG = g;
    skyColorB = b;


    return color(r, g, b);
  }
}
