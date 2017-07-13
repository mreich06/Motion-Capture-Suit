/**
 * Created by C. Andrews on 6/2/17.
 * Edited by Maya Reich from 7/5-8/4
 */
 
import java.net.SocketException;
import punktiert.math.Vec;
import punktiert.physics.*;

PVector center = new PVector(0, 0);

PVector current = new PVector(0, 0);
float currentScale = 1;
float angle = 0;

VPhysics physics;

// attractor
BAttraction attractor;

int maxParticles = 200;


final int PORT = 9763;


class Body{
 final static  int PELVIS = 1, L5 = 2, L3 = 3, T12 = 4, T8 = 5;
 final static int NECK = 6, HEAD = 7;
 final static int RIGHT_SHOULDER = 8, RIGHT_UPPER_ARM = 9, RIGHT_FORE_ARM = 10, RIGHT_HAND = 11;
 final static int LEFT_SHOULDER = 12, LEFT_UPPER_ARM = 13, LEFT_FORE_ARM = 14, LEFT_HAND = 15;
 final static int RIGHT_UPPER_LEG = 16, RIGHT_LOWER_LEG = 17, RIGHT_FOOT = 18, RIGHT_TOE = 19;
 final static int LEFT_UPPER_LEG = 20, LEFT_LOWER_LEG = 21, LEFT_FOOT = 22, LEFT_TOE = 23;

}


MocapServer server;

void setup(){
  size(1024, 1024);
  background(0);
  currentScale = width/6;
  center = new PVector(width/2, height/2);
 
  try{
    server = new MocapServer(PORT);
    server.start();
  } catch(SocketException se){
    se.printStackTrace();
  }
  noStroke();
  
  physics = new VPhysics();

  //AttractionForce: (Vec position, radius, strength)
  attractor = new BAttraction(new Vec(0,0), 0.5, 0);
  physics.addBehavior(attractor);

//create randomly placed particles
  for (int i = 0; i < maxParticles; i++) {
    float radius = random(0.01, 0.05);
    // vector for position- place somewhere on screen 
    Vec position = new Vec(random(-3, 3), random(-3,3));
    // create particle (Vec pos, mass, radius)
    VParticle particle = new VParticle(position, 5, radius);
    // make particles collide
    particle.addBehavior(new BCollision());
    // add particle to world
    physics.addParticle(particle);
  }
  
  
}


int frame = 0;
void draw() {
  background(0);
  float red, green, blue;
  red = 50;
  green = 100;
  blue = 100;
  
  
  
  translate(center.x, center.y);
  scale(currentScale);
  rotate(angle);
  //translate(width/2, height/2);
  //scale(width/6, height/6);

  if (server.pose != null){
     QuaternionSegment left = server.pose.segments[Body.LEFT_FOOT];
     QuaternionSegment right = server.pose.segments[Body.RIGHT_FOOT];
     float size = max(0, 0.2-left.y);
     
     red = abs(red-(20*left.x));
     blue = abs(blue+(30*left.x));
     fill(red, green, blue,10);
     ellipse(left.x, left.z, size, size);
     red = abs(red+(20*left.x));
     blue = abs(blue+(30*left.x));
      //green = abs(green+(20*left.x));
     fill(red, green, blue, 50);
     ellipse(right.x, right.z, 0.1, 0.1);
  
     physics.update();
     //have attractor set to right foot location
     attractor.setAttractor(new Vec(right.x, right.z)); 
     //particles repel from feet
     attractor.setStrength(-0.0001); 
     noFill();
     ellipse(attractor.getAttractor().x, attractor.getAttractor().y, attractor.getRadius(), attractor.getRadius());
  
    fill(255, 255);
    //draw particles
    for (VParticle p : physics.particles) {
      ellipse(p.x, p.y, p.getRadius() * 2, p.getRadius() * 2);
    }  
  }
}

//be able to change current view by dragging mouse around
void mousePressed() {
  current.x = mouseX;
  current.y = mouseY;
}


void mouseDragged() {
  if (mouseButton == LEFT) {
    center.x += mouseX - current.x;
    center.y += mouseY - current.y;
  }else{
    float hypotenuse = dist(0,0,mouseX- center.x, mouseY - center.y);
    if (mouseY - center.y < 0){
      angle = -acos((mouseX- center.x)/hypotenuse);
    }else{
    angle = acos((mouseX- center.x)/hypotenuse);
    }
  }

  current.x = mouseX;
  current.y = mouseY;
}

void mouseWheel(MouseEvent event) {
  float val = event.getCount();
  if (val > 0) {
    currentScale = currentScale * (1.1 );
  } else if (val < 0) {
    currentScale = currentScale * (.9 );
  }
}