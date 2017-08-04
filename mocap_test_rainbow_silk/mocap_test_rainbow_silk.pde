/**
 * Created by C. Andrews on 6/2/17.
 * Edited by Maya Reich from 7/5-8/4
 */
 
 //have view be from bottom of feet. scale x and z so feet fill screen. Feet move in about 6x6 space so do 6/height or 6/width
 //distance of feet from floor could change opacity, color, etc
 //have particle sysetm repulse from feet- when they land, have particles move away. When foot is up, particles settle back
//idea- have lines change color as time passes- keep track of lines in array- create class for lines that keeps track of x and z positions and update rgb values based on frameCount
import java.net.SocketException;

PVector center = new PVector(0, 0);

PVector current = new PVector(0, 0);
float currentScale = 1;
float angle = 0;
float rainbow;
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
  size(1024, 1024, P3D);
  colorMode(HSB);
  background(0);
  currentScale = width/6;
  center = new PVector(width/2, height/2);
   //QuaternionSegment segmentpelvis = pose.segments[Body.PELVIS];
  //camera(100,100,100, segmentpelvis.x, segmentpelvis.y, segmentpelvis.z, 1.0, -1.0, 1.0);
  perspective(PI/6, width/height, 0.5, 100);
 
  try{
    server = new MocapServer(PORT);
    server.start();
  } catch(SocketException se){
    se.printStackTrace();
  } 
  
}


int frame = 0;
void draw() {
  
 

  //background(0);
  //background(0,0,0, transparency); 
  //translate(width/2, height/2, 0);
  //scale(200,-200,200);
  //rotateY(-PI/2);
  
  translate(center.x, center.y);
  scale(currentScale);
  rotate(angle);
  lights();
 
  if (server.pose != null){
     
     QuaternionSegment segmentpelvis = server.pose.segments[Body.PELVIS];
     QuaternionSegment segmenthead = server.pose.segments[Body.HEAD];
      QuaternionSegment leftFoot = server.pose.segments[Body.LEFT_FOOT];
     QuaternionSegment rightFoot = server.pose.segments[Body.RIGHT_FOOT];
     QuaternionSegment rightHand = server.pose.segments[Body.RIGHT_HAND];
     QuaternionSegment leftHand = server.pose.segments[Body.LEFT_HAND];
     println(segmentpelvis.x, segmentpelvis.y, segmentpelvis.z);
     
     //line(leftHand.x, leftHand.z, leftHand.y, rightFoot.x, rightFoot.z, rightFoot.y);
     
     float radius = 10;   
     float angle = frame % 360;
     float camXLoc = radius * cos(radians(angle));
     float camZLoc = radius * sin(radians(angle));
     camera(camXLoc, 0, camZLoc,  segmentpelvis.x, segmentpelvis.z, segmentpelvis.y, 0.0, -1.0, 0.0);
     //camera(6,0,6,  0, 0, 0, 0.0, -1.0, 0.0);
     frame++;
     pushMatrix();
     //draw body at origin instead of translating
     //translate(-segmentpelvis.x, -segmentpelvis.y, -segmentpelvis.z);
     println("segmentpelvis is:", segmentpelvis.x, segmentpelvis.y, segmentpelvis.z);
     drawStick(server.pose); 
     popMatrix();

    noStroke();
    fill(255, 50);


  }

}

void drawConnection(MocapPose pose, int point1, int point2){
  println(point1, point2);
   QuaternionSegment segment1 = pose.segments[point1];
   QuaternionSegment segment2 = pose.segments[point2];
   
   int i = 10;
   f;pat lastx = -999;
   float lastz = -999;
   float znoise = random(10);
   float z;
   
   
   
   line(segment1.x, segment1.y, segment1.z, segment2.x, segment2.y, segment2.z);
}

void drawStick(MocapPose pose){
    QuaternionSegment segment;
    
    //fill(255,0,0);
   
    
    
    // draw head
    //noStroke();
    //segment = pose.segments[Body.HEAD];
    //pushMatrix();
    //translate(segment.x, segment.y, segment.z);
    
    //sphere(0.05);
    //popMatrix();
    
    //line(0, segment.x, 0, segment.y, 0, segment.z);
    
    //segment = pose.segments[Body.RIGHT_HAND];
    //pushMatrix();
    //translate(segment.x, segment.y, segment.z);
    
    // sphere(0.05);
    //popMatrix();
    
    //segment = pose.segments[Body.LEFT_HAND];
    //pushMatrix();
    //translate(segment.x, segment.y, segment.z);
    
    // sphere(0.05);
    //popMatrix();
    
   
     if (rainbow >= 255) {
       rainbow =0;  
     }
     else {
       rainbow++;
     }
     //stroke(rainbow, 255, 255, 10);
    
    // draw shoulders
    //stroke(255, 10);
    //strokeWeight(0.01);
    //drawConnection(pose, Body.RIGHT_SHOULDER, Body.LEFT_SHOULDER);
    
    ////// draw right arm
    //drawConnection(pose, Body.RIGHT_SHOULDER, Body.RIGHT_UPPER_ARM);
    //drawConnection(pose, Body.RIGHT_UPPER_ARM, Body.RIGHT_FORE_ARM);
    //drawConnection(pose, Body.RIGHT_FORE_ARM, Body.RIGHT_HAND);
  
  ////// draw left arm
    //drawConnection(pose, Body.LEFT_SHOULDER, Body.LEFT_UPPER_ARM);
    //drawConnection(pose, Body.LEFT_UPPER_ARM, Body.LEFT_FORE_ARM);
    //drawConnection(pose, Body.LEFT_FORE_ARM, Body.LEFT_HAND);
    
    //// draw body
    //drawConnection(pose, Body.HEAD, Body.NECK);
    //drawConnection(pose, Body.NECK, Body.T8);
    //drawConnection(pose, Body.T8, Body.T12);
    //drawConnection(pose, Body.T12, Body.L3);
    //drawConnection(pose, Body.L3, Body.L5);
    //drawConnection(pose, Body.L5, Body.PELVIS);
    
    //// draw left leg
    //drawConnection(pose, Body.PELVIS, Body.LEFT_UPPER_LEG);
    //drawConnection(pose, Body.LEFT_UPPER_LEG, Body.LEFT_LOWER_LEG);
    //drawConnection(pose, Body.LEFT_LOWER_LEG, Body.LEFT_FOOT);
    //drawConnection(pose, Body.LEFT_FOOT, Body.LEFT_TOE);
    
    //// draw right leg
    //drawConnection(pose, Body.PELVIS, Body.RIGHT_UPPER_LEG);
    //drawConnection(pose, Body.RIGHT_UPPER_LEG, Body.RIGHT_LOWER_LEG);
    //drawConnection(pose, Body.RIGHT_LOWER_LEG, Body.RIGHT_FOOT);
    //drawConnection(pose, Body.RIGHT_FOOT, Body.RIGHT_TOE);
    
    //print(Body.PELVIS);
    
     float dx = pose.segments[Body.RIGHT_FOOT].x - pose.segments[Body.RIGHT_HAND].x;
    float dz = pose.segments[Body.RIGHT_FOOT].z - pose.segments[Body.RIGHT_HAND].z;
    float distance = sqrt(pow(dx, 2) + pow(dz, 2));
    
    println("distance is", distance);
    stroke(255*distance, 255, 255, 10);
    
    drawConnection(pose, Body.RIGHT_FOOT, Body.RIGHT_HAND);
    drawConnection(pose, Body.LEFT_FOOT, Body.LEFT_HAND);
   
    //QuaternionSegment segmentpelvis = pose.segments[Body.PELVIS];
    //print(segmentpelvis.x, segmentpelvis.y, segmentpelvis.z);
    
     
    //distance between two points in 3D space is d = sqrt((x2-x1)^2 + (y2-y1)^2 + (z2-z1)^2)
    //float radius = sqrt(abs(pow((segmentpelvis.x - 500),2) + pow((segmentpelvis.y + 500),2) + pow((segmentpelvis.z - 500),2)));
    //print("radius is", radius);
    
    //float angle = (frameRate/10) % 360;
    //float camXLoc = radius * cos(angle);
    //float camYLoc = radius * sin(angle);
    //camera(camXLoc,-500 ,camYLoc, segmentpelvis.x, segmentpelvis.y, segmentpelvis.z, 1.0, 1.0, 1.0);
    
}


void drawBalls(MocapPose pose){
  noStroke();
  fill(255,255,255);
  for (QuaternionSegment segment:pose.segments){
      if (segment != null){
        float x = segment.x;
        float y = segment.y;
        float z = segment.z;

        pushMatrix();
        translate(x,z,y);
        sphere(.05);
        popMatrix();
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