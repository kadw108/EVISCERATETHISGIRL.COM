// halo

void star(float x, float y, float radius1, float radius2, int npoints, int shape) {
  float angle = TWO_PI / npoints;
  float halfAngle = angle/2.0;
  
  if (shape > 1) {
    beginShape(shape); // QUADS, TRIANGLES, TRIANGLE_FAN, TRIANGLE_STRIP, QUAD_STRIP
  } else {
    beginShape();
  }
  
  for (float a = 0; a < TWO_PI; a += angle) {
    float sx = x + cos(a) * radius2;
    float sy = y + sin(a) * radius2;
    vertex(sx, sy);
    sx = x + cos(a+halfAngle) * radius1;
    sy = y + sin(a+halfAngle) * radius1;
    vertex(sx, sy);
  }
  endShape(CLOSE);
}

void dots_star_recursive(float x, float y, float radius1, float radius2, float dot_size, int npoints) {
  float angle = TWO_PI / npoints;
  float halfAngle = angle/2.0;
  
  for (float a = 0; a < TWO_PI; a += angle) {
    float sx = x + cos(a) * radius2;
    float sy = y + sin(a) * radius2;
    if (dot_size > 1 && npoints > 2) {
      dots_star_recursive(sx, sy, dot_size, dot_size, dot_size/4, npoints/2);
    }
    else {
      ellipse(sx, sy, dot_size, dot_size);
    }
    
    sx = x + cos(a+halfAngle) * radius1;
    sy = y + sin(a+halfAngle) * radius1;
    if (dot_size > 1 && npoints > 2) {
      dots_star_recursive(sx, sy, dot_size, dot_size, dot_size/4, npoints/2);
    }
    else {
      ellipse(sx, sy, dot_size, dot_size);
    }
  }
}

void dots_star_recursive2(float x, float y, float radius1, float radius2, float dot_size, int npoints, int npoints_limit) {
  float angle = TWO_PI / npoints;
  float halfAngle = angle/2.0;
  
  for (float a = 0; a < TWO_PI; a += angle) {
    float sx = x + cos(a) * radius2;
    float sy = y + sin(a) * radius2;
    if (dot_size > 1 && npoints > npoints_limit) {
      dots_star_recursive2(sx, sy, dot_size, dot_size, dot_size/4, npoints/2, npoints_limit);
    }
    else {
      ellipse(sx, sy, dot_size, dot_size);
    }
    
    sx = x + cos(a+halfAngle) * radius1;
    sy = y + sin(a+halfAngle) * radius1;
    if (dot_size > 1 && npoints > npoints_limit) {
      dots_star_recursive2(sx, sy, dot_size, dot_size, dot_size/4, npoints/2, npoints_limit);
    }
    else {
      ellipse(sx, sy, dot_size, dot_size);
    }
  }
}

void dots_star_recursive3(float x, float y, float radius1, float radius2, float dot_size, int npoints, int npoints_limit, float dot_size_small) {
  float angle = TWO_PI / npoints;
  float halfAngle = angle/2.0;
  
  for (float a = 0; a < TWO_PI; a += angle) {
    float sx = x + cos(a) * radius2;
    float sy = y + sin(a) * radius2;
    if (dot_size > dot_size_small && npoints > npoints_limit) {
      dots_star_recursive2(sx, sy, dot_size, dot_size, dot_size/4, npoints/2, npoints_limit);
    }
    else {
      ellipse(sx, sy, dot_size, dot_size);
    }
    
    sx = x + cos(a+halfAngle) * radius1;
    sy = y + sin(a+halfAngle) * radius1;
    if (dot_size > dot_size_small && npoints > npoints_limit) {
      dots_star_recursive2(sx, sy, dot_size, dot_size, dot_size/4, npoints/2, npoints_limit);
    }
    else {
      ellipse(sx, sy, dot_size, dot_size);
    }
  }
}


void dots_star_recursive4(float x, float y, float radius1, float radius2, float dot_size, int npoints, int npoints_limit) {
  float angle = TWO_PI / npoints;
  float halfAngle = angle/2.0;
  
  for (float a = 0; a < TWO_PI; a += angle) {
    float sx = x + cos(a) * radius2;
    float sy = y + sin(a) * radius2;
    if (dot_size > 1 && npoints > npoints_limit) {
      dots_star_recursive2(sx, sy, dot_size, dot_size, dot_size/4, npoints, npoints_limit);
    }
    else {
      ellipse(sx, sy, dot_size, dot_size);
    }
    
    sx = x + cos(a+halfAngle) * radius1;
    sy = y + sin(a+halfAngle) * radius1;
    if (dot_size > 1 && npoints > npoints_limit) {
      dots_star_recursive2(sx, sy, dot_size, dot_size, dot_size/4, npoints, npoints_limit);
    }
    else {
      ellipse(sx, sy, dot_size, dot_size);
    }
  }
}

// Loads karma images from the file system.
PImage[] loadKarma() {
  String src = "/home/account/Videos/psychedelic_sky_islands/assets/";
  PImage[] k = new PImage[10];
  for (int i = 1; i <= 10; i++) {
    k[i-1] = loadImage(src + "karma"+i+"_2.png");
  }
  return k;
}

void dots_star(float x, float y, float radius1, float radius2, int dot_size, int npoints) {
  float angle = TWO_PI / npoints;
  float halfAngle = angle/2.0;
  
  for (float a = 0; a < TWO_PI; a += angle) {
    float sx = x + cos(a) * radius2;
    float sy = y + sin(a) * radius2;
    ellipse(sx, sy, dot_size, dot_size);
    sx = x + cos(a+halfAngle) * radius1;
    sy = y + sin(a+halfAngle) * radius1;
    ellipse(sx, sy, dot_size, dot_size);
  }
}

float theta;
// draw fractal tree, fC is frame count (for swaying branches)
void tree(int fC, float x, float y, float angle) {
  float fC3 = map(sin((float)fC/4), -1, 1, 6, 13);
  
  pushMatrix();
  // Convert it to radians
  theta = radians(fC3);
  // Start the tree from the bottom of the screen
  translate(x, y);
  rotate(radians(angle));
  
  // Draw a line 120 pixels, move to end of line
  int len = 60;
  line(0,0,0,-len);
  translate(0,-len);
  // Start the recursive branching!
  branch(len*3);
  popMatrix();
}
void branch(float h) {
  // Each branch will be 2/3rds the size of the previous one
  h *= 0.7;
  
  // All recursive functions must have an exit condition!!!!
  // Here, ours is when the length of the branch is 2 pixels or less
  if (h > 20) {
    pushMatrix();    // Save the current state of transformation (i.e. where are we now)
    rotate(theta);   // Rotate by theta
    line(0, 0, 0, -h);  // Draw the branch
    translate(0, -h); // Move to the end of the branch
    branch(h);       // Ok, now call myself to draw two new branches!!
    popMatrix();     // Whenever we get back here, we "pop" in order to restore the previous matrix state
    
    // Repeat the same thing, only branch off to the "left" this time!
    pushMatrix();
    rotate(-theta);
    line(0, 0, 0, -h);
    translate(0, -h);
    branch(h);
    popMatrix();
  }
}

// draw circle
void bubble(float x, float y, float w, float h) {
  ellipse(x, y, w * (y/height), h * (y/height));
}

// draw snow, size changes with position
void snow(float x, float y, float r1, float r2, int npoints) {
  posStar(x, y, r1 * constrain((height - y + height/2)/height, 0, 1), r2 * constrain((height - y + height/2)/height, 0, 1), npoints);
}

// draw ellipse or nothing if width or height < 0
void ellipsePos(float x, float y, float w, float h) {
  stroke(lerpColor(#56e2ff, #000000, ((float) w)/(1200)));
  if (w > 0 && h > 0) {
    ellipse(x, y, w, h);
    // ellipse(x, y, w + 5, h - 5);
  }
}

void rotateCircle(int wid, int heit, int xShift, int yShift, int x, int y, float deg) {
  pushMatrix();
  translate(origin.x + x, origin.y + y);
  rotate(radians(deg));
  ellipse(xShift, yShift, wid, heit);
  popMatrix();
}

void star(float x, float y, float radius1, float radius2, int npoints) {
  float angle = TWO_PI / npoints;
  float halfAngle = angle/2.0;
  beginShape();
  for (float a = 0; a < TWO_PI; a += angle) {
    float sx = x + cos(a) * radius2;
    float sy = y + sin(a) * radius2;
    vertex(sx, sy);
    sx = x + cos(a+halfAngle) * radius1;
    sy = y + sin(a+halfAngle) * radius1;
    vertex(sx, sy);
  }
  endShape(CLOSE);
}

void custStar(float x, float y, float radius1, float radius2, int npoints, int cust) {
  float angle = TWO_PI / npoints;
  float halfAngle = angle/2.0;
  beginShape(cust);
  for (float a = 0; a < TWO_PI; a += angle) {
    float sx = x + cos(a) * radius2;
    float sy = y + sin(a) * radius2;
    vertex(sx, sy);
    sx = x + cos(a+halfAngle) * radius1;
    sy = y + sin(a+halfAngle) * radius1;
    vertex(sx, sy);
  }
  endShape(CLOSE);
}

void posStar(float x, float y, float radius1, float radius2, int npoints) {
  if (radius1 > 0 && radius2 > 0) {
    star(x, y, radius1, radius2, npoints);
  }
  else {
    star(x, y, 1, 2, npoints);
  }
}

void rotatePosStar(float x, float y, float radius1, float radius2, int npoints, float deg) {
  pushMatrix();
  translate(x, y);
  rotate(radians(deg));
  posStar(0, 0, radius1, radius2, npoints);
  popMatrix();
}

void custRotatePosStar(float x, float y, float radius1, float radius2, int npoints, float deg, int cust) {
  pushMatrix();
  translate(x, y);
  rotate(radians(deg));
  
  if (radius1 > 0 && radius2 > 0) {
    custStar(0, 0, radius1, radius2, npoints, cust);
  }
  else {
    custStar(0, 0, 1, 2, npoints, cust);
  }
  
  popMatrix();
}

/*
 * Draws an ellipse of circles.
 */
void circleDots(PGraphics pg, float x, float y, float radDot, float radX, float radY, int npoints) {
  float angle = TWO_PI / npoints;
  for (float a = 0; a < TWO_PI; a += angle) {
    float sx = x + cos(a) * radX;
    float sy = y + sin(a) * radY;
    pg.ellipse(sx, sy, radDot, radDot);
  }
}

/*
 * Draws an ellipse of circles, where every circleSpace circles, circleMissing circles will be missing.
 */
void circleDotsMissing(PGraphics pg, float x, float y, float radDot, float radX, float radY,
int npoints, int circleSpace, int circleMissing) {
  float angle = TWO_PI / npoints;
  int pattern = circleSpace + circleMissing;

  for (int i = 0; i < npoints; i++) {
    if (i % pattern < circleSpace) {
      float sx = x + cos(angle * i) * radX;
      float sy = y + sin(angle * i) * radY;
      pg.ellipse(sx, sy, radDot, radDot);
    }
  }
}

/*
 * Draws a circle of circles rotated deg degrees.
 */
void rotateCircleDots(PGraphics pg, float x, float y, float radDot, float radX, float radY, int npoints, float deg) {
  pg.pushMatrix();
  pg.translate(origin.x + x, origin.y + y);
  pg.rotate(radians(deg));
  circleDots(pg, 0, 0, radDot, radX, radY, npoints);
  pg.popMatrix();
}

void circleStars(float x, float y, float radDot, float radX, float radY, int npoints, int nStarPoints, float starDeg) {
  float angle = TWO_PI / npoints;
  for (float a = 0; a < TWO_PI; a += angle) {
    float sx = x + cos(a) * radX;
    float sy = y + sin(a) * radY;
    rotatePosStar(sx, sy, radDot, radDot/4, nStarPoints, starDeg);
  }
}

void rotateCircleStars(float x, float y, float radDot, float radX, float radY, int npoints, float deg, int nStarPoints) {
  pushMatrix();
  translate(x, y);
  rotate(radians(deg));
  circleStars(0, 0, radDot, radX, radY, npoints, nStarPoints, deg);
  popMatrix();
}

void polygon(float x, float y, float radius, int npoints) {
  float angle = TWO_PI / npoints;
  beginShape();
  for (float a = 0; a < TWO_PI; a += angle) {
    float sx = x + cos(a) * radius;
    float sy = y + sin(a) * radius;
    vertex(sx, sy);
  }
  endShape(CLOSE);
}

// Swirl circle
void swirl(float x, float y, float radius1, float radius2, int npoints) {
  float angle = TWO_PI / npoints;
  float halfAngle = angle/2.0;
  
  float prevSX = x;
  float prevSY = y;
  
  for (float a = 0; a < TWO_PI; a += angle) {
    float sx = x + cos(a) * radius2;
    float sy = y + sin(a) * radius2;
    vertex(sx, sy);
    float sx2 = x + cos(a+halfAngle) * radius1;
    float sy2 = y + sin(a+halfAngle) * radius1;
    vertex(sx, sy);
    
    curve(prevSX, prevSY, sx, sy, sx2, sy2, x + cos(a+10)*(radius2*1.5), y + sin(a+10)*(radius2*1.5));
    print(cos(a)*200, sin(a)*200, "\n");
    
    prevSX = sx;
    prevSY = sy;
  }
}

// Rotating swirl circle
void rotateSwirl(float x, float y, float radius1, float radius2, int npoints, float deg) {
  pushMatrix();
  translate(x, y);
  rotate(radians(deg));
  swirl(0, 0, radius1, radius2, npoints);
  popMatrix();
}

// Swirl ray circle with moving circumference (swirl rays)
void ellipseSwirlMoveRays(float x, float y, float radx, float rady, float diff, int npoints, float shiftDeg) {
  float angle = TWO_PI / npoints;
  float shift = radians(shiftDeg);
  
  // get sx and sy of last "curve" to use as ref for first curve
  float prevSX = 0;
  float prevSY = 0;
  for (float a = 0; a < TWO_PI; a += angle) {
    prevSX = x + cos(a+shift) * radx;
    prevSY = y + sin(a+shift) * rady;
  }
  
  // actually draw "curves" (triangles)
  for (float a = 0; a < TWO_PI; a += angle) {
    float sx = x + cos(a+shift) * radx;
    float sy = y + sin(a+shift) * rady;
    float sx2 = x + cos(a+shift) * (radx - diff);
    float sy2 = y + sin(a+shift) * (rady - diff);
    
    curve(prevSX, prevSY, sx, sy, sx2, sy2, x + cos(a+10)*(radx*1.5), y + sin(a+10)*(rady*1.5));
    
    prevSX = sx;
    prevSY = sy;
  }
}

// Ray circle with moving circumference (rays)
void ellipseMoveRays(float x, float y, float radx, float rady, float diff, int npoints, float shiftDeg) {
  float angle = TWO_PI / npoints;
  float shift = radians(shiftDeg);
  
  for (float a = 0; a < TWO_PI; a += angle) {
    float sx = x + cos(a+shift) * radx;
    float sy = y + sin(a+shift) * rady;
    
    float sx2 = x + cos(a+shift) * (radx - diff);
    float sy2 = y + sin(a+shift) * (rady - diff);
    
    line(sx, sy, sx2, sy2);
  }
}

// Ray circle with weird rays, combination of prev. two
void ellipseTriMoveRays(float x, float y, float radx, float rady, float diff, int npoints, float shiftDeg) {
  ellipseMoveRays(x, y, radx, rady, diff, npoints, shiftDeg);
  ellipseSwirlMoveRays(x, y, radx, rady, diff, npoints, shiftDeg);
}

// Ray circle with rectangles instead of lines as rays (5P style)
void ellipseRect(float x, float y, float innerRad, float diff, float rectW, int npoints, float shiftDeg) {
  float angle = TWO_PI / npoints;
  float shift = radians(shiftDeg);
  
  for (float a = 0; a < TWO_PI; a += angle) {
    pushMatrix();
    translate(x, y);
    rotate(a + shift);
    
    rect(0, innerRad, rectW, diff);
    popMatrix();
  }
}

// Ray circle with IMAGES instead of lines as rays (diff = height)
// ellipseImage(getFrame(karma, 0, (1/(float)20)), origin.x, origin.y, 300, 20, 20, 10, frameCount);
void ellipseImage(PImage img, float x, float y, float innerRad, float diff, float rectW, int npoints, float shiftDeg) {
  float angle = TWO_PI / npoints;
  float shift = radians(shiftDeg);
  
  for (float a = 0; a < TWO_PI; a += angle) {
    pushMatrix();
    translate(x, y);
    rotate(a + shift);
    
    image(img, 0, innerRad, rectW, diff);
    popMatrix();
  }
}

void simpleMandalaRays(float x, float y, float radius1, float radius2, int numlines, float deg) {
  pushMatrix();
  translate(x, y);
  rotate(radians(deg));
  
  for (int i = 0; i < numlines; i++) {
    line(-radius1, 0, radius2, radius2);
    rotate(0.5);
  }
  
  popMatrix();
}

void simpleMandalaEdge(float x, float y, float radius1, float radius2, int numlines, float deg) {
  pushMatrix();
  translate(x, y);
  rotate(radians(deg));
  
  for (int i = 0; i < numlines; i++) {
    line(radius1/2, radius2/2, 0, radius1/2);
    rotate(0.5);
  }
  
  popMatrix();
}


/*
Mandala formulations:
(i % radius2, 0, 0, 0); --- star, small rays from central point
(i % radius2, 0, 0, radius); --- default 2
(i % radius2, 0, radius, radius); --- default 1

(i % radius2, radius, 0, 0); --- sun, large rays from central point
(i % radius2, radius, 0, radius); --- eclipse, small rays from edge
(i % radius2, radius, radius, radius); --- large rays from edge

(i % radius2, 0, i % radius2, radius); --- default with starry points
*/

// https://www.openprocessing.org/sketch/504464
// Continually draw rays in circle pattern, origin (x, y)
int drawMandalaConst = 0;
void drawMandala(float x, float y, float radius, float radius2, color c) {
  pushMatrix();
  translate(x, y);

  int i = drawMandalaConst;
  drawMandalaConst += 3;
  
  while(i > 1){
    i--;
    // stroke(lerpColor(c, #000000, (i%255)/(float)255));
    line(i % radius2, 0, 0, radius);
    rotate(0.5);
  }
  
  popMatrix();
}

// https://www.openprocessing.org/sketch/504464
int drawMandala2Const = 0;
void drawMandala2(float x, float y, float radius, float radius2, color c) {
  pushMatrix();
  translate(x, y);

  int i = drawMandala2Const;
  drawMandala2Const++;
  
  while(i > 1){
    i--;
    stroke(lerpColor(c, #000000, (i%255)/(float)255));
    line(i % radius2, radius, i % radius2, radius2);
    rotate(1);
  }
  
  popMatrix();
}

// https://www.openprocessing.org/sketch/504464
int drawMandala3Const = 0;
void drawMandala3(float x, float y, float radius, float radius2, color c) {
  pushMatrix();
  translate(x, y);

  int i = drawMandala3Const;
  drawMandala3Const++;
  
  while(i > 1){
    i--;
    stroke(lerpColor(c, #ffffff, (i%255)/(float)255));
    line(i % radius2, radius, 0, 0);
    rotate(1);
  }
  
  popMatrix();
}
