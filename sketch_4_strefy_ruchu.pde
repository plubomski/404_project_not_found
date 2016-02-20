import processing.video.*;
import controlP5.*;
  Capture video;
  ControlP5 cp5;
  PImage prevFrame;
  float threshold = 50;
  boolean toggleValue;

  void setup() {
    size(640, 480);
    video = new Capture(this, width, height, 30);
    video.start();
    prevFrame = createImage(video.width, video.height, RGB);
    
    cp5 = new ControlP5(this);
  
  cp5.addToggle("toggleValue").setPosition(20,25).setSize(70,30)
  .setCaptionLabel("Wykrywaj ruch")
  .setColorBackground(color(255,0,0))
  .setColorForeground(color(0,0,255))
  .setColorActive(color(0,255,0));
  }
 
  void captureEvent(Capture video) {
    prevFrame.copy(video, 0, 0, video.width, video.height, 0, 0, video.width, video.height);
    prevFrame.updatePixels(); 
    video.read();
  }
 
  void draw() {
    if(toggleValue==true){ //to je od interfejsu, else do tego jest na samym dole i przy else program jest nieaktywny, taka ekstrawagancja
    boolean LG    = false;
    boolean PG    = false;
    boolean LD    = false;
    boolean PD    = false;
    image(video, 0, 0);
    loadPixels();
    video.loadPixels();
    prevFrame.loadPixels();
   
 
    for (int x = 0; x < 250; x ++ ) {
      for (int y = 0; y < 150; y ++ ) {  //warunek dla lewego górnego rogu i reszta analogicznie, pewnie da sie prosciej zeby nie powtarzac tyle kodu 4 razy
 
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
  } 
}
}
    
    for (int x = 390; x < 640; x ++ ) {
      for (int y = 0; y < 150; y ++ ) {
 
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
  
  for (int x = 0; x < 250; x ++ ) {
      for (int y = 330; y < 480; y ++ ) {
 
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
  
  for (int x = 390; x < 640; x ++ ) {
      for (int y = 330; y < 480; y ++ ) {
 
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
      textSize(16);
      text("Ruch w lewym górnym rogu.",10,20);
    }
    if(PG==true){
      fill(255,225,0);
      textSize(16);
      text("Ruch w prawym górnym rogu.",400,20);
    }
    if(LD==true){
      fill(255,225,0);
      textSize(16);
      text("Ruch w lewym dolnym rogu.",10,450);
    }
    if(PD==true){
      fill(255,225,0);
      textSize(16);
      text("Ruch w prawym dolnym rogu.",400,450);
    }
  }
  else{
  background(0);
  fill(255);
  textSize(15);
  text("Kliknij na czerwony prostokąt, aby rozpocząć wykrywanie ruchu.",125,50);
  }
  }
