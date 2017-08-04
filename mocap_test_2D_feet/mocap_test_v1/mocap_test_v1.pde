/**
 * Created by C. Andrews on 6/2/17.
 * Edited by Maya Reich from 7/5-8/4
 */
 
 //have view be from bottom of feet. scale x and z so feet fill screen. Feet move in about 6x6 space so do 6/height or 6/width
 //distance of feet from floor could change opacity, color, etc
 //have particle sysetm repulse from feet- when they land, have particles move away. When foot is up, particles settle back

import java.net.SocketException;
import punktiert.math.Vec;
import punktiert.physics.*;

VPhysics physics;

// attractor
BAttraction attractor;

int maxParticles = 200;
float gravity;

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
 
  try{
    server = new MocapServer(PORT);
    server.start();
  } catch(SocketException se){
    se.printStackTrace();
  }
  noStroke();
  
}


int frame = 0;
void draw() {
  
  translate(width/2, height/2);
  scale(width/6, height/6);

  if (server.pose != null){
     QuaternionSegment left = server.pose.segments[Body.LEFT_FOOT];
     QuaternionSegment right = server.pose.segments[Body.RIGHT_FOOT];
     float size = max(0, 0.2-left.y);
     fill(255, 10);
     ellipse(left.x, left.z, size, size);
     println(left.y);
     ellipse(right.x, right.z, 0.1, 0.1);
  
  }
  

}