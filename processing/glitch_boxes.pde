// glitch_boxes
  
  // glitchCloudCube(origin.x, origin.y, 0, 100, 5, 20, 0, 1);
  // glitchCloudSquare(origin.x, origin.y, 0, 150, 5, 10, 6, 1);
  // glitchCloudImage(karma[(frameCount/(int)frameRateConst % 10)], gold, origin.x, origin.y, 0, 150, 10, 30, 6, 1);
  // glitchCloudArray(karma, gold, origin.x, origin.y, 0, 150, 10, 30, 6, 1);
  // glitchCloudSquare2(gold, origin.x, origin.y, 0, 200, 10, 20, 6, 1);

// 3D, cloud of glitchy squares/cubes around a center point
void glitchCloudCube(float x, float y, float z, float randr, float num, float size, float seed, float speed) {
   for (int i = 0; i < num; i++) {
    // random(noise) nums
    float xn = noise(x + i + frameCount*speed + seed)-0.5;
    float yn = noise(x + y + i + frameCount*speed + seed)-0.5;
    float zn = noise(x + y + z, i + frameCount*speed + seed)-0.5;
    // position nums
    float xx = xn*randr;
    float yy = yn*randr;
    float zz = zn*randr;
    // rotation nums
    float rotX = xn*360;
    float rotY = yn*360;
    float rotZ = zn*360;

    placeBox(x + xx, y + yy, z + zz,
      rotX, rotY, rotZ, size);
  }
}
void glitchCloudSquare(PGraphics pg, float x, float y, float z, float randr, float num, float size, float seed, float speed) {
  for (int i = 0; i < num; i++) {
    // random(noise) nums
    float xn = noise(x + i + frameCount*speed + seed)-0.5;
    float yn = noise(y + i + frameCount*speed + seed)-0.5;
    float zn = noise(z + i + frameCount*speed + seed)-0.5;
    // position nums
    float xx = xn*randr;
    float yy = yn*randr;
    float zz = zn*randr;
    /*
    // rotation nums
    float rotX = xn*360;
    float rotY = yn*360;
    float rotZ = zn*360;
    */
    
    placeSquare(pg, x + xx, y + yy, 0, 0, size);
  }
}
void glitchCloudSquare2D(PGraphics pg, float x, float y, float randr, float num, float size, float seed, float speed) {
  for (int i = 0; i < num; i++) {
    // random(noise) nums
    float xn = noise(x + i + frameCount*speed + seed)-0.5;
    float yn = noise(y + i + frameCount*speed + seed)-0.5;
    // position nums
    float xx = xn*randr;
    float yy = yn*randr;
    /*
    // rotation nums
    float rotX = xn*360;
    float rotY = yn*360;
    */
    
    placeSquare2D(pg, x + xx, y + yy, 0, size);
  }
}
void glitchCloudSquare2(color c, float x, float y, float z, float randr, float num, float size, float seed, float speed) {
  for (int i = 0; i < num; i++) {
    // random(noise) nums
    float xn = noise(x + i + frameCount*speed + seed)-0.5;
    float yn = noise(y + i + frameCount*speed + seed)-0.5;
    float zn = noise(z + i + frameCount*speed + seed)-0.5;
    // position nums
    float xx = xn*randr;
    float yy = yn*randr;
    float zz = zn*randr;
    /*
    // rotation nums
    float rotX = xn*360;
    float rotY = yn*360;
    float rotZ = zn*360;
    */
    
    placeSquare2(x + xx, y + yy, z + zz, 0, size, lerpColor(c, 0, xn + random(0.5)), lerpColor(c, 0, yn + random(0.5)), lerpColor(c, 0, zn + random(0.5)));
  }
}
void glitchCloudImage(PImage image, color c, float x, float y, float z, float randr, float num, float size, float seed, float speed) {
  for (int i = 0; i < num; i++) {
    // random(noise) nums
    float xn = noise(x + i + frameCount*speed + seed)-0.5;
    float yn = noise(y + i + frameCount*speed + seed)-0.5;
    float zn = noise(z + i + frameCount*speed + seed)-0.5;
    // position nums
    float xx = xn*randr;
    float yy = yn*randr;
    float zz = zn*randr;
    
    float rotX = xn*360;
    /*
    // rotation nums
    float rotX = xn*360;
    float rotY = yn*360;
    float rotZ = zn*360;
    */
    
    placeImage(image, x + xx, y + yy, z + zz, 0, size, c);
  }
}
void glitchCloudArray(PImage[] images, color c, float x, float y, float z, float randr, float num, float size, float seed, float speed) {
  for (int i = 0; i < num; i++) {
    // random(noise) nums
    float xn = noise(x + i + frameCount*speed + seed)-0.5;
    float yn = noise(y + i + frameCount*speed + seed)-0.5;
    float zn = noise(z + i + frameCount*speed + seed)-0.5;
    // position nums
    float xx = xn*randr;
    float yy = yn*randr;
    float zz = zn*randr;
    
    float rotX = xn*360;
    /*
    // rotation nums
    float rotX = xn*360;
    float rotY = yn*360;
    float rotZ = zn*360;
    */
 
    tint(c, 255);
    // showFrame(PImage[] array, float deg, float x, float y, float h, float w, int shift)
    showFrame(images, rotX, xx, yy, size, size, i);
    tint(255, 255);
  }
}

void placeImage(PImage image, float x, float y, float z, float rot, float size, color c) {
  pushMatrix();
  translate(x, y, z);
  rotate(radians(rot));
  tint(c, 255);
  image(image, 0, 0, size, size);
  tint(255, 255);
  popMatrix();
}

void placeSquare(PGraphics pg, float x, float y, float z, float rot, float size) {
  pg.pushMatrix();
  pg.translate(x, y, z);
  pg.rotate(radians(rot));
  pg.square(0, 0, size);
  pg.popMatrix();
}

void placeSquare2D(PGraphics pg, float x, float y, float rot, float size) {
  pg.pushMatrix();
  pg.translate(x, y);
  pg.rotate(radians(rot));
  pg.square(0, 0, size);
  pg.popMatrix();
}

void placeSquare2(float x, float y, float z, float rot, float size, color fil1, color fil2, color line) {
  pushMatrix();
  translate(x, y, z);
  rotate(radians(rot));
  
  stroke(line);
  fill(fil1);
  square(0, 0, size);
  
  noStroke();
  fill(fil2);
  square(size/4, size/4, size/2);
  popMatrix();
}

void placeBox(float x, float y, float z, float rotX, float rotY, float rotZ, float size) {
  pushMatrix();
  translate(x, y, z);
  rotateX(radians(rotX));
  rotateY(radians(rotY));
  rotateZ(radians(rotZ));
  box(size);
  popMatrix();
}

/* ---------------- */

void glitchCloudSquare3(PImage texture, float x, float y, float z, float randr, float num, float size, float seed, float speed) {
    PGraphics pg = createGraphics(width, height);
    pg.beginDraw();
    for (int i = 0; i < num; i++) {
      // random(noise) nums
      float xn = noise(x + i + frameCount*speed + seed)-0.5;
      float yn = noise(y + i + frameCount*speed + seed)-0.5;
      float zn = noise(z + i + frameCount*speed + seed)-0.5;
      // position nums
      float xx = xn*randr;
      float yy = yn*randr;
      float zz = zn*randr;
      float rotX = xn*360;
      /*
      // rotation nums
      float rotX = xn*360;
      float rotY = yn*360;
      float rotZ = zn*360;
      */
      
      pg.pushMatrix();
      pg.translate(x + xx, y + yy);
      // pg.rotate(radians(rotX));
      pg.fill(255);
      pg.square(0, 0, size);
      pg.popMatrix();
  }
  pg.endDraw();
  
  texture.mask(pg);
  image(texture, 0, 0);
}

void glitchCloudRect(PImage texture, float x, float y, float randr, float num, float rectw, float recth, float seed, float speed) {
    PGraphics pg = createGraphics(width, height);
    pg.beginDraw();
    for (int i = 0; i < num; i++) {
      // random(noise) nums
      float xn = noise(x + i + frameCount*speed + seed)-0.5;
      float yn = noise(y + i + frameCount*speed + seed)-0.5;
      // position nums
      float xx = xn*randr;
      float yy = yn*randr;
      float rot = xn*360;
      
      pg.pushMatrix();
      pg.translate(x + xx, y + yy);
      // pg.rotate(radians(rotX));
      pg.fill(255);
      pg.rect(0, 0, rectw * noise(i + frameCount*speed + seed), recth * noise(i + frameCount*speed + seed));
      pg.popMatrix();
  }
  pg.endDraw();
  
  texture.mask(pg);
  image(texture, 0, 0);
}
