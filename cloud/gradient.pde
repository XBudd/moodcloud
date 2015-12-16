int[] moodArray = new int[24];

void setGradient(int x, int y, float w, float h, color c1, color c2 ) {
  noStroke();
  for (int i = x; i <= x+w; i++) {
    float inter = map(i, x, x+w, 0, 1);
    color c = lerpColor(c1, c2, inter);
    fill(c);
    rect(i, y, 1, h);
  }
}

void newMood(int m) {
  moodArray = subset(moodArray, 1);
  moodArray = append(moodArray, m);
  //println(moodArray);
}

void drawGradient() {
  for (int i=0;i<24;i++) {
    if ( moodArray[i] > 0 ) {
      //sets the reesidual bars - needed for continued effect
     setGradient(0, i, 90, 1, colorArray[(moodArray[i]-1)*2], colorArray[(moodArray[i]-1)*2+1]);
     setGradient(90, i, 90, 1, colorArray[(moodArray[i]-1)*2+1], colorArray[(moodArray[i]-1)*2]);
    }
  }
}

