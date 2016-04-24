/* Colin Budd
 * 12/15/15
 * Simple class for getting data from the table on current weather.
 * Table is generated through the cloud_online_resources.pde 
 */

class readTable {
  
  Table tTable; 
  //println(table.getRowCount() + " total rows in table"); 

  TableRow tRow;

  int tId;
  String tCondition;
  String tTemp;
  String tWindSpeed;
  String tDayLight;
  String tSkyColor;
  
  String tSkyColorR;
  String tSkyColorG;
  String tSkyColorB;
  
  String tSkyBright;

  void getTable() {
    try {
      try{
        //point file path to location of your weather CV file
      tTable = loadTable("C:/Users/tailormade/Documents/Processing/cloud_online_resources/data/weatherLog.csv", "header");
      }catch(IllegalArgumentException a){
        println("table not read");
        time = millis();
        if (millis() - time >= 30000){ //try again after 30 sec
          getTable();
        }
      }
      print("-------------------- \n");
      println(tTable.getRowCount() + " total rows in table"); 

 tRow = tTable.getRow(0);
      tId = tRow.getInt("id");
      tCondition = tRow.getString("condition");
      tTemp = tRow.getString("temp");
      tWindSpeed = tRow.getString("windSpeed");
      tDayLight = tRow.getString("dayLight");
      tSkyColorR = tRow.getString("skyColorR");
      tSkyColorB = tRow.getString("skyColorB");
      tSkyColorG = tRow.getString("skyColorG");
      tSkyBright = tRow.getString("skyBright");
      printWeather();
    }

    catch(NullPointerException e) {
      println("Null: did not load table for weather");
    }
  }

  void printWeather() {
    println(hour() +":"+ minute() + " || " + tId + " is currently " + tCondition + " and " + tTemp +
      " with windSpeed of " + tWindSpeed + ", \n dayLight = " + tDayLight + " and skyColor = " + tSkyColor);
  }
  // Get the dayLight
  Boolean getDayLight() {
    return Boolean.valueOf(tDayLight);
  }
  // Get the skyColor
  int getSkyColorR() {
    return Integer.parseInt(tSkyColorR);
  }
  int getSkyColorB() {
    return Integer.parseInt(tSkyColorB);
  }
  int getSkyColorG() {
    return Integer.parseInt(tSkyColorG);
  }

 int getSkyBright() {
     return Integer.parseInt(tSkyBright);
   }

  // Get the temperature
  float getTemp() {
    return Float.parseFloat(tTemp);
  }

  // Get the weather
  String getWeather() {
    return tCondition;
  }

  // Get weather's wind speed. All of it!
  float getWindSpeed() {
    return Float.parseFloat(tWindSpeed);
  }
}

