// grow

/*
 * Creates a vase shape that grows to full height over time.
 *
 * x - x of vase's left corner
 * y - y of vase's left corner
 * pWidth - starting width of vase
 * pLen - final height of vase
 * shiftSize - how much vase's sides move, larger means more dramatic vase
 * growSeconds - seconds for vase to reach full height (0 for no growth)
 * startFrame - frame vase starts to grow/appear on
 *
 * Example: fill(0); stroke(#66ccff); growVase(width/2, height/2, 50, 200, 10, 3, 0);
 *
*/
void growVase(float x, float y, float pWidth, float pLen, float shiftSize, float growSeconds, int startFrame) {
  if (frameCount > startFrame) {
    
    /* PREP */
    pushMatrix();
    translate(x, y);
    
    float lineLen;
    if ((frameCount-startFrame)/frameRateConst > growSeconds) {
      lineLen = pLen;
    }
    else {
      lineLen = (((frameCount-startFrame)/frameRateConst) / growSeconds) * pLen;
    }
    
    beginShape();
    
    /* FIRST POINT */
    vertex(0, 0);
    
    /* LEFT SIDE LINE */
    float xShift = 0;
    
    int i;
    for (i = 1; i < ceil(lineLen/shiftSize); i++) {
      int dir = segNoise(new float[] {0.3, 0.7}, new float[] {x, y, i});
      
      if (dir == 0) { // left
        xShift -= shiftSize;
      }
      else if (dir == 2) { // right
        xShift += shiftSize;
      }
      
      vertex(0 + xShift, -i*shiftSize);
    }
    
    /* TOP LINE */
    vertex(xShift, -lineLen);
    vertex(xShift + pWidth, -lineLen);
    
    /* RIGHT SIDE LINE */
    xShift += pWidth;
    
    for (i--; i > 0; i--) {
      int dir = segNoise(new float[] {0.3, 0.7}, new float[] {x, y, i});
      
      if (dir == 0) { // left reversed becomes right (+)
        xShift -= shiftSize;
      }
      else if (dir == 2) { // right reversed becomes left (+)
        xShift += shiftSize;
      }
      
      vertex(0 + xShift, -i*shiftSize + shiftSize);
    }
    
    endShape(CLOSE);
    popMatrix();
  }
}

/*
 * Creates a ladder shape that grows to full height over time.
 * You must set a stroke color to see it - fill doesn't work well with this shape
 *
 * x - x of ladder's left corner
 * y - y of ladder's left corner
 * pWidth - width of ladder
 * pLen - final height of ladder
 * spacing - spacing between rungs
 * growSeconds - seconds to reach full height (0 for no growth)
 * startFrame - frame it starts to grow/appear on
 *
 * Example: fill(0); stroke(#66ccff); growLadder(width/2, height/2, 50, 200, 10, 3, 0);
*/
void growLadder(float x, float y, float pWidth, float pLen, float spacing, float growSeconds, int startFrame) {
  if (frameCount > startFrame) {
    
    /* PREP */
    pushMatrix();
    translate(x, y);
    
    float lineLen;
    if ((frameCount-startFrame)/frameRateConst > growSeconds) {
      lineLen = pLen;
    }
    else {
      lineLen = (((frameCount-startFrame)/frameRateConst) / growSeconds) * pLen;
    }
    
    /* LEFT SIDE LINE */
    line(0, 0, 0, -lineLen);
    
    /* RUNGS */
    for (int i = 1; i < lineLen; i += spacing) {
      line(0, -i, pWidth, -i);
    }
    
    /* RIGHT SIDE LINE */
    line(pWidth, 0, pWidth, -lineLen);
    
    popMatrix();
  }
}

/*
 * Draws a field of pipes that grow at random speeds.
 *
 * sep - width of pipes, somewhat increases separation
 * distr - density of pipes, lower number for more
 * startFrame - frame the pipes appear/start to grow
 *
 * At low sep the pipes resemble lines. Low sep and distr creates many overlapping lines. Pretty.
 * For more "pipe"-like pipes, try larger values (50+) for sep
 *
 * Example: fill(0); stroke(#66ccff); pipeField(2, 2, 0);
*/
void pipeField(float sep, int distr, int startFrame) { // try sep 2 distr 2
  for (int i = 0; i < width/sep; i += distr) {
    growPipe(i*sep, height, sep, height+sep, 20, 1 + noise(4+i), startFrame);
  }
}

/*
 * Draws a pipe that grows to full height over time in random directions.
 * This version turns diagonally.
 *
 * x - x of pipe's left corner
 * y - y of pipe's left corner
 * pWidth - width of pipe
 * pLen - final height of pipe
 * shiftSize - size of directional shifts (larger = more dramatic shifts in X while growing)
 * growSeconds - seconds for pipe to grow
 * startFrame - frame it appears/starts to grow
 */
void growPipe(float x, float y, float pWidth, float pLen, float shiftSize, float growSeconds, int startFrame) {
  if (frameCount > startFrame) {
    
    /* PREP */
    pushMatrix();
    translate(x, y);
    
    float lineLen;
    if ((frameCount-startFrame)/frameRateConst > growSeconds) {
      lineLen = pLen;
    }
    else {
      lineLen = (((frameCount-startFrame)/frameRateConst) / growSeconds) * pLen;
    }
    
    beginShape();
    
    /* FIRST POINT */
    vertex(0, 0);
    
    /* LEFT SIDE LINE */
    float xShift = 0;
    
    int i;
    for (i = 1; i < ceil(lineLen/shiftSize); i++) {
      int dir = segNoise(new float[] {0.3, 0.7}, new float[] {noise(x, y), startFrame, i});
      
      if (dir == 0) { // left
        xShift -= shiftSize;
      }
      else if (dir == 2) { // right
        xShift += shiftSize;
      }
      
      vertex(0 + xShift, -i*shiftSize);
    }
    
    /* TOP LINE */
    vertex(xShift, -lineLen);
    vertex(xShift + pWidth, -lineLen);
    
    /* RIGHT SIDE LINE */
    xShift += pWidth;
    
    for (i--; i > 0; i--) {
      int dir = segNoise(new float[] {0.3, 0.7}, new float[] {noise(x, y), startFrame, i});
      
      if (dir == 0) { // left reversed becomes right (+)
        xShift += shiftSize;
      }
      else if (dir == 2) { // right reversed becomes left (+)
        xShift -= shiftSize;
      }
      
      vertex(0 + xShift, -i*shiftSize + shiftSize);
    }
    
    endShape(CLOSE);
    popMatrix();
  }
}

// Helper function.
// eg. given [0.1, 0.4] returns 0 if noise<0.1, 1 if noise<0.4, else 2
int segNoise(float[] f, float[] val) {
  float n = -1;
  if (val.length == 1)
    n = noise(val[0]);
  if (val.length == 2)
    n = noise(val[0], val[1]);
  if (val.length == 3)
    n = noise(val[0], val[1], val[2]);
  
  for (int i = 0; i < f.length; i++) {
    if (n < f[i]) {
      return i;
    }
  }
  return f.length;
}

// like growPipe but with no directional changes in growth
void growPole(float x, float y, float pWidth, float pLen, float growSeconds, int startFrame) {
  // TODO
}

enum Dir {
  LEFT,
  UP,
  RIGHT,
  DOWN
}

/*
 * Draws a pipe that grows to full height over time in random directions.
 * This version only makes 90 degree turns for more realistic pipe shapes.
 * TODO - this is more complicated than I thought
 *
 * x - x of pipe's left corner
 * y - y of pipe's left corner
 * pWidth - width of pipe
 * pLen - final height of pipe
 * shiftSize - size of directional shifts (larger = more dramatic shifts in X while growing)
 * growSeconds - seconds for pipe to grow
 * startFrame - frame it appears/starts to grow
 */
void growPipe2(float x, float y, float pWidth, float pLen, float shiftSize, float growSeconds, int startFrame) {
  if (frameCount > startFrame) {
    
    /* PREP */
    pushMatrix();
    translate(x, y);
    
    float lineLen;
    if ((frameCount-startFrame)/frameRateConst > growSeconds) {
      lineLen = pLen;
    }
    else {
      lineLen = (((frameCount-startFrame)/frameRateConst) / growSeconds) * pLen;
    }
    
    beginShape();
    
    /* FIRST POINT */
    vertex(0, 0);
    
    /* LEFT SIDE LINE */
    int i;
    Dir prevDir = Dir.values()[0];
    Dir dir = Dir.values()[0];
    PVector currentVertex = new PVector(0, 0);
    for (i = 1; i < ceil(lineLen/shiftSize); i++) {
      Dir before = dir;
      dir = Dir.values()[segNoise(new float[] {0.25, 0.5, 1.1}, new float[] {noise(x, y), startFrame, i})];
      if (dir != before) {
        prevDir = before;
      }
      
      if (dir == Dir.LEFT) { // go left
        currentVertex.x -= shiftSize;
      }
      else if (dir == Dir.UP) { // go up
        currentVertex.y -= shiftSize;
      }
      else if (dir == Dir.RIGHT) { // go right
        currentVertex.x += shiftSize;
      }
      else if (dir == Dir.DOWN) { // go down
        currentVertex.y += shiftSize;
      }
      
      vertex(currentVertex.x, currentVertex.y);
      if (frameCount == 1)
        print("left" + " " + currentVertex.x + " " + currentVertex.y + " " + dir, "\n");
    }
    
    /* TOP LINE */
    vertex(currentVertex.x, currentVertex.y);

    if (dir == Dir.UP || dir == Dir.DOWN) { // pipe facing up/down means top line goes right
      if (prevDir == Dir.LEFT) {
        currentVertex.x -= pWidth;
      }
      else {
        currentVertex.x += pWidth;
      }
    }
    else { // pipe facing left/right
      if (prevDir == Dir.DOWN) {
        currentVertex.y += pWidth;
      }
      else {
        currentVertex.y -= pWidth;
      }
    }
    print("top", prevDir, dir, "\n");
    vertex(currentVertex.x, currentVertex.y);
    
    /* RIGHT SIDE LINE */
    for (i--; i > 0; i--) {
      dir = Dir.values()[segNoise(new float[] {0.25, 0.5, 1.1}, new float[] {noise(x, y), startFrame, i})];
      
      if (dir == Dir.LEFT) { // left reversed becomes right
        currentVertex.x += shiftSize;
      }
      else if (dir == Dir.UP) { // up reversed becomes down
        currentVertex.y += shiftSize;
      }
      else if (dir == Dir.RIGHT) { // right reversed
        currentVertex.x -= shiftSize;
      }
      else if (dir == Dir.DOWN) { // down reversed
        currentVertex.y -= shiftSize;
      }

      // just do changes on a case-by-case basis because I'm lazy
      Dir oldDir = dir;
      dir = Dir.values()[segNoise(new float[] {0.25, 0.5, 1.1}, new float[] {noise(x, y), startFrame, i-1})];
      if (dir != oldDir && i-1 != 0) {
        if (oldDir == Dir.UP || dir == Dir.LEFT) {
          // currentVertex.x += pWidth;
          currentVertex.y += pWidth;

          print("mark0", "\n");
        }
        else if (oldDir == Dir.UP || dir == Dir.RIGHT) {
          currentVertex.x -= pWidth;
          currentVertex.y += pWidth;
          print("mark1", "\n");
        }
        else if (oldDir == Dir.LEFT || dir == Dir.UP) {
          // currentVertex.x += pWidth;
          currentVertex.y += pWidth;
          print("mark2", "\n");
        }
        else if (oldDir == Dir.RIGHT || dir == Dir.UP) {
          currentVertex.x -= pWidth;
          currentVertex.y += pWidth;
          print("mark3", "\n");
        }
        else if (oldDir == Dir.LEFT || dir == Dir.DOWN) {
          currentVertex.x -= pWidth;
          currentVertex.y -= pWidth;
          print("mark4", "\n");
        }
        else if (oldDir == Dir.RIGHT || dir == Dir.DOWN) {
          currentVertex.x += pWidth;
          currentVertex.y -= pWidth;
          print("mark5", "\n");
        }
        else if (oldDir == Dir.DOWN || dir == Dir.LEFT) {
          currentVertex.x -= pWidth;
          currentVertex.y += pWidth;
          print("mark6", "\n");
        }
        else if (oldDir == Dir.DOWN || dir == Dir.RIGHT) {
          currentVertex.x += pWidth;
          currentVertex.y += pWidth;
          print("mark7", "\n");
        }
      }
      
      vertex(currentVertex.x, currentVertex.y);
      if (frameCount == 1)
        print("right" + " " + currentVertex.x + " " + currentVertex.y + " " + dir, "\n");
    }

    endShape(CLOSE);
    popMatrix();
  }
}

/*
 * Returns a PGraphics with a field of flowers that wave in the wind.
 * The flowers are created in multiple rows, growing smaller towards the horizon.
 * The 'flower' itself is not very detailed and is just a blob of color.
 * 
 * stalkHeight - height of stalk
 * flowerSize - size of flower
 * stem - color of flower's stem
 * flower - color of actual flower
 * fieldHorizon - y coordinate of where the field meets the horizon (height of the field graphic, basically)
 * verSep - vertical (y) separation between rows of flowers
 * horSep - horizontal (x) separation between different flowers in one row
 *
 * Example: image(flowerField(height * (3.0/4), 50, 50), 0, 0);
*/
PGraphics flowerField(float stalkHeight, float flowerSize, color stem, color flower, float fieldHorizon, float verSep, float horSep) {
  PGraphics pg = createGraphics(width, height, P3D);
  pg.beginDraw();
  
  for (int row = floor((fieldHorizon-verSep)/verSep); row < (height + verSep)/verSep; row++) {
    for (int col = -1; col < (width + horSep)/horSep; col++) {
      pg.pushMatrix();
      pg.translate(col*horSep + noise(row, col)*horSep*2, row*verSep);
      pg.scale(row/((height + 3*verSep)/verSep));
      pg.rotate((noise(row/2, col/2, 0.3*frameCount/frameRateConst) - 0.5) * PI/4);
      pg.rotate(sin(0.6*frameCount/frameRateConst) * PI/10);
      growFlower(pg, 0, 0, 15, stalkHeight, flowerSize, 0, 0, stem, flower, noise(row, col));
      pg.popMatrix();
    }
  }
  
  pg.endDraw();
  return pg;
}

/*
 * Draws a flower that grows to full height over time.
 *
 * pg - PGraphics object to draw the flower on (use g if you want to draw on the screen like normal and not on a separate PGraphics)
 * x - x of flower's bottom (centered)
 * y - y of flower's bottom
 * w - horizontal shift of stem - how likely it is to move far to the left/right during growth
 * h - final height of stem
 * flowerSize - size of flower
 * growSeconds - seconds to reach full height (0 for no growth)
 * startFrame - frame it starts to grow/appear on
 * stem - color of stem
 * flower - color of flower
 * seed - noise seed that affects growth, use a constant number for this (recommended to use a noise value) - with true randomness or the flower will change every frame
 *
 * Example: growFlower(g, origin.x, origin.y, 20, 100, 20, 4, 0, #66ffcc, #66ccff, 0);
*/
void growFlower(PGraphics pg, float x, float y, float w, float h, float flowerSize, int growSeconds, int startFrame, color stem, color flower, float seed) {
  if (frameCount > startFrame) {
    pg.pushMatrix();
    pg.translate(x, y);
    
    boolean growFlower = false;
    
    /* LINE */
    float lineLen;
    if ((frameCount-startFrame)/frameRateConst > growSeconds) {
      lineLen = h;
      growFlower = true;
    }
    else {
      lineLen = (((frameCount-startFrame)/frameRateConst) / growSeconds) * h;
    }
    
    pg.noFill();
    pg.stroke(stem);
    pg.strokeWeight(5);
    pg.beginShape();
    float lastHorShift = -1;
    
    PVector[] points = makeLineVer(lineLen, 4);
    for (int i = 0; i < points.length; i++) {
      if (i % 2 == 0)
        lastHorShift = (noise(seed, -i/2)-0.5) * w;
      else
        lastHorShift = 0;
        
      pg.curveVertex(lastHorShift, points[i].y);
    }
    pg.endShape();
    
    /* FLOWER */
    if (growFlower) {
      PVector center = new PVector(lastHorShift, points[points.length - 1].y);
      pg.noStroke();
      pg.fill(flower);
      
      // could use halos if I wanted more alien flowers
      
      // pg.circle(center.x, center.y, flowerSize); // circle center
      // pg.shape(waveShapePS(0, 0, flowerSize/2, flowerSize/2 + 10, 20, frameCount/frameRateConst), center.x, center.y); // change seed for wavy center
      clusterFlower(pg, center, seed, flowerSize); // cluster of circles
    }
    
    pg.popMatrix();
  }
}
void clusterFlower(PGraphics pg, PVector center, float seed, float flowerSize) {
  float divs = 10;
  for (int i = 0; i < divs; i++) {
    float randrX = (noise(noise(i, center.x), seed, frameCount/frameRateConst) - 0.5) * 25;
    float randrY = (noise(noise(i, center.y), seed, frameCount/frameRateConst) - 0.5) * 25;
    float flowerSizeN = flowerSize * (noise(i, seed, frameCount/frameRateConst)) * 0.5;
    pg.circle(center.x + randrX, center.y + randrY, flowerSizeN);
  }
}

/*
 * TODO - Draws a mushroom that grows to full height over time.
 * 
 * pg - PGraphics object to draw the flower on (use g if you want to draw on the screen like normal and not on a separate PGraphics)
 * x - x of flower's bottom (centered)
 * y - y of flower's bottom
 * w - horizontal shift of stem - how likely it is to move far to the left/right during growth
 * h - final height of stem
 * flowerSize - size of flower
 * growSeconds - seconds to reach full height (0 for no growth)
 * startFrame - frame it starts to grow/appear on
 * stem - color of stem
 * flower - color of flower
 * seed - noise seed that affects growth, use a constant number for this (recommended to use a noise value) - with true randomness or the flower will change every frame
 *
 * Example: growFlower(g, origin.x, origin.y, 20, 100, 20, 4, 0, #66ffcc, #66ccff, 0);
*/
void growMushroom(PGraphics pg, float x, float y, float w, float h, float flowerSize, int growSeconds, int startFrame, color stem, color flower, float seed) {
  if (frameCount > startFrame) {
    pg.pushMatrix();
    pg.translate(x, y);
    
    boolean growFlower = false;
    
    /* LINE */
    float lineLen;
    if ((frameCount-startFrame)/frameRateConst > growSeconds) {
      lineLen = h;
      growFlower = true;
    }
    else {
      lineLen = (((frameCount-startFrame)/frameRateConst) / growSeconds) * h;
    }
    
    pg.noFill();
    pg.stroke(stem);
    pg.strokeWeight(5);
    pg.beginShape();
    float lastHorShift = -1;
    
    PVector[] points = makeLineVer(lineLen, 4);
    for (int i = 0; i < points.length; i++) {
      if (i % 2 == 0)
        lastHorShift = (noise(seed, -i/2)-0.5) * w;
      else
        lastHorShift = 0;
        
      pg.curveVertex(lastHorShift, points[i].y);
    }
    pg.endShape();
    
    /* FLOWER */
    if (growFlower) {
      PVector center = new PVector(lastHorShift, points[points.length - 1].y);
      pg.noStroke();
      pg.fill(flower);
      
      // could use halos if I wanted more alien flowers
      
      // pg.circle(center.x, center.y, flowerSize); // circle center
      // pg.shape(waveShapePS(0, 0, flowerSize/2, flowerSize/2 + 10, 20, frameCount/frameRateConst), center.x, center.y); // change seed for wavy center
      clusterFlower(pg, center, seed, flowerSize); // cluster of circles
    }
    
    pg.popMatrix();
  }
}
