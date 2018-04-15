import controlP5.*;
import processing.video.*;

Capture cam;
String artStr;
PFont f;

void setup() {
  println("starting...");
  size(900, 900);
  println("init font...");
  f = loadFont("Monospaced-8.vlw");
  fill(255);
  String[] cameras = Capture.list();  
  println("camera list is long:" + cameras.length + "...");
  if (cameras.length == 0) {
    println("There are no cameras available for capture.");
    exit();
  } else {
    println("Camera:");
    for (int i = 0; i < cameras.length; i++) {
      println(cameras[i]);
    }
    cam = new Capture(this, cameras[10]);
    cam.start();     
  }
}//end setup

void draw() {
 
  background(0);
 // image(cam, 700, 0);
  if (cam.available() == true) {
    cam.read();
    cam.filter(GRAY);
    cam.loadPixels();
    artStr = "";
    
    for (int i = 0; i < cam.pixels.length; i++) {
      color c = cam.pixels[i];    
      int gray = (c) &0x0ff;
      
      if (gray >= 0 && gray < 30) {
        artStr = artStr + " ";
      } else if (gray >= 0 && gray < 71) {
        artStr = artStr + ".";
      } else if (gray >= 71 && gray < 170  ) {
        artStr = artStr + "L";
      } else {
        artStr = artStr + "@";
      }
    
      if( (i%160) == 0){
        artStr = artStr + "\n";
      } 
    }
  } // end if cam available
  if (artStr != null) {  
    textFont(f);     
    text(artStr,0,0);
  }
}

/*
  questo codice l'ho sostituito con :
  cam.filter(GRAY);
  
  in pratica caricava i pixel, li spacchettava in 
  tre variabili, r g b con il valore espresso da 0 a 255
  sommava r a g a b e divideva per 3 in modo da ottenere 
  un valore medio del colore in modo da poter poi formare 
  un grigio andando a mettere i 3 valori uguali e riscrivenoli 
  sui pixel. ma non serve fare questo giro del cazzo, bastava 1
  sola riga!

*/
/* 
  cam.loadPixels();
  for (int i = 0; i < cam.pixels.length; i++) {
    color c = cam.pixels[i];
    
    int r = (c >> 16) &0x0ff;
    int g = (c >> 8) &0x0ff;
    int b = (c) &0x0ff;
    //int rgb = ((r&0x0ff)<<16)|((g&0x0ff)<<8)|(b&0x0ff);
    //println("r " + r + " g " + g + " b " + b + " rgb " + rgb);
    
    int gray = (r + g + b) / 3; 
    int newrgb = ((gray &0x0ff)<<16)|((gray &0x0ff)<<8)|(gray &0x0ff);
    cam.pixels[i] = newrgb;
    
  }
  //cam.updatePixels();
  
  image(cam, 0, 0);
  */
