// ARCHIVE

/* 
// UPGRADED EVEN BETTER (750x750) KARMA SPIRAL
background(0, 100);
  
imageMode(CENTER);
translate(origin.x, origin.y);
rotate(radians(fC2 * 3.6));

// void custRotatePosStar(float x, float y, float radius1, float radius2, int npoints, float deg, int cust)
// void dots_star(float x, float y, float radius1, float radius2, int dot_size, int npoints) {
stroke(#ffc740);
fill(0);
dots_star(0, 0, 360, 380, 7, 50);
dots_star(0, 0, 400, 410, 3, 100);
custStar(0, 0, 500, 430, 30, TRIANGLE_STRIP);

// void showKarma(float x, float y, float radius1, float radius2, float iconSize, float deg, color c, PGraphics main) {
for (int i = 0; i < 10; i++) {
  push();
  rotate(i * 36);
  showKarma(0, 0, i * 30 + 60, i * 30 + 60, 35 - i * 2, fC2 * 3.6 + i * 36, lerpColor(#ffffff, #ffc740, i/(float)9), g);
  pop();
}
image(karma[((int) (fC)) % 10], 0, 0, 50, 50);
*/

/*
// GOLD KARMA SPIRAL
imageMode(CENTER);
translate(origin.x, origin.y);
rotate(radians(seconds * 45));
// void showKarma(float x, float y, float radius1, float radius2, float iconSize, float deg, color c, PGraphics main) {
for (int i = 0; i < 15; i++) {
  push();
  rotate(i * 36);
  showKarma(0, 0, i * 30 + 70, i * 30 + 70, 40 - i * 2, fC2 * 10 + i * 36, lerpColor(#ffffff, #ffc740, i/(float)9), g);
  pop();
}
image(karma[((int) (16 * seconds)) % 10], 0, 0, 50, 50);
*/

/*
// WHITE FLOWER SPIRAL
imageMode(CENTER);
stroke(#040404);

// void showFlower(float x, float y, float radius1, float radius2, float flowerSize, float rotDeg, int npoints) {
for (int i = 0; i < 5; i++) {
  fill(lerpColor(#ffffff, #ffc740, i/4.0));
  showFlower(origin.x, origin.y, i * 30 + 70, i * 30 + 70, 40 - i * 8, fC2 * 6 + i * i, 5);
}

// void flower(float x, float y, int petals, float size, float len, float deg) {
stroke(#ffffff);
strokeWeight(1);
fill(#000000);
flower(origin.x, origin.y, 11, 4, 2, (map(sin(frameCount/(frameRateConst/3)), -1, 1, 0, 1)*360));
*/

/*
// Karma array that inverts color left to right
Saving for later when I can think of better ideas for how to use.

background(0);
main = createGraphics(1080, 720);
main.beginDraw();

// PGraphics xCircle(int rad, float lineWidth, color c, boolean filter)
main.imageMode(CENTER);
main.tint(#ffc740, 255);
main.image(xCircle(200, 60, #ffffff, false), origin.x, origin.y);
main.endDraw();

// PGraphics createTextScreen(int[][] karmaArray, PGraphics main) {
karmaArray = kaFlicker(kaColorShift(genKarmaArray(main, fC * noise(fC) + 0.01), fC), fC);
// KarmaChar[][] ka2 = genLevelArray(main, 0);
KarmaChar[][] ka2 = cloneKA(karmaArray);
kaInvert(ka2);
kaMergeColMajor(ka2, karmaArray, frameCount * 100);
ka2 = kaMerge(karmaArray, ka2);
PGraphics finalText = createTextScreen(ka2, main.width, main.height);

image(finalText, 0, 0);

*/

/*
// expanding waveShapePS over 3 seconds
// waveShapePS(float x0, float y0, float radius1, float radius2, int npoints, float seed)
PShape waveC = waveShapePS(origin.x, origin.y, seconds/3 * width * 0.5, seconds/3 * width * 0.5 * 1.2, 360, 0);
waveC.setFill(false);
waveC.setStroke(255);
waveC.setStrokeWeight(2);
main.shape(waveC);

main.endDraw();
image(main, 0, 0);
*/

/*
// Weird combination of stuff made to show at CAC
image(althWaves(origin.y + 100, 10, 100), 0, 0);

noStroke();
for (int i = 0; i < 10; i++) {
  columnField(2, 2, (int)(i * frameRateConst));
}

// background(0);
// stroke(lerpColor(#1188ff, #ffffff, sin(frameCount/frameRateConst)));
// expandingShape(#66ccff);

// drawMandala(float x, float y, float radius, float radius2, color c)
// drawMandala(origin.x, origin.y, 100, 500, lerpColor(#1188ff, #eeeeee, sin(frameCount/frameRateConst)));
// translate(0, 0, 0.9);

//growFlower(float x, float y, float w, float h, float flowerSize, int growSeconds, int startFrame, color stem, color flower)
// image(growFlower(origin.x, origin.y, 50, 100, 20, 0, 0, gold, gold), 0, 0);

noStroke();

// lineFromPoints(randomCurve(500, 5, 130, -90, 0), origin.x, origin.y);
// fernFromPoints(randomCurve(900, 5, 130, -90, 0), origin.x, origin.y + 400, 5, 1);
// chainFromPoints(PVector[] points, float x, float y, float linkLen, float spaceBetween) {
    
if (frameCount % 10 == 0) {
  ps.addParticleAround(3, 50);
}
noFill();
stroke(lerpColor(#ffffff, #3399ff, sin(frameCount/frameRateConst)));
((ParticleSystemF) ps).run(flowField(100, 100, 1, frameCount/frameRateConst));

fill(lerpColor(#1188ff, #ffffff, sin(frameCount/frameRateConst)));
    
pushMatrix();
translate(0, 0, 0);
image(althWaves(origin.y + 100, 10, 100), 0, 0);
popMatrix();
  
drawMandala(origin.x, origin.y, 100, 500, lerpColor(#1188ff, #eeeeee, sin(frameCount/frameRateConst)));

float fC = frameCount - 120;
// glitchCloudCube(float x, float y, float z, float randr, float num, float size, float seed, float speed)
glitchCloudCube(origin.x, origin.y, 0, fC / frameRateConst * 95, 50 * 0.2 * fC/frameRateConst, fC/frameRateConst * 15, frameCount, 0.1);
*/
