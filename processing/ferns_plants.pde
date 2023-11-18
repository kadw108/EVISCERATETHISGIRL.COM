// return points for horizontal line
PVector[] makeLineHor(float w, float sep) {
  PVector[] points = new PVector[ceil(w/sep) + 1];
  
  for (int i = 0; i < points.length; i++) {
    points[i] = new PVector(i*sep, 0);
  }
  
  return points;
}

// return points for vertical line
PVector[] makeLineVer(float h, float sep) {
  PVector[] points = new PVector[ceil(h/sep) + 1];
  
  for (int i = 0; i < points.length; i++) {
    points[i] = new PVector(0, -i*sep);
  }
  
  return points;
}
// len curve, sep between points, rotate = degrees of avg? rotation, defaultAngle is starting angle of line (degrees), noise seed
PVector[] randomCurve(float len, float sep, float rotate, float defaultAngle, float seed) {
  PVector[] points = new PVector[ceil(len/sep) + 1];
  
  PVector pos = new PVector(0, 0);
  PVector vel = new PVector(0, 0);
  for (int i = 0; i < points.length; i++) {
    PVector n = PVector.fromAngle(radians(defaultAngle) + (noise(i, seed) - 0.5) * radians(rotate) * (10 * i/points.length));
    vel.add(n).setMag(sep);
    
    pos.add(vel);
    points[i] = new PVector(pos.x, pos.y);
  }
  
  return points;
}

void lineFromPoints(PVector[] points, float x, float y) {
  beginShape();
  curveVertex(x, y); // 1st control point
  for (int i = 0; i < points.length; i++) {
    curveVertex(x + points[i].x, y + points[i].y);
  }
  curveVertex(x + points[points.length - 1].x, y + points[points.length - 1].y); // last control point
  endShape();
}

// chainFromPoints(randomCurve(500, 2, 180, -90, noise(0.1 * frameCount/frameRateConst)), origin.x, origin.y, 40, 10);
void chainFromPoints(PVector[] points, float x, float y, float linkLen, float spaceBetween) { // TODO
  for (int i = 0; i < points.length; i++) {
    curveVertex(x + points[i].x, y + points[i].y);
  }
}

// fernField(g, 1000, gold, gold, 1, height * (3.0/4), 600, 600);
void fernField(PGraphics pg, float stalkHeight, color stem, color leaf, int leafType, float fieldHorizon, float verSep, float horSep) {
  for (int row = floor((fieldHorizon-verSep)/verSep); row < (height + verSep)/verSep; row++) {
    for (int col = -1; col < (width + horSep)/horSep; col++) {
      pg.pushMatrix();
      pg.translate(col*horSep + noise(row, col)*horSep*2, row*verSep);
      pg.scale(row/((height + verSep)/verSep));
      pg.rotate((noise(row/2, col/2, 0.3*frameCount/frameRateConst) - 0.5) * PI/4);
      pg.rotate(sin(0.6*frameCount/frameRateConst) * PI/10);

      fernFromPoints(pg,
        // PVector[] randomCurve(float len, float sep, float rotate, float defaultAngle, float seed) {
        randomCurve(stalkHeight, max(2, stalkHeight/200), 140, -90, noise(row, col, 0.1 * frameCount/frameRateConst)),

        0, 0, 15, leafType, stem, leaf);

      pg.popMatrix();
    }
  }
}
void fernFromPoints(PGraphics pg, PVector[] points, float x, float y, float leafSep, int leafType, color stem, color leafC) {
  
  // DRAW CENTER LINE - must be done individual from leaves
  pg.noFill();
  pg.strokeWeight(3);
  pg.stroke(stem);
  pg.beginShape();
  pg.curveVertex(x, y); // 1st control point
  for (int i = 0; i < points.length; i++) {
    pg.curveVertex(x + points[i].x, y + points[i].y);
  }
  pg.curveVertex(x + points[points.length - 1].x, y + points[points.length - 1].y); // last control point
  pg.endShape();
  
  // DRAW LEAVES
  boolean flipLeft = false;
  for (int i = 0; i < points.length; i++) {
    if (i % leafSep  == 0 && i > 0) {
      float posX = x + points[i].x;
      float posY = y + points[i].y;
      
      PShape leaf;
      float leafAngle = 0;
      stroke(leafC);
      // fill(leafC);

      // IMPORANT: In Processing 3, custom shapes don't work with P2D setsize!
      // YOU MUST USE P3D
      switch (leafType) {
        case 0:
          leaf = fernLeafL(10, 10, 2);
          leafAngle = points[i].heading();
          break;
      
        case 1:
          leaf = fernLeafLance(10, 30, 2, 0);
          leafAngle = PI/4 + points[i].heading();
          break;
      
        case 2:
          leaf = fernLeafLine(20, 2, 0);
          leafAngle = PI/4 + points[i].heading();
          break;
          
        default:
          leaf = null;
          break;
      }
      
      if (leaf != null) {
        pg.pushMatrix();
        pg.translate(posX, posY);
        if (flipLeft) {
          pg.scale(-1, 1);
        }
        pg.rotate(leafAngle);
        pg.shape(leaf, 0, 0);
        pg.popMatrix();
        flipLeft = !flipLeft;
      }
    }
  }
}
PShape fernLeafL(float w, float h, float sep) {
  PShape shape = createShape();
  shape.beginShape();
  for (int i = 0; i < w/sep; i++) {
    shape.curveVertex(i*sep, 0);
  }
  for (int j = 0; j < h/sep; j++) {
    shape.curveVertex(w, - j * sep);
  }
  shape.endShape();
  return shape;
}
PShape fernLeafLine(float len, float sep, float seed) {
  PShape shape = createShape();
  shape.beginShape();
  for (int i = 0; i < len/sep; i++) {
    shape.curveVertex(i*sep, - noise(len, seed)*i*sep);
  }
  shape.endShape();
  return shape;
}
PShape fernLeafLance(float w, float len, float sep, float seed) { // lanceolate leaf
  PShape shape = createShape();
  shape.beginShape();
  
  // bottom side
  for (int i = 0; i < len/sep; i++) {
    shape.curveVertex(i*sep, map(sin(PI * i/(len/sep)), -1, 1, 0, 0.5) * w);
  }
  
  // top side
  for (int i = ceil(len/sep); i >= 0; i--) {
    shape.curveVertex(i*sep, map(sin(PI * i/(len/sep)), -1, 1, 0.5, 0) * w);
  }
  
  shape.endShape();
  return shape;
}

/* --- RAIN WORLD POLE PLANTS --- */

// polePlantField(g, 300, height * (3.0/4), 600, 600)
void polePlantField(PGraphics pg, float stalkHeight, float fieldHorizon, float verSep, float horSep) {
  for (int row = floor((fieldHorizon-verSep)/verSep); row < (height + verSep)/verSep; row++) {
    for (int col = -1; col < (width + horSep)/horSep; col++) {
      pg.pushMatrix();
      pg.translate(col*horSep + noise(row, col)*horSep*2, row*verSep);
      pg.scale(row/((height + verSep)/verSep));

      // This makes them sway in the wind, which ruins the pole illusion
      // pg.rotate((noise(row/2, col/2, 0.3*frameCount/frameRateConst) - 0.5) * PI/4);
      // pg.rotate(sin(0.6*frameCount/frameRateConst) * PI/10);

      polePlant(pg, 
        noise(row, col, 0.1 * frameCount / frameRateConst),
        stalkHeight,
        0, 0,
        2, 50,

        // map(sin(frameCount / frameRateConst), -1, 1, 0, 1)
        constrain(sin(frameCount / frameRateConst), 0, 1)
      );

      pg.popMatrix();
    }
  }
}

/* Pole Plant (from Rain World)
 * Creates a moving pole plant that can fold up and disguise itself.
 * Requires P3D (Processing 3), or Processing 4.
 *
 * pg - PGraphics to draw on, g to just draw like normal
 * seed - seed controlling movement, static value for no movement
 * len - length of pole plant
 * x - x of bottom
 * y - y of bottom
 * leafSep - pixels between leaves
 * leafLen - max length of leaves (some leaves will be shorter)
 * showFactor - between 0 and 1; 1 = leaves are showing, movement; 0 = disguise as vertical pole, no movement
 *
 * Example: polePlant(g, seconds * 0.05, 500, origin.x, origin.y + 200, 2, 50, map(sin(seconds), -1, 1, 0, 1));
*/
void polePlant(PGraphics pg, float seed, float len, float x, float y, float leafSep, float leafLen, float showFactor) {
  // DEFINE COLORS

  color stemColor = #440000;
  color leafColor = #ff0000;

  // DRAW CENTER LINE - must be done separately from leaves

  // PVector[] randomCurve(float len, float sep, float rotate, float defaultAngle, float seed) {
  PVector[] points = randomCurve(len, max(3, len/200), 140 * showFactor, -90, seed);

  pg.noFill();
  pg.strokeWeight(3);
  pg.stroke(stemColor);
  pg.beginShape();
  pg.curveVertex(x, y); // 1st control point
  for (int i = 0; i < points.length; i++) {
    pg.curveVertex(x + points[i].x, y + points[i].y);
  }
  pg.curveVertex(x + points[points.length - 1].x, y + points[points.length - 1].y); // last control point
  pg.endShape();
  
  // DRAW LEAVES
  boolean flipLeft = false;
  if (showFactor > 0) {
    pg.strokeWeight(1);
  }
  pg.fill(lerpColor(stemColor, leafColor, showFactor * 1.5));

  for (int i = 0; i < points.length; i++) {
    if (i % leafSep  == 0 && i > 0) {
      float posX = x + points[i].x;
      float posY = y + points[i].y;

      // IMPORANT: In Processing 3, custom shapes don't work with P2D setsize!
      // YOU MUST USE Processing 4 - OR, USE P3D with Processing 3
      PShape leaf = fernLeafLance(
        10 * showFactor, // width of leaf decreases if plant is 'hiding', so leaves are less obvious
        leafLen * map(sin(i * 0.05), -1, 1, 0.2, 1), // RW's pole plants have different leaf lengths
        2, 0);

      float leafAngle = PI/4 + points[i].heading();
      leafAngle = leafAngle + (1 - showFactor) * (points[i].heading() - leafAngle);
      
        pg.pushMatrix();
        pg.translate(posX, posY);
        if (flipLeft) {
          pg.scale(-1, 1);
        }
        pg.rotate(leafAngle);
        pg.shape(leaf, 0, 0);
        pg.popMatrix();
        flipLeft = !flipLeft;
      }
    }
  }

/*
 * Bubbleweed from Rain World
*/
void bubbleweed(PGraphics pg, float seed, float x, float y) {
  // DEFINE COLORS

  color stemColor = #0A6F41;
  color leafColor = #2A84A5;

  // DRAW CENTER LINE
  // PVector[] randomCurve(float len, float sep, float rotate, float defaultAngle, float seed) {
  float len = noise(seed) * 20 + 30;
  PVector[] points = randomCurve(len, 3, 100, -90, seed);

  pg.noFill();
  pg.strokeWeight(3);
  pg.stroke(stemColor);
  pg.beginShape();
  pg.curveVertex(x, y); // 1st control point
  for (int i = 0; i < points.length; i++) {
    pg.curveVertex(x + points[i].x, y + points[i].y);
  }
  pg.curveVertex(x + points[points.length - 1].x, y + points[points.length - 1].y); // last control point
  pg.endShape();

  PVector endpoint = new PVector(x + points[points.length - 1].x, y + points[points.length - 1].y);

  // DRAW LEAVES
  for (int i = 0; i < 5; i++) {
    float len2 = noise(seed, i) * 10 + 15;
    PVector[] points2 = randomCurve(len2, 2, 60, noise(seed + i, i*2) * 200 - 220, seed * i);

    pg.noFill();
    pg.strokeWeight(3);
    pg.stroke(stemColor);
    pg.beginShape();
    pg.curveVertex(endpoint.x, endpoint.y); // 1st control point
    for (int j = 0; j < points2.length; j++) {
        pg.curveVertex(endpoint.x + points2[j].x, endpoint.y + points2[j].y);
    }
    pg.curveVertex(endpoint.x + points2[points2.length - 1].x, endpoint.y + points2[points2.length - 1].y); // last control point
    pg.endShape();

    PVector endpoint2 = new PVector(
        endpoint.x + points2[points2.length - 1].x,
        endpoint.y + points2[points2.length - 1].y);

    pg.fill(leafColor);
    pg.circle(endpoint2.x, endpoint2.y, 15);

    // highlight
    pg.fill(#ffffff, 100);
    pg.noStroke();
    pg.circle(endpoint2.x, endpoint2.y, 5);
  }
}