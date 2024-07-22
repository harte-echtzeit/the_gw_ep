// adapted from -->

////////////////////////////////////////////////////
//
// Moiré Card by Karl D.D. Willis.
//
// This source code is released under the GNU General Public License
// Copyright © 2012 Karl D.D. Willis. 
//
////////////////////////////////////////////////////


// cover size of an norelco box sleeve (outer sleeve of a cassette) is 101 x 65.33 mm -> at 300 dpi ~
int cardWidth = 1190;
int cardHeight = 770;

// Size of the slits when slicing the image and creating the mask
// This needs to be a multiple of the cardWidth
int slitSize = 10; 
float slitSizeSlant = slitSize * sqrt(2);
float slitOffset = 1.0 * slitSizeSlant + 1.95;


//// The input images
//// Three are used here but it can be more
//String[] files = {
//  "01.png", 
//  "02.png", 
//  "03.png"
//};

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

void setup() {
  size(1190, 770);
  backgroundImage = createBackgroundImage();
 
}

void draw() {

  image(backgroundImage, 0, 0);
  pushMatrix();  
  translate(slitOffset, 0);
  drawForeground();
  popMatrix();
  
}

/* Draw the foreground mask */
void drawForeground() {

  int repeat = (cardWidth / slitSize)  / files.length+1;
  repeat *= 1.25;

  noStroke();
  fill(155,23,27);

  float x = 0;
  float maskWidth = slitSize * (files.length-1);
  for (int i=0; i<repeat; i++) {  
    pushMatrix();
    translate(x, 0); 
    rotate(HALF_PI*0.5);
    rect(0, -10, maskWidth, height*1.5);    
    x += slitSizeSlant * (files.length);
    popMatrix();
  }
}

/* Create and return the cut up background image */
PImage createBackgroundImage() {

  for (int i=0; i<images.length; i++) {
    images[i] = loadImage(files[i]);
  }

  PImage moireImage = createImage(images[0].width, images[0].height, RGB);

  int count = 0;
  int xStep = 0;

  for (int y=0; y<moireImage.height; y++) {
    for (int x=0; x<moireImage.width; x++) {

      int index = (int)((x + xStep) / slitSizeSlant) % images.length;
      moireImage.pixels[count] = images[index].pixels[count];
      count++;
      
    }
    xStep = y;
  }

  moireImage.updatePixels();
  return  moireImage;
}



void keyPressed() {
  if (keyCode == RIGHT) {
    slitOffset += slitSizeSlant;
  } 
  else if (keyCode == LEFT) {
    slitOffset -= slitSizeSlant;
  }
 
}
