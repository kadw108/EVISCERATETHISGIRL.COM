// halo2

void rotateRings() {
  fill(gold);
  noStroke();
  
  float rotY = 360 * (0.01 * frameCount/frameRateConst);
  for (int i = 0; i < 10; i++) {
    rotateCircle3D(origin.x, origin.y, 0, 90*i, 100*i, 0, rotY, 0);
  }
}
void rotateCircle3D(float x, float y, float z, float innerRad, float outerRad, float rotX, float rotY, float rotZ) {
  pushMatrix();
  translate(x, y, z);
  rotateX(radians(rotX));
  rotateY(radians(rotY));
  rotateZ(radians(rotZ));
  
  shape(makeDonut(innerRad, outerRad, 180));
  popMatrix();
}
PShape makeDonut(float innerRadius, float outerRadius, float steps) {
  PShape s = createShape();
  s.beginShape();
  for (float a=0; a<TAU; a+=TAU/steps) {
    s.vertex(outerRadius*cos(a), outerRadius*sin(a));
  }
  s.beginContour();
  for (float a=0; a<TAU; a+=TAU/steps) {
    s.vertex(innerRadius*cos(-a), innerRadius*sin(-a));
  }
  s.endContour();
  s.endShape(CLOSE);
  return s;
}
