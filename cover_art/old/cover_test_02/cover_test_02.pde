/// generate a stack of cut up images

PGraphics pg;

// cover size of an norelco box sleeve (outer sleeve of a cassette) is 101 x 65.33 mm -> at 300 dpi ~
int cardWidth = 1190;
int cardHeight = 770;

// Size of the slits when slicing the image and creating the mask
// This needs to be a multiple of the cardWidth
int slitSize = 5; 
float slitSizeSlant = 1.25 * slitSize * sqrt(2);
float slitOffset = 1.0 * slitSizeSlant + 1.95;

// The input images
// Three are used here but it can be more
String[] files = {
  "spiral_01.png",
  "spiral_02.png",
  "spiral_03.png"
};


PImage[] images = new PImage[files.length];
// The cut up image
PImage backgroundImage; 
PImage base_img;

void setup() {
  size(1190, 770);
//  backgroundImage = createBackgroundImage();
  pg = createGraphics(1190, 770); 
}


void draw() {

//  image(backgroundImage, 0, 0);
  //pushMatrix();  
  //translate(slitOffset, 0);
  drawMask();
  save("mask.png");
  //popMatrix();
  
}

/* Draw the foreground mask */
void drawMask() {

  int repeat = (cardWidth / slitSize)  / files.length+1;
  repeat *= 1.25;
  noStroke();
  fill(155,23,27);

  float x = 0;
  float maskWidth = slitSize * (files.length-1);
  for (int i=0; i<repeat; i++) {  
    pushMatrix();
    translate(x, 0); 
    rotate(HALF_PI*0.4);
    rect(0, -10, maskWidth, height*1.5);    
    x += slitSizeSlant * (files.length);
    popMatrix();
  } 
}


//void maskImage(){
//// apply the mask to an image

//base_img = loadImage("spiral_01.png");
//PImage mask_img = drawForeground()
//return base_img.mask(mask_img);


//}
