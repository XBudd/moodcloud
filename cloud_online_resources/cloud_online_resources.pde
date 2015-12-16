/* Colin Budd
 * December 15, 2015
 * Cornell University
 */

import java.io.BufferedWriter;
import java.text.*;
import java.io.FileWriter;
import processing.net.*;
import gab.opencv.*;
OpenCV opencv;
ArrayList<Contour> contours;
int contoursCount;
// The WeatherGrabber object does the work for us!
WeatherGrabber wg;
skyColor sc;

int x = 0;
void setup() {
  size(200, 200);

  wg = new WeatherGrabber("14850");  
  sc = new skyColor();
  sc.findSkyColor();
}
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
}

void draw() {
  if (minute() % 5 == 0){
  writeFile();
  background(sc.getSkyColor());
  }
}
void writeFile() {
  try {
    //FILE SAVE DATA (change the path from below)
    String filename = "C:/Users/tailormade/Documents/Processing/cloud_online_resources/data/weatherLog.csv";
    boolean newFile=false;
    File f = new File(filename);

    FileWriter writer = new FileWriter(f);         

    int count = 0;
    try {
      wg.requestWeather();
      sc.findSkyColor();

      try {
        writer.write("id,hour,minute,condition,temp,windSpeed,dayLight,skyColorR,skyColorB,skyColorG,\n");
        String[] data = new String[10];             
        data[0] = ""+x; 
        data[1] =  String.valueOf(hour());
        data[2] =  String.valueOf(minute());
        data[3] = wg.getWeather(); 
        data[4] = String.valueOf(wg.getTemp()); 
        data[5] = String.valueOf(wg.getWindSpeed());
        data[6] = String.valueOf(wg.getDayLight()); 
        data[7] = String.valueOf(sc.getSkyColorR());
        data[8] = String.valueOf(sc.getSkyColorB());
        data[9] = String.valueOf(sc.getSkyColorG());
        println(String.valueOf(sc.getSkyColorR()));
        //this if case will fill the array just if the search is null               
             

        for (int k=0; k < data.length; k++) {
          writer.write(data[k] + ",");
          x++;
        }
        writer.write("\n");
        writer.write("\n");
        writer.flush();
      } 
      catch(NullPointerException e) {
        println("Null");
      }
    }
    catch(NullPointerException e) {
      println("Null");
    }
  }
  catch (IOException ioe) {
    println("IO/ERROR: " + ioe);
  }
}
void mouseClicked() {
  writeFile();
  background(sc.getSkyColor());
}

void requestData() {
  String url = "http://www.wunderground.com/cgi-bin/findweather/getForecast?query=KITH";
  String[] lines = loadStrings(url);

  // Turn array into one long String
  String xml = join(lines, "" ); 
  println(xml);
  saveStrings("weather.text", lines);
}

