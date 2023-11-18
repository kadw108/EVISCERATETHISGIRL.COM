// flow

/*
  PVector[][] flowField = flowField(100, 100, 0.1, frameCount/frameRateConst);
  // image(drawVecs(flowField), 0, 0);
  
  fill(sin(0.2 * frameCount/frameRateConst) * 255);
  noStroke();
  // stroke(#ffffff);
  // strokeWeight(10);
  if (frameCount % 2 == 0)
    ps.addParticleAround(0, 5);
  ((ParticleSystemF) ps).run(flowField);
*/

PVector[][] flowField(float w, float h, float factor, float seed) {
  int rows = ceil(height/h);
  int cols = ceil(width/w);

  float vecLength = min(w, h)/2;
  
  PVector[][] grid = new PVector[rows][cols];
  for (int i = 0; i < rows; i++) {
    for (int j = 0; j < cols; j++) {
      
      float xDir = map(noise(i*factor, seed), 0, 1, -1, 1);
      float yDir = map(noise(j*factor, seed), 0, 1, -1, 1);
      grid[i][j] = new PVector(xDir, yDir).setMag(vecLength);
      
      /*
      float angle = noise(i*factor, j*factor, seed) * TWO_PI;
      grid[i][j] = PVector.fromAngle(angle).setMag(vecLength);
      */
    }
  }
  
  return grid;
}

PGraphics drawVecs(PVector[][] flowField) {
  PGraphics pg = createGraphics(width, height);
  pg.beginDraw();
  
  pg.stroke(#ffffff);
  
  int rows = flowField.length;
  int cols = flowField[0].length;
  float w = width/flowField[0].length;
  float h = height/flowField.length;
  
  for (int i = 0; i < rows; i++) {
    for (int j = 0; j < cols; j++) {
      PVector p = flowField[i][j];
      
      pg.pushMatrix();
      pg.translate(j*w + w/2, i*h + h/2);
       
      // pg.rotate(flowField[i][j].heading());
      pg.line(0, 0, p.x, p.y);
      // pg.line(0, 0, 20, 0);
      pg.popMatrix();
    }
  }
  
  pg.endDraw();
  return pg;
}

// adds flow to particles
class ParticleSystemF extends ParticleSystem {
  ParticleSystemF(PVector position) {
    super(position);
  }
  
  void follow(BaseParticle p, PVector[][] flowField) {
    float w = width/flowField[0].length;
    float h = height/flowField.length;
    
    int col = constrain(floor(p.position.x / w), 0, flowField[0].length-1);
    int row = constrain(floor(p.position.y / h), 0, flowField.length-1);
    PVector force = flowField[row][col].setMag(0.1);
    
    // apply force
    // p.acceleration.add(force);
    p.velocity.add(force);
  }

  void run(PVector[][] flowField) {
    for (int i = particles.size()-1; i >= 0; i--) {
      BaseParticle p = particles.get(i);
      
      p.run();
      follow(p, flowField);
      
      if (p.isDead() ||
          ((!(p instanceof PersistLine)) && exceedsRadius(new float[] {p.position.x, p.position.y}, 50))) {
        particles.remove(i);
      }
    }
  }
}
