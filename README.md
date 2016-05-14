
# Welcome to *weather&commat;mood.cloud*
## Introduction
**weather@mood.cloud** is a yearlong project created and developed by **Colin Budd** (BFA ’16 & BA ’16) at **Cornell University** with the assistance and guidance of **Professor David Mimno** (Information Science).

Located prominently in the entrance of Gates Hall at Cornell University, the installation reflects current weather conditions on campus using a combination of colors and animations.

This work is built using Processing 2.2.1 and run via an Intel IoT microcomputer connected to a Teensy 3.0 module and 24 WS2811 LED bands.

All code and resources can be found via this repository with inline comments and overview documentation (below) available to assist in exploration and innovation.

##### Current Release:

- v2.2 - May 14, 2016

##### Press:

- http://infosci.cornell.edu/news/hacking-gates-hall-mood-cloud

##### External Resources:

- https://processing.org
- http://learningprocessing.com/examples
- https://www.pjrc.com/teensy
- http://www.pjrc.com/teensy/td_libs_OctoWS2811.html
- https://www.wunderground.com

----------
## Documentation

#### Cloud.pde [main sketch]
 
> Controls the functionality of LED strands, displayiing obtained weather inforamtion through visually symbolic representations.

##### 1. Cloud

- ##### setup()
    - Sets up canvas which is equivalent to size of LED strips laid out flat
    - rt establishes the **readTable()** functionality, gathering information from our csv file containing current weather information parsed from WeatherUnderground’s API
    - **windSpeed** is established as a mapped value from the current numerical value of wind speed measurement (between 0 and 100) and is mapped between 3 and 60 to control how fast the “cloud” animation moves
    - **skyBright** gets the sky brightness directly from our table
    - **cloudDensity** is the brightness at which the LEDs display. Set to equal skyBright so that the mood.cloud responds to outside brightness (useful for day vs. night viewing)
    - **testWithOutTeensy**
        - existing code 
        - Teensy is the LED control hardware
    - **anis** loads the animation in a new array
        - useful for multiple animations beyond just the movement of clouds
    - **clouds**
        - set the cloud shapes in an array and create new clouds up to certain amount
    - **reset positions**
        - useful for staring canvas in blank fashion before running draw
    - **colorArray** represents pre-programme arrays of color that can be used for generating colors using the LEDs, even with the press of a numerical key
    
- ##### draw()
    - Every five minutes , read the table using **rt.getTable**
    - set brightness of LEDs (cloudDensity) using **skyBright**
    - **drawGradient()**
        - updates background to given color — such as black
    - **updateAni()**
        - updates animations with new data/colors
        
- ##### keyPressed()

    - allow manual input of color through use of numerical code
    - adds colors to anis array
  
- ##### mouseClicked()
    - triggers manual refresh of table data, windspeed, and cloudDensity (LED brightness)
    
--------
#### 2. ani

- class for animating the background (LED strip) effects
- Can pass Ani a color and mood
- displays this information on sketch canvas

------
#### 3. cloudAni

- class for cloud animations (the movement of “cloud” blobs)
- ArrayList type CloundAni called “clouds” holds all cloud info
- class **CloudAni()** has values x, y, and s
    - **x** is a random value taken from 0 to width
    - **y** is a random value taken from 0 to height
    - **s** is a random value between 30 and 60 — how many to make
- **fill** is set to the colors derived from the **readTable** based on sky color or conditions outside
- ellipses are created to represent the clouds using the x value and y value

- #####  updateCloudAni()
    - updates positions of clouds to create movement on screen
    - increases x and y values by certain increment based on current **windSpeed** value
    
- ##### resetPositions()
    - resets the positions of the clouds to clear the scene
    
------
#### 4. gradient
- function for creating and maintaining the background gradient
- created and used for the original mood.cloud and still maintains some use in weather@mood.cloud for creative explorations such as perseverance of colors.
- **moodArray** is int array of 24 “moods” representing each possible LED strand (of which there are 24)

- #####  setGradient()
    - blends the colors and holds their position within the bands as an overlay
    - pass in x, y, w, h, c1, and c2 values
    - int **x** = x position
    - int **y** = y positon
    - float **w** = width
    - flat **h** = height
    - color **c1** = first color
    - color **c2** = second color
    
- #####  newMood()
    - This creates the persistence of colors over long durations, with each color holding its place and moving up one band when new mood (color) is introduced
    - Commented out as it did not fit aesthetic of current weather@mood.cloud build but is useful for future explorations
    - pass in int m
    
- #####  drawGradient()
    - for each LED band, set the new gradient (array of colors)
    - Only necessary when using persistence effect
    
------
#### 5. ledControl
- OcotWS2811 movie2serial.pde
- Directly used without modification for the control of Teensy 3.0 boards
- Transmits what is “seen” on canvas to an adapted representation which control each LED individually. 
- Useful here for the creation of warps and movement.
- More information within source code or online:
    - www.pjrc.com/teensy/td_libs_OctoWS2811.html
  
------
#### 6. readTable

- Accesses a table stored as .csv containing weather data parsed using separate sketch, cloud_online_resources.pde
- This is how the sketch access current weather data without significant lag

- ##### getTable()
    - loads the .csv file
    - reads data from table headers
    
------
-----

#### cloud_online_resources.pde [secondary sketch]
##### Overview
- Extracts and parses data from WeatherUnderground’s site using weathervane located on Cornell’s campus. Basic data includes: wind speed, temperature, and current conditions.
- Using a crop from Cornell’s live campus camera, extract information such as average color and average brightness of the sky.
- This information, along with current conditions, are then used to determine the color to display using the LEDs - either current sky color or, in certain conditions, a more visual representation of the current weather condition.
- This information is then saved to an easily accessible .csv file


##### 1. cloud_online_resources

- ##### contourSize()
    - compares images to determine which has more contours (distinguishable edges)
    - Useful in determining if web camera crop is focusing on the sky (what we want - simplistic, few contours) or building (not what we want to sample - complicated, more contours)
    
- ##### setup()
    - create small canvas to represent visually the sketch results
    - starts new **WeatherGrabber**, **wg**, pointed to Ithaca weather at zip code 14850
    - starts new **skyColor**, **sc**, and finds current **skyColor** upon start
    
- ##### draw()
    - every five minutes, write new file with information to .csv
    - sets background color of sketch to extracted sky color
    
- ##### writeFile()
    - writes the information extracted from Weather Underground to a local .csv file as a table
    - this information includes the current:
        - hour
        - minute
        - weather condition
        - temperature
        - wind speed
        - day light (based on whether the sun is up or set)
            - Note: not used in latest versions of weather@mood.cloud but useful for future explorations
        - average sky color (red, blue, and green values)
        - average sky brightness
        
- ##### mouseClicked()
    - useful for manually testing the functionality
    - gets current weather conditions and writes to .csv file
    
- ##### requestData()
    - sets loads the online data needed from Weather Underground’s specific page for the Ithca-based weathervane
        - **Note:** as of 4/2/16, using local Ithaca weathervane and not the original Cornell weathervane above Tjaden Hall due to frequent downtime experienced by the Cornell weathervane.
    - Loads this data as xml to parse
    
------
##### 2. skyColor
> class which loads live image from Cornell’s Live Cam above Ho Plaza, crops to a corner containing just sky, averages the pixels, and then extracts an average color and brightness based on this data to represent the current skyBright and skyColor

- ##### getEvenOdd()
    - used to determine if the live Cornell Cam is more often displaying the full view containing sky on even or odd minutes since not a standard interval aligning to internal clock
    
- ##### weatherGetter()

    - **wgDayLightBool** - pass in day light boolean (is it day or night)
    - **wgCondition** - pass in current weather conditions from Weather Underground
    - **wgTemp** - pass in current temperature from Weather Underground
   
- #####  findSkyColor()

    - loads the current image from Cornell’s Live Cam
    - crops image to area containing only the sky
    - samples pixels from this crop and generates an average color set to **skyColor** (of type color)
    - the average brightness of this color is set as **skyBright**
    - Contour Comparison
        - Note: due to unaligned timing of Cornell Live Cam switching between a full view including sky and a zoomed view only focusing on a walkway without sky, measures are needed to only extract data when the correct view containing sky is loaded.
        - By comparing contours using **OpenCV for Processing**, can obtain sense of whether current view’s crop is of the more complex (and thus more full of contours) zoomed in view on a building or of the more simplistic (and thus containing less contours) crop of sky.
    - **skyColor** obtained is then passed through **weatherColor** which will change or maintain color found depending on current conditions.
   
- ##### weatherColor()
    - Used to change/modify/maintain **skyColor** based on current conditions taken from Weather Underground. 
    - Certain conditions modify the **skyColor** while others will completely change it, such as a sunny day. This is to introduce more variability in the colors displayed on the mood.cloud and better reflect an emotive visual representation of current conditions than one merely based on current sky color.
    - Pass in color value, **colorVal**
    - **Conditions and Changes**
        - **Mostly Cloudy or Partly Cloudy**
            - slightly decrease saturation and brightness
        - **Cloudy or Fog**
            - fade current colors to be less saturated
        - **Sunny**
            - Override sky colors and display orange
        - **Snow**
            - Override sky colors and display pure white
        - **Other (Overcast, Unknown, Clear, etc.)**
            - Maintain obtained sky color from Cornell Live Camera sample
    - Sets and returns RGB color value
    
- #####  getAverageColor()
    - pass in PImage
    - used to analyze the crop taken from Cornell Live Cam
    - obtains average color
    
- ##### getAverageBright()

    > **Note:** code obtained from: forum.proessing.org/two/discussion/3270/how-to-get-pixel-intensity-not-brightness
    
   - pass in color
    - Using the average color as a basis, finds the luminous value of the color and then maps to a luminous range, **luminRange**, on scale of 1 to 10 so as to create an easily accessible range of brightnesses for the LEDs to use (through **cloudDensity**)
    - returns the **luminRange**
  
------
##### 3. weatherGrabber

> Based on Daniel Shiffman’s “Example 18-5” found on: www.learningprocessing.com — see page for more information.

- Class for obtaining weather data through the parsing of Weather Underground’s site specific page for a given location/weathervane.


- ##### getDayLight()
    - using the predicted sunrise and sunset times from Weather Underground, determines if the current hour and minute exists before, during, or after sunrise or sunset.
        - if in-between sunrise and sunset, it is daytime.
        - If after sunset and before sunrise, it is nighttime.
        
    > **Note:** this is not the prettiest way of coding this logic, but was a fun experiment done on the fly! Maintained for future exploration but is no longer incorporated into main functionality of weather@mood.cloud

- ##### requestWeather()
    - makes the XML request and pulls in information from the given weathervane (as specified in URL)
    
        - **Note:** here, using a local Ithaca weathervane due to a series of issues in operation of Cornell’s weathervane during April, 2016
        
    - Parses the xml of the site for specified words or phrases and returns the characters contained from that given string to another given string — here, a comma, as set by **end** and run through **giveMeTextBetween**
    
- ##### giveMeTextBetween()

    - pass in String **s**, String **before**, String **after**
        - **s** is the start of the string
        - **before** is the collection character to look for, such as “wind speed:”
        - **after** is the end position of string
    - Goes through body of text to find specified strings and then produces their returned values or a blank string if not found
