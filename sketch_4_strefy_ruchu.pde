import processing.video.*;
  Capture video;
  PImage prevFrame;
  float threshold = 50;

  void setup() {
    size(640, 480);
    video = new Capture(this, width, height, 30);
    video.start();
    prevFrame = createImage(video.width, video.height, RGB);
  }
 
  void captureEvent(Capture video) {
    prevFrame.copy(video, 0, 0, video.width, video.height, 0, 0, video.width, video.height); // Before we read the new frame, we always save the previous frame for comparison!
    prevFrame.updatePixels(); 
    video.read();
  }
 
  void draw() {
    boolean LG = false;
    boolean PG = false;
    boolean LD = false;
    boolean PD = false;
    image(video, 0, 0);
    loadPixels();
    video.loadPixels();
    prevFrame.loadPixels();
   
 
    for (int x = 0; x < 320; x ++ ) {
      for (int y = 0; y < 240; y ++ ) {
 
  int loc = x + y*video.width;           
  color current = video.pixels[loc];      
  color previous = prevFrame.pixels[loc]; 
 
  float r1 = red(current); 
  float g1 = green(current); 
  float b1 = blue(current);
  float r2 = red(previous); 
  float g2 = green(previous); 
  float b2 = blue(previous);
  float diff = dist(r1, g1, b1, r2, g2, b2);
 
  if (diff > threshold) { 
    
    pixels[loc] = color(125,0,125);
    LG = true;
  } else {
    
    //pixels[loc] = color(255);
  }
}
}
    
    for (int x = 320; x < 640; x ++ ) {
      for (int y = 0; y < 240; y ++ ) {
 
  int loc = x + y*video.width;            
  color current = video.pixels[loc];      
  color previous = prevFrame.pixels[loc]; 
 
  
  float r1 = red(current); 
  float g1 = green(current); 
  float b1 = blue(current);
  float r2 = red(previous); 
  float g2 = green(previous); 
  float b2 = blue(previous);
  float diff = dist(r1, g1, b1, r2, g2, b2);
 
  if (diff > threshold) { 
   
    pixels[loc] = color(0,255,0);
    PG = true;
  }
 }
}
  
  for (int x = 0; x < 320; x ++ ) {
      for (int y = 240; y < 480; y ++ ) {
 
  int loc = x + y*video.width;            
  color current = video.pixels[loc];      
  color previous = prevFrame.pixels[loc]; 
 
  
  float r1 = red(current); 
  float g1 = green(current); 
  float b1 = blue(current);
  float r2 = red(previous); 
  float g2 = green(previous); 
  float b2 = blue(previous);
  float diff = dist(r1, g1, b1, r2, g2, b2);
 
  if (diff > threshold) { 

    pixels[loc] = color(255,0,0);
    LD = true;
  }
  }
  }
  
  for (int x = 320; x < 640; x ++ ) {
      for (int y = 240; y < 480; y ++ ) {
 
  int loc = x + y*video.width;            
  color current = video.pixels[loc];      
  color previous = prevFrame.pixels[loc]; 

  float r1 = red(current); 
  float g1 = green(current); 
  float b1 = blue(current);
  float r2 = red(previous); 
  float g2 = green(previous); 
  float b2 = blue(previous);
  float diff = dist(r1, g1, b1, r2, g2, b2);
 
  
  if (diff > threshold) { 
   
    pixels[loc] = color(0,0,255);
    PD = true;
  }
      }
  }
    

    updatePixels();
    
    if(LG==true){
      fill(255,225,0);
      textSize(14);
      text("Ruch w lewym górnym rogu.",20,20);
    }
    if(PG==true){
      fill(255,225,0);
      textSize(14);
      text("Ruch w prawym górnym rogu.",420,20);
    }
    if(LD==true){
      fill(255,225,0);
      textSize(14);
      text("Ruch w lewym dolnym rogu.",20,450);
    }
    if(PD==true){
      fill(255,225,0);
      textSize(14);
      text("Ruch w prawym dolnym rogu.",420,450);
    }
  }