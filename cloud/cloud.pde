import gab.opencv.*;
OpenCV opencv;
ArrayList<Contour> contours;
int contoursCount;
// For testing animation without Teensy borad
boolean testWidthOutTeensy = false;

//WeatherGrabber wg;
//skyColor sc;
readTable rt;
boolean dayLight = false;

int time;

ArrayList<Ani> anis;
color[] colorArray = new color[10];
int lastInteractionMillis = 0;
int cloudDensity = 5; // 1~10
int windSpeed; // was = 10 
int cloudAnimationInterval = 10; // Seconds

color bg = (0);

void setup() {
  // Basics
  size(180, 24, P3D);
  background(bg);
  frameRate(30);

  // Make a WeatherGrabber object
 // wg = new WeatherGrabber("14850");
  // Tell it to request the weather on every draw so always current
 // wg.requestWeather();

 // sc = new skyColor();
 // sc.findSkyColor();

   rt = new readTable();
  rt.getTable();
  float x = map(rt.getWindSpeed(), 0.0, 60.0, 3.0, 180.0);
  windSpeed = int(x);
  //println("windspeed is: " + windSpeed);

  // LED Control
  if (!testWidthOutTeensy) {
    String[] list = Serial.list();
    delay(20);
    println("Serial Ports List:");
    println(list);
    serialConfigure("COM3");  // change these to your port names
    if (errorCount > 0) exit();
    for (int i=0; i < 256; i++) {
      gammatable[i] = (int)(pow((float)i / 255.0, gamma) * 255.0 + 0.5);
    }
  }

  // Animation
  anis = new ArrayList<Ani>();

  // Cloud Animation
  clouds = new ArrayList<CloudAni>();
  for (int i=0; i<20; i++) {
    clouds.add(new CloudAni());
  }
  resetPositions();
  // Server

  myServer = new Server(this, port);
 

  colorArray[1] = color(255, 10, 10); //red
  colorArray[0] = color(255, 190, 0); //orange
  //  colorArray[0] = color(255,30,100); //pink
  colorArray[2] = color(255, 245, 0); //yellow
  colorArray[3] = color(255, 190, 0); //orange

  colorArray[4] = color(51, 255, 71); //green
  colorArray[5] = color(51, 204, 151); //teal
  colorArray[6] = color(80, 0, 255); //blue
  colorArray[7] = color(20, 255, 255); //light blue
  colorArray[8] = color(138, 0, 255); //purple
  colorArray[9] = color(153, 153, 153); //white
}
/*
int contourSize() {

  opencv = new OpenCV(this, sc.getImage());
  opencv.gray();
  opencv.threshold(70);
  contours = opencv.findContours();
  println("found " + contours.size() + " contours");
  return contours.size();
}

void contoursClear() {
  contours.clear();
}*/

void draw() {
  if (minute() % 5 == 0 && millis() == 30000){ //ever 5 mins and 30 seconds
    rt.getTable();
  }
  
  bg = color(rt.getSkyColorR(),rt.getSkyColorG(),rt.getSkyColorB());
  dayLight =rt.getDayLight();
  updateSkyColor();
  if (brightness(bg) <75){
    bg = 0;
  }
  if (!dayLight) {
    background(bg);
  } else {
    background(bg); //sky color
  }




  drawGradient();
  if (lastInteractionMillis < millis() - cloudAnimationInterval * 1000) {
    fill(0, min(100, (millis() - lastInteractionMillis - cloudAnimationInterval * 1000) / 100));
    rect(0, 0, width, height);
    updateCloudAni();
  }
  updateAni();
  if (!testWidthOutTeensy) {
    sendData();
  }
  int a = getMessege();
  if (a > 0 & a < 10) {
    println(a);
    anis.add(new Ani(colorArray[a], a/2+1));
  }
/*
  if (millis() - time > 900000 && millis() - time <= 900002) { //every 9 minutets
 
   wg.requestWeather();
    float x = map(rt.getWindSpeed(), 0.0, 50.0, 3.0, 180.0);
    windSpeed = int(x);
    println("windspeed = " + windSpeed);
   
  }*/
}
void keyPressed() {
  println(keyCode);
  if (keyCode > 48 & keyCode < 54) {
    anis.add(new Ani(colorArray[(keyCode-49) * 2], keyCode-48));
  }
}

 
void updateSkyColor() {
 /*if (minute() % 2 == 0 && second() == 5) {
    println("-----new image----");
    println(hour() + ":"+ minute() +":" + second());
 
    sc.findSkyColor();
    bg = sc.getSkyColor();
  }
  */
}
void mouseClicked(){
   // wg.requestWeather();
   // updateSkyColor();
    rt.getTable();
    float x = map(rt.getWindSpeed(), 0.0, 50.0, 3.0, 180.0);
    windSpeed = int(x);
}
  

