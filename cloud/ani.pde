/* Class for animation of background (LED strip) effects */
class Ani {
  PImage ani;
  int f;
  color c;
  int m;

  Ani(color clr,int mood) {
    ani = loadImage("cloudAni.png");
    f = 0;
    c = clr;
    m = mood;
  }

  void update() {
    tint(c);
    image(ani, 0, f*-24);
    if (f*24 < ani.height) f++;
    if (f==24) {
      newMood(m);
      lastInteractionMillis = millis();
      resetPositions();
    }
    tint(255);
  }
  
  
  int getF() {
    return f;
  }

  int getM() {
    return m;
  }
}

void updateAni() {
  for (int i = 0; i < anis.size() ; i++) {
    Ani ani = anis.get(i);
    ani.update();
  }
  for (int i = anis.size()-1; i >= 0; i--) {
    Ani ani = anis.get(i);
    if (ani.getF() > 59) anis.remove(i);
  }
}
