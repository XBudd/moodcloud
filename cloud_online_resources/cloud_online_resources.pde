/* Colin Budd
 * December 15, 2015
 * Cornell University
 */

// Load libraries needed
import java.io.BufferedWriter;
import java.text.*;
import java.io.FileWriter;
import processing.net.*;
import gab.opencv.*;

// Presets and initializers
OpenCV opencv;
ArrayList<Contour> contours;
int contoursCount;
boolean dayLight;
String condition;
float temperature;

WeatherGrabber wg;
skyColor sc;
int x = 0;


void setup() {
  size(200, 200);
  // Set location and get skycolor
  wg = new WeatherGrabber("14850");  // Cornell's Zip Code
  sc = new skyColor();
  sc.findSkyColor();
}

// Contours are used to determine if skycam is looking at the correct image. 
// The crop of the sky (correct image) will have relatively few contours compared
// to the crop of Willard Straight Hall so we want to reject any image that has 
// many more contours than the current image.

int contourSize() {

  opencv = new OpenCV(this, sc.getImage());
  opencv.gray();
  opencv.threshold(70);
  contours = opencv.findContours();
  println("----------------------- \n");
  println("found " + contours.size() + " contours");
  return contours.size();
}

void contoursClear() {
  contours.clear();
}

void draw() {
  if (minute() % 5 == 0) { //write to file every 5 minutes
    writeFile();
    background(sc.getSkyColor());
  }
}
void writeFile() {
  try {
    //FILE SAVE DATA (change the path if needed)
    String filename = "C:/Users/tailormade/Documents/Processing/cloud_online_resources/data/weatherLog.csv";
    boolean newFile=false;
    File f = new File(filename);

    FileWriter writer = new FileWriter(f);         

    int count = 0;
    try {
      wg.requestWeather();
      dayLight =wg.getDayLight();
      condition = wg.getWeather();
      temperature = wg.getTemp();
      sc.weatherGetter(dayLight, condition, temperature);
      sc.findSkyColor();

      try {
        writer.write("id,hour,minute,condition,temp,windSpeed,dayLight,skyColorR,skyColorB,skyColorG,skyBright, \n");
        String[] data = new String[11];             
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
        data[10] = String.valueOf(sc.getSkyBright());
        println("\n skyBright is: " + String.valueOf(sc.getSkyBright()));
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

//For quick testing
void mouseClicked() {
  writeFile(); 
  background(sc.getSkyColor());
}

void requestData() {
  // URL for Cornell's weather
  String url = "http://www.wunderground.com/cgi-bin/findweather/getForecast?query=KITH";
  String[] lines = loadStrings(url);

  // Turn array into one long String
  String xml = join(lines, "" ); 
  println(xml);
  saveStrings("weather.text", lines);
}

