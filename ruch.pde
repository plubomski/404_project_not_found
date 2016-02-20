import processing.video.*;
import controlP5.*;
Capture video;
ControlP5 cp5;
PImage prevFrame;
float threshold = 50;
boolean toggleValue;

void setup() {
  size(640, 480);

  video = new Capture(this, width, height);
  video.start();
  prevFrame = createImage(video.width, video.height, RGB);
  cp5 = new ControlP5(this);
  
  cp5.addToggle("toggleValue").setPosition(20,20).setSize(70,30)
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
 if(toggleValue == true){
  background(0);
  image(video, 0, 0);
  video.loadPixels();
  prevFrame.loadPixels();

  float totalMotion = 0;

  for (int i = 0; i < video.pixels.length; i ++ ) {
   
    color current = video.pixels[i];
    color previous = prevFrame.pixels[i];

    float r1 = red(current); 
    float g1 = green(current);
    float b1 = blue(current);
    float r2 = red(previous); 
    float g2 = green(previous);
    float b2 = blue(previous);

    float diff = dist(r1, g1, b1, r2, g2, b2);
    
    totalMotion += diff;
  }

  float avgMotion = totalMotion / video.pixels.length; 

  if(avgMotion > 5){
  noStroke();
  fill(255);
  textSize(5+avgMotion);
  text("Wykryto ruch!",15,460);
}
}
else{
  background(0);
  text("Kliknij na czerwony prostokąt, aby rozpocząć wykrywanie ruchu.",125,50);
}
}