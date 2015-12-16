ArrayList<CloudAni> clouds;

float xoff = 0.0;
float yoff = 200.0;



class CloudAni {
  float x;
  float y;
  float s;

  CloudAni() {
    x = random(width);
    y = random(height);
    s = 30 + random(30);
  }

  void setX(float X) {
    x = X;
  }

  void setY(float Y) {
    y = Y;
  }

  float getX() {
    return x;
  }

  float getY() {
    return y;
  }

  float getS() {
    return s;
  }

  void update() {
    if (y<-s/4) {
      s = 30 + random(30);
      y = height+s/4;
      x = random(width);
    } 
    if (y>height+s/4) {
      s = 30 + random(30);
      y = -s/4;
      x = random(width);
    } 
    if (x<0) x+=width;
    if (x>width) x-=width;

    // Drawing Cloud.
    noStroke();
    fill(150, 150, 150, cloudDensity);
    for (float i=s; i>0; i-=2) {
      ellipse(x, y, i, i/2);
    }
    if (x<s/2) {
      for (float i=s; i>0; i-=2) {
        ellipse(x + width, y, i, i/2);
      }
    }
    if (x>width-(s/2)) {
      for (float i=s; i>0; i-=2) {
        ellipse(x - width, y, i, i/2);
      }
    }
  }
}

void updateCloudAni() {
  xoff = xoff + .001;
  yoff = yoff + .001;

  for (int i = 0; i < clouds.size (); i++) {
    CloudAni cloud = clouds.get(i);
    cloud.setX(cloud.getX() + (noise(xoff)-0.5)/cloud.getS()* 10 * windSpeed);
    cloud.setY(cloud.getY() + (noise(yoff)-0.5)/cloud.getS()* 2 * windSpeed);
  }

  for (int i = 0; i < clouds.size (); i++) {
    CloudAni cloud = clouds.get(i);
    cloud.update();
  }
}

void resetPositions() {
  for (int i = 0; i < clouds.size (); i++) {
    CloudAni cloud = clouds.get(i);
    cloud.setX(random(width));
    if(random(1) > 0.5) cloud.setY(-100);
    else cloud.setY(height+100);
  }
}
