// Colin Budd
// 12/8/15

// skyColor Class
/*
class skyColor {

  PImage img; 
  PImage cropImg;
  PImage cornerCropImg;
  int time;

  color skyColor;

  color getSkyColor() {
    return skyColor;
  }
  int getContours() {
    return contoursCount;
  }
  PImage getImage() {
    return cropImg;
  }



  void findSkyColor() {

    time = millis(); // store current time;
    try {
      //Load initial image
      img = loadImage("http://cs1.pixelcaster.com/cornell/cornell.jpg");  // Load the image into the program  
      cropImg = img.get(400, 0, 1150, 350); //get sky
      cornerCropImg = cropImg.get(1130, 330, 20, 20); //get corner
      skyColor = getAverageColor(cropImg);

      if (contourSize() <= contoursCount+10) {

        skyColor =  getAverageColor(cropImg);
        println("skyColor = " + skyColor);
        contoursCount = contourSize();
        //clear arraylist
        contoursClear();
      } else { //wrong image laoded
        println("this image has MORE contours....don't change...");
      }
    }   
    catch(NullPointerException e) {
      println("skyColor Null Pointer Exception");
      
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


    return color(r, g, b);
  }
}
*/
