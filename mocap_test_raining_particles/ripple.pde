class ripple {
  float radius, alpha, x, y;
  boolean clicked = false; //mouse not yet clicked
  
  void location(float xLoc, float yLoc) {
    radius = 0;
    x = xLoc;
    y = yLoc;
    clicked = true;
  }
  
  void fade() {
    radius += 1;
    //alpha += g*10;

    
    //when ripple is too big, make it disappear
    if (radius > 200) {
      alpha = 0;
    }
  }
  
  void show() {
    if (clicked == true) {
    rect(0,0, width, height);
    strokeWeight(3);
    stroke(0, 250, 250);
    fill(0, 200, 200, alpha);
    ellipse(x, y, radius*2, radius*2);
    strokeWeight(2);
    ellipse(x, y, (radius*2)+20, (radius*2)+20);
    strokeWeight(1);
    ellipse(x, y, (radius*2)+30, (radius*2)+30);
    
  }
}
}