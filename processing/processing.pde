PVector origin;

color gold = #fcc205;
color darkgold = #d8a93c;
color goldc = #fcc205;

int w;
float frameRateConst = 5;

PGraphics main;

PImage bgGeneral;

PImage bgCamera;
PImage bgBars;
PImage header;
PImage headerText;
PImage cameraBelow;

PImage[] personColor;
PImage[] personLine;
PImage[] personHighlight;

PImage[] girlColor;
PImage[] girlLine;

PImage[] bg2;

PImage genImg;
PImage[] genOutline;
PImage[] genColor1;
PImage[] genColor2;
PImage[] genColor3;

import micycle.uniformnoise.UniformNoise;
UniformNoise uniformNoise = new UniformNoise();

Filters filters = new Filters();

void setup(){
  size(850, 750); // Note that P3D can interfere with overlapping of 2D shapes!!!
  
  origin = new PVector(width/2, height/2);
   
  uniformNoise = new UniformNoise();
  
  bgGeneral = loadImage("introsearch/search-intro-1.png");

  bgCamera = loadImage("bg/bg-1.png");
  bgBars = loadImage("bg/bg-4.png");
  header = loadImage("bg/bg-16.png");
  headerText = loadImage("bg/bg-17.png");
  cameraBelow = loadImage("bg/bg-2.png");
  
  personColor = loadRange("girl_person/persongirl-", 1, 19, ".png", -1, 3);
  personLine = loadRange("girl_person/persongirl-", 3, 21, ".png", -1, 3);
  personHighlight = loadRange("girl_person/persongirl-", 2, 20, ".png", -1, 3);

  girlColor = loadRange("girl_person/persongirl-", 25, 29, ".png", 3, 2);
  girlLine = loadRange("girl_person/persongirl-", 26, 30, ".png", 3, 2);

  bg2 = loadRange("meat-bg/", 1, 75, ".png");

  genImg = loadImage("bg_mask.png");
  genColor1 = loadRange("girl_person/persongirl-", 1, 19, ".png", -1, 2);
  genColor2 = loadRange("girl_person/persongirl-", 2, 20, ".png", -1, 2);
  // genColor3 = loadRange("girl_person/final-cutscene-", 4, 43, ".png", -1, 3);
  genOutline = loadRange("girl_person/persongirl-", 3, 21, ".png", -1, 2);
  
  frameRate(frameRateConst);
}

/* ------------------------------- DRAW | DRAW | DRAW -------------------------------- */

void draw(){
/*
  PGraphics main2 = createGraphics(width, height);
  main2.beginDraw();

  int c = color(noise(frameCount) * 200 + 55, 0, 0);
  main2.fill(c);
  main2.noStroke();
  glitchCloudSquare2D(main2, origin.x, origin.y, width*1.5, 30, 15, 6, 2);
  // main2.mask(genImg);
  // main2.rect(0, 0, width, height);

  main2.tint(#CDE6FF, 255);
  main2.image(bgCamera, 0, 0);

  PImage a = getFrame(personColor, 0, frameCount);
  PImage b = getFrame(personLine, 0, frameCount);
  PImage c = getFrame(personHighlight, 0, frameCount);

  main2.tint(#5880AA, 255);
  main2.image(a, 0, 20);

  main2.tint(#FFFDE0, 160);
  main2.image(c, 0, 20);

  main2.tint(#04203D, 255);
  main2.image(b, 0, 20);
  main2.tint(#ffffff, 255);

  main2.endDraw();
  */

  /*

  PImage test = filters.jpgDegrade(main2.copy());

  PGraphics main = createGraphics(width, height);
  main.beginDraw();

  main.image(main2, 0, 0);

  main.tint(#ffffff, noise(frameCount/10.0) * 70 + 80);
  main.image(test, 0, 0);
  main.tint(#ffffff, 255);

  main.image(cameraBelow, 0, 0);
  main.image(bgBars, 0, 0);
  main.image(header, 0, 0);
  main.image(headerText, 0, 0);
  */

/*
int c1, c2;
  if ((frameCount/2) % 2 == 0) {
    c1 = #000000;
    c2 = #ffffff;
  }
  else {
    c1 = #ffffff;
    c2 = #000000;
  }
*/

// main.image(, 0, 0);
/*
colorMode(RGB, 255, 255, 255);
main.tint(#ffffff, 150);
  main.image(getFrame(genColor1, 0, frameCount), 0, 20);

main.tint(#ff0099, noise(frameCount) * 50);
  main.image(getFrame(genColor1, 0, frameCount), 0, 20);



colorMode(HSB, 1, 1, 1);
int a = color(noise(frameCount), 0.9, 1);
main.tint(a, 255);

  main.image(getFrame(genOutline, 0, frameCount), 0, 20);
/*
  // main.image(getFrame(girlColor, 0, frameCount), 0, 20);
  // main.image(getFrame(girlLine, 0, frameCount), 0, 20);

  main.image(header, 0, 0);
  main.image(headerText, 0, 0);
  */

  PGraphics main2 = createGraphics(width, height);
  main2.beginDraw();
  // main2.image(getFrame(girlColor, 0, frameCount), 0, 0);
  // main2.image(getFrame(girlLine, 0, frameCount), 0, 0);
  fill(#ffffff);
  main2.rect(300, 350, 200, 600);
  main2.endDraw();

  PGraphics main = createGraphics(width, height);
  // PImage a = filters.noisy(filters.scanner(main2));
  PImage b = getFrame(bg2, 0, frameCount);
  b.resize(main2.width, main2.height);
  b.mask(main2);
  b = filters.scramble(b);
  main.beginDraw();
  main.image(b, 0, 0);
  main.endDraw();

  background(#333333);
  image(main, 0, 0);

  if (frameCount < 79) {
  // if (false) {
    main.save("save/"+(frameCount)+".png");
  }
}

/* ------------------------------- DYNAMIC LINES -------------------------------- */

// wavesHorizon - "horizon line", hSep - distance between lines
// image(althWaves(origin.y + 100, 10, 100), 0, 0);
PGraphics althWaves(float wavesHorizon, float hSep, float peakHeight) {
  // based on https://www.reddit.com/r/processing/comments/qtjwv7/thought_my_latest_project_was_worth_sharing/
  // by u/althazo
  
  PGraphics pg = createGraphics(width, height);
  pg.beginDraw();
  
  pg.stroke(255);
  pg.fill(0);
  
  for (int h = floor(wavesHorizon/hSep); h < height + 10; h++) {
    float lineHeight = h * hSep;
    
    pg.beginShape();
      // bottom side (top right, bot right, bot left, top left)
      pg.vertex(width + 10, lineHeight);
      pg.vertex(width + 10, height + 5);
      pg.vertex(-20, height + 5);
      pg.vertex(-20, lineHeight);
      
      // top side (curves)
      pg.curveVertex(0, lineHeight);
      
      PVector[] points = makeLineHor(width, 100);
      for (int i = 0; i < points.length; i++) {
        float heightPattern = sin((h + frameCount/frameRateConst) / 4);
        float peakAdd = - noise(i, h, frameCount/frameRateConst) * peakHeight * (1 - abs(origin.x - points[i].x)/origin.x) * exp(map(heightPattern, -1, 1, 0, 1));
        // negative for updir, peakheight is height, 1 - abs... decreases height as you leave center, exp(map) increases scale factor of height, heightPattern adds up-down sin waves
        
        pg.curveVertex(points[i].x, points[i].y + lineHeight + peakAdd + sin(i));
      }
      
      // ending curve vertex
      pg.curveVertex(width+5, lineHeight);
    pg.endShape(CLOSE);
  }
  
  pg.endDraw();
  return pg;
}

/* --------------------------------- SCROLLING/TILING ---------------------------------- */

// show tiling fullscreen: w/h is size of tile, x/ySpeed movement speed
PGraphics showTiling(PImage bg, float w, float h, float xSpeed, float ySpeed) {
  PGraphics pg = createGraphics(width, height);
  pg.beginDraw();
  
  float x = frameCount*xSpeed % width;
  float y = frameCount*ySpeed % height;
  
  int lowerX;
  int upperX;
  int lowerY;
  int upperY;
  if (ySpeed > 0) { // draw second image above
    lowerY = floor(-height/h);
    upperY = ceil(height/h);
  }
  else { // draw second image below
    lowerY = 0;
    upperY = ceil(2 * height/h);
  }
  if (xSpeed > 0) { // draw second image left
    lowerX = floor(-width/w);
    upperX = ceil(width/w);
  }
  else { // draw second image right
    lowerX = 0;
    upperX = 2 * ceil(width/w);
  }
  
  for (int i = lowerX; i < upperX; i++) {
    for (int j = lowerY; j < upperY; j++) {
      pg.image(bg, i*w + x, j*h + y, w, h);
    }
  }
  
  pg.endDraw();
  return pg;
}

PGraphics scrollBGDown(PImage bg, float speed) {
  PGraphics pg = createGraphics(width, height);
  pg.beginDraw();
  
  float y = frameCount*speed % height;
  pg.image(bg, 0, y);
  if (speed > 0) { // draw second image above
    pg.image(bg, 0, -bg.height + y);
  }
  else { // draw second image below
    pg.image(bg, 0, bg.height + y);
  }
  
  pg.endDraw();
  return pg;
}

PGraphics scrollBGSide(PImage bg, float speed) {
  PGraphics pg = createGraphics(width, height);
  pg.beginDraw();
  
  float x = frameCount*speed % width;
  pg.image(bg, x, 0);
  if (speed > 0) { // draw second image left
    pg.image(bg, -bg.width + x, 0);
  }
  else { // draw second image right
    pg.image(bg, bg.width + x, 0);
  }
  
  pg.endDraw();
  return pg;
}

/* ------------------------------------- FULLSCREEN EFFECTS ------------------------------------------- */

/*
bg.mask(growCircles(100, 200, 255, 255));
image(bg, 0, 0);
*/
void growCircles(PGraphics pg, int num, float maxSize, color stroke, color fill) {
  pg.stroke(stroke);
  pg.fill(fill);
  
  for (int i = 0; i < num; i++) {
    float n = noise(i);
    // float n = noise(i, frameCount/frameRateConst); // can change to (int) ((frameCount % (i+1))/frameRateConst) or (int)(frameCount/frameRateConst)
    float xx = map(noise(i*5, i, n), 0, 1, -0.5, 1.5) * width;
    float yy = map(noise(i*i*5, n), 0, 1, -0.5, 1.5) * height;
    
    // can map to 0, 1 for always-on circles, etc
    float size = map(sin(noise(i, frameCount/frameRateConst) * TWO_PI * 1.5), -1, 1, -3, 1) * maxSize;
    
    if (size > 0) {
      pg.circle(xx, yy, size);
    }
  }
}

// static with rect
void staticBG(PGraphics pg, float h, color c1, color c2) {
  pg.noStroke();
  float n = random(0.3);
  for (int i = 0; i < height/h; i += random(2.02)) {
    pg.fill(lerpColor(c1, c2, noise(i+frameCount*2 + n)));
    pg.rect(0, i*h, width, h);
  }
}
// uses line instead of rect
void staticBG2(PGraphics pg, float h, color c1, color c2) {
  float n = random(0.3);
  for (int i = 0; i < height/h; i += random(2.02)) {
    pg.stroke(lerpColor(c1, c2, noise(i+frameCount*2 + n)));
    pg.line(0, i*h, width, i*h);
  }
}

// Draw grid with lines
void gridLines(PGraphics pg, float h, color c1, color c2, float speed, boolean horizontal) {
  float wh = pg.width;
  float n = random(0.3);

  if (horizontal) {
    /* Horizontal lines */
    float y = frameCount*speed % wh;
  
    for (int i = floor(-wh/h); i < wh/h; i++) {
      float yy = i*h + noise(i+frameCount/(float)frameRateConst)*(h/2) + y;
      // i*h is relative y, noise is stuttery effect, y is motion up/down
      
      pg.stroke(lerpColor(c1, c2, noise(i+frameCount*2 + n)));
      pg.line(0, yy, wh, yy);
    }
  }
  else { // Vertical
    float x = frameCount*speed % wh;
  
    for (int i = floor(-wh/h); i < wh/h; i++) {
      float xx = i*h + noise(i+frameCount/(float)frameRateConst)*(h/2) + x;
      // i*h is relative y, noise is stuttery effect, x is motion left/right
      
      pg.stroke(lerpColor(c1, c2, noise(i+frameCount*2 + n)));
      pg.line(xx, 0, xx, wh);
    }
  }
}

void textureRect(float x, float y, int w, int h, PImage texture, float textureSize) {
  PGraphics pg = createGraphics(w, h);
  pg.beginDraw();
  pg.background(#ffffff);
  pg.blendMode(DARKEST);
  pg.image(texture, 0, 0, textureSize, textureSize);
  pg.endDraw();
  
  image(pg, x, y);
}

/* ------------------------- WAVY SHAPES -------------------------------- */

void expandingShape(PGraphics pg, color c) {
    for (int i = 35; i > -1000; i -= 2) {
    float a = i + 3 * (float)frameCount / (frameRateConst);
    
    if (a > 0 && a < 40) {
      print(a, "\n");
      pg.fill(lerpColor(c, 0, a/35));
      waveShape(pg, origin.x, origin.y, a*30, a*36, 360, a);
    }
  }
}

/* 
  setFill(false);
  setStroke(255);
  setStrokeWeight(2);
  waveShape(g, origin.x, origin.y, 100, 130, 360, 0);
  */
void waveShape(PGraphics pg, float x0, float y0, float radius1, float radius2, int npoints, float seed) {
  float angle = TWO_PI / npoints;
  
  pg.beginShape();
  for (float a = 0; a < TWO_PI; a += angle) {
    float xoff = map(cos(a), -1, 1, 0, 3);
    float yoff = map(sin(a), -1, 1, 0, 3);
    float r = map(noise(seed + xoff, yoff, 1.5 * (float)frameCount/(frameRateConst)), 0, 1, radius1, radius2);
    float x = x0 + r * cos(a);
    float y = y0 + r * sin(a);
    pg.vertex(x, y);
  }
  pg.endShape(CLOSE);
}

/* 
  setFill(false);
  setStroke(255);
  setStrokeWeight(2);
  waveShape(g, origin.x, origin.y, 100, 130, 360, 0);
  */
void waveShapeStill(PGraphics pg, float x0, float y0, float radius1, float radius2, int npoints, float seed) {
  float angle = TWO_PI / npoints;
  
  pg.beginShape();
  for (float a = 0; a < TWO_PI; a += angle) {
    float xoff = map(cos(a), -1, 1, 0, 3);
    float yoff = map(sin(a), -1, 1, 0, 3);
    float r = map(noise(seed + xoff, yoff), 0, 1, radius1, radius2);
    float x = x0 + r * cos(a);
    float y = y0 + r * sin(a);
    pg.vertex(x, y);
  }
  pg.endShape(CLOSE);
}

/* ----------------------- */

// from Fall
PGraphics xCircle(int rad, float lineWidth, color c, boolean filter) {
  int w = rad*2 + 100;
  
  PGraphics pg = createGraphics(w, w);
  PVector origin = new PVector(w/2, w/2);
  pg.beginDraw();
  
  pg.noFill();
  if (filter) {
    pg.strokeWeight(lineWidth * 1.25);
  }
  else {
    pg.strokeWeight(lineWidth);
  }
  pg.stroke(c);
 
  pg.ellipse(origin.x, origin.y, rad*2, rad*2);
  
  pg.line(origin.x + rad * cos(QUARTER_PI), origin.y + rad * sin(QUARTER_PI), origin.x + rad * cos(PI + QUARTER_PI), origin.y + rad * sin(PI + QUARTER_PI));
  pg.line(origin.x + rad * cos(HALF_PI + QUARTER_PI), origin.y + rad * sin(HALF_PI + QUARTER_PI), origin.x + rad * cos(-QUARTER_PI), origin.y + rad * sin(-QUARTER_PI));
  
  if (filter) {
    pg.filter(BLUR, 6);
  }
  
  pg.endDraw();
  
  return pg;
}
