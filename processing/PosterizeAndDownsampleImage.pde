// PosterizeAndDownsampleImage

/*
POSTERIZE and DOWNSAMPLE IMAGE
 Jeff Thompson
 February 2012
 
 Divides the image's color into discreet steps using the pixel's brightness.
 
 www.jeffreythompson.org
 */

// pxSize is resulting pixel size
void pixelateImage(PImage p, int pxSize) {
 
  // use ratio of height/width...
  float ratio;
  if (width < height) {
    ratio = height/width;
  }
  else {
    ratio = width/height;
  }
  
  // ... to set pixel height
  int pxH = int(pxSize * ratio);
  
  noStroke();
  for (int x=0; x<width; x+=pxSize) {
    for (int y=0; y<height; y+=pxH) {
      fill(p.get(x, y));
      rect(x, y, pxSize, pxH);
    }
  }
}

void posterizeImage(PImage p, int rangeSize) {
  // the built-in filter(POSTERIZE) works ok, but this is a bit more tweakable...  
  // iterate through the pixels one by one and posterize
  p.loadPixels();
  for (int i=0; i<pixels.length; i++) {

    // divide the brightness by the range size (gets 0-rangeSize), then
    // multiply by the rangeSize to step by that value; set the pixel!
    int bright = int(brightness(pixels[i])/rangeSize) * rangeSize;
    pixels[i] = color(bright);
  }
  updatePixels();
}
