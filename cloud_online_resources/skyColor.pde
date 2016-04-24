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
  int skyBright;
  boolean dayLight;
  float temperature;
  String weather ="";
  int counter = 0;
  
  // getters. so many getters.
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
  
  int getSkyBright(){
    return skyBright;
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
  void weatherGetter(boolean wgDayLightBool, String wgCondition, float wgTemp){
    dayLight = wgDayLightBool;
    weather = wgCondition;
    temperature = wgTemp;
    print("\n ---WEATHER--- \n weather: " + weather + " \n daylight? : " + dayLight + "\n temp: " + temperature + "\n ------ \n");
  }
  void findSkyColor() {
    time = millis(); // store current time;

    //Load initial image from Cornell's live cam
    img = loadImage("http://cs1.pixelcaster.com/cornell/cornell.jpg");  // Load the image into the program  
    cropImg = img.get(400, 0, 1150, 350); //get sky
    cornerCropImg = cropImg.get(1130, 330, 20, 20); //sample corner color
    skyColor = getAverageColor(cropImg); 
    skyBright = getAverageBright(skyColor);
    
    //Check image for contours
    if (contourSize() > contoursCount+1) {
      println("this image has MORE contours....changing evenOdd val...");
      evenOdd = !evenOdd; // change when we check the live-feed (on even or odd minutes)
      println ("even?  = " + evenOdd);
    } else { //correct image laoded
      skyColor =  getAverageColor(cropImg);
      contoursCount = contourSize();
      //clear arraylist
      contoursClear();
    }
   //alter based on weather conditions
   skyColor = weatherColor(skyColor);
  }
  
  //Respond to Weather Conditions:
 // https://www.wunderground.com/weather/api/d/docs?d=resources/phrase-glossary
  color weatherColor(color colorVal){
    int r=int(red(colorVal)), g=int(green(colorVal)), b=int(blue(colorVal));
    if (weather.equals("Mostly Cloudy") || weather.equals("Partly Cloudy") ){
      //slightly decrease saturation and brightness
      r=r-10;
      g=g-10;
      b=b-10;
      print("\n SEMI CLOUDY r = " + r + ", g = " + g + ", b = " + b + "\n");
    }
    else if (weather.equals("Cloudy") || weather.indexOf("Fog") != -1){
      //fade current color to be less saturated
      r=r+20;
      g=g+20;
      b=b+20;
      
      print("\n CLOUDY or FOGGY r = " + r + ", g = " + g + ", b = " + b + "\n");
    }
     else if (weather.indexOf("Sunny") != -1){
      //orange
      r=255;
      g=165;
      b=0;
      print("\n CURRENTLY SUNNY  r = " + r + ", g = " + g + ", b = " + b + "\n");
    }
     else if (weather.indexOf("Snow") != -1){
      //WHITE
      r=240;
      g=240;
      b=240;
      print("\n CURRENTLY SNOW r = " + r + ", g = " + g + ", b = " + b + "\n");
    }
    
    else{ //Overcast, Unknown, Clear... just display sky color as obtained above
    print ("\n Weather Condition not useful here for an override. Displaying sky color instead.");
  }
     
    skyColorR = r;
    skyColorG = g;
    skyColorB = b;
    
    return color(r,g,b);
  }
    
// Samples color based on average of all pixels 
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
  
  // Samples pixel intensity based on given color
  // forum.processing.org/two/discussion/3270/
  // how-to-get-pixel-intensity-not-brightness
  int getAverageBright(color c) {
    
    // Total Dark Black is 0 ----- Total Bright White is 255
    final color luminG = c>>010 & 0xFF;
    final int luminRange = int(map(luminG, 0, 255, 1, 10)); //map the lumin to cloudDensity of 1~10 
    
    println("#" + hex(c, 6));
    println("luminG: " +luminG);
    println("luminRange: " + luminRange);
    
    return luminRange;
  }
}
