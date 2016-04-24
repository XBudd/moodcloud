// Colin Budd
// 11/26/15
// Based on Daniel Shiffman's Example 18-5
// http://www.learningprocessing.com

// A WeatherGrabber class
class WeatherGrabber {

  float temperature = 0.0;
  String weather = "";
  String zip;
  float windSpeed = 0.0;
  float timeH = 0.0;
  String timeM = "";
  String set = "";
  String rise = "";
  
  WeatherGrabber(String tempZip) {
    zip = tempZip;
  }

  // Set a new Zip code
  void setZip(String tempZip) {
    zip = tempZip;
  }
  // Get Sun rise
  String getSunRise() {
    return rise;
  }
  

  //Get Sun set
  String getSunSet() {
    return set;
  }

  // Is it day or night?
  Boolean getDayLight() {
    boolean dayLight = false;
    int hour = int(timeH);
    int min = int(timeM);
    
    print("\n hour = " + hour + " & minute = " + min);
    int setH = int(set.substring(0, set.indexOf(":")));
    int setM = int(set.substring(rise.indexOf(":")+1));
    int riseH = int(rise.substring(0, rise.indexOf(":")));
    int riseM = int(rise.substring(rise.indexOf(":")+1));
    //doing this the hard way...
    if (hour > riseH - 1 ) { 
      if (hour == setH +1 ) {
        if (min >= setM) {
          //NIGHT TIME (sunset + 1 hour)
          dayLight = false;
        } else {
          dayLight = true;
        }
      } else if (hour > setH + 1) {
        dayLight = false;
      } else {  //current hour is before set time
       dayLight = true;
      }
    } else if (hour == riseH - 1) { 
      if (min >= riseM) {
        dayLight = true;
      } else {
        dayLight = false;
      } 
    } else {
      dayLight = false;
    }
    return dayLight; 
  }

  // Get the temperature
  float getTemp() {
    return temperature;
  }

  // Get the weather
  String getWeather() {
    return weather;
  }

  // Get weather's wind speed. All of it!
  float getWindSpeed() {
    return windSpeed;
  }
  


  // Make the actual XML request
  void requestWeather() {
    // Get all the HTML/XML source code into an array of strings
    // (each line is one element in the array)
    String url = "https://www.wunderground.com/cgi-bin/findweather/getForecast?query=KITH";
    String[] lines = loadStrings(url);

    // Turn array into one long String
    String xml = join(lines, "" ); 

    // Searching for weather condition
    String lookfor = "condition\":\"";
    String end = ",";
    weather = giveMeTextBetween(xml, lookfor, end);
    weather = weather.replaceFirst("\"", ""); 
    print(weather);
    // Searching for temperature
    lookfor = "\"temperature\":";
    temperature = float(giveMeTextBetween (xml, lookfor, end));
    //println(temperature);

    // Searching for wind speed
    lookfor = "\"wind_speed\":";
    windSpeed = float(giveMeTextBetween (xml, lookfor, end));
    println(windSpeed);

    // Searching for sun rise
    lookfor = "\"cc-sun-rise\">";
    end = "<";
    rise = giveMeTextBetween (xml, lookfor, end);
   // println(rise);

    // Searching for sun set
    lookfor = "\"cc-sun-set\">";
    set = giveMeTextBetween (xml, lookfor, end);
    //println(set);

    // Searching for time 
    lookfor = "\"hour\":";
    end = ",";
    timeH = float(giveMeTextBetween (xml, lookfor, end));
    //println(int(timeH));

    lookfor = "\"min\": \"";
    end = "\",";
    timeM = giveMeTextBetween (xml, lookfor, end);
   // println(int(timeM));
  }

  // A function that returns a substring between two substrings
  String giveMeTextBetween(String s, String before, String after) {
    String found = "";
    int start = s.indexOf(before);    // Find the index of the beginning tag
    if (start == - 1) return"";       // If we don't find anything, send back a blank String
    start += before.length();         // Move to the end of the beginning tag
    int end = s.indexOf(after, start); // Find the index of the end tag
    if (end == -1) return"";          // If we don't find the end tag, send back a blank String
    return s.substring(start, end);    // Return the text in between
  }
}
