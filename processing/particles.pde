// particles

boolean exceedsRadius(float[] pos, float radius) {
  if (pos[0] > width+radius || pos[0] < 0 - radius ||
      pos[1] > height+radius || pos[1] < 0 - radius) {
        
      return true;
  }
  return false;
}

class BaseParticle {
  PVector position;
  PVector velocity;
  PVector acceleration;
  float lifespan;
  float size;

  BaseParticle(PVector l) {
    velocity = new PVector(random(1), random(1));
    // velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);
    position = l.copy();
    lifespan = 255.0;
    size = 5;
  }

  void run() {
    update();
    display();
  }

  // Method to update position
  void update() {
    velocity.add(acceleration);
    position.add(velocity);
    lifespan -= 0.5;
  }

  // Method to display
  void display() {
    circle(position.x, position.y, size);
  }

  // Is the particle still useful?
  boolean isDead() {
    if (lifespan < 0.0) {
      return true;
    } else {
      return false;
    }
  }
}

// A class to describe a group of BaseParticles
class ParticleSystem {
  ArrayList<BaseParticle> particles;
  PVector origin;

  ParticleSystem(PVector position) {
    origin = position.copy();
    particles = new ArrayList<BaseParticle>();
  }
  
  void addParticle(int whichParticle) {
    for (int i = 0; i < 10; i++) {
      addActualParticle(whichParticle, origin);
    }
  }
  void addParticle(int whichParticle, PVector loc) {
    for (int i = 0; i < 10; i++) {
      addActualParticle(whichParticle, loc);
    }
  }
  void addParticleAround(int whichParticle, float radius) {
    // 3 on each side (3*4 = 12 new particles)
    
    // left
    for (int i = 0; i < 3; i++) {
      addActualParticle(whichParticle, new PVector(0 - radius, random(height)));
    }
    
    // right
    for (int i = 0; i < 3; i++) {
      addActualParticle(whichParticle, new PVector(width + radius, random(height)));
    }
    
    // top
    for (int i = 0; i < 3; i++) {
      addActualParticle(whichParticle, new PVector(random(width), 0 - radius));
    }
    
    // bottom
    for (int i = 0; i < 3; i++) {
      addActualParticle(whichParticle, new PVector(random(width), height + radius));
    }
  }
  
  void addActualParticle(int whichParticle, PVector loc) {
    switch(whichParticle) {
      case 1:
        particles.add(new Particle(loc));
        break;
        
      case 2:
        particles.add(new Particle2(loc));
        break;
        
      case 3:
        particles.add(new PersistLine(loc));
        break;
        
      default:
        particles.add(new BaseParticle(loc));
    }
  }

  void run() {
    for (int i = particles.size()-1; i >= 0; i--) {
      BaseParticle p = particles.get(i);
      p.run();
      if (p.isDead()) {
        particles.remove(i);
      }
    }
  }
}

/* ---------------- gold 'dust' particle ------------------ */
class Particle extends BaseParticle {
  Particle(PVector l) {
    super(l);
    acceleration = new PVector(0, -3);
    velocity = new PVector(random(-50, 50), random(4, 10));
  }

  // Method to display
  void display() {
    noStroke();
    color c = gold;
    fill(c, lifespan);
    ellipse(position.x, position.y, random(1, 3), random(4, 6));
  }
}

/* ---------------- gold rain particle ------------------ */
class Particle2 extends BaseParticle {
  float len; // length

  Particle2(PVector l) {
    super(l);
    acceleration = new PVector(0, 5);
    velocity = new PVector(random(-15, 15), random(4, 10));
    len = random(25, 150 * 2);
  }

  // Method to display
  void display() {
    noStroke();
    fill(gold, lifespan);
    ellipse(position.x, position.y, random(2, 4), len);
  }
}

/* ---------------- line ------------------- */
class PersistLine extends BaseParticle {
  float[][] points;
  
  PersistLine(PVector l) {
    super(l);
    int saveLen = 500;
    points = new float[saveLen][2];
    for (float[] i : points) {
      i = null;
    }
  }
  
  void updatePoints() {
    lifespan = 1;
    
    for (int i = points.length - 2; i >= 0; i--) {
      points[i+1] = points[i];
    }
    points[0] = new float[] {position.x, position.y};
    
    boolean allOOB = true;
    for (int i = 0; i < points.length; i++) {
      if (points[i] != null && exceedsRadius(points[i], 50)) {
        points[i] = null;
      }
      else {
        allOOB = false;
      }
    }
    if (allOOB) {
      lifespan = -1;
    }
  }
  
  void display() {
    beginShape();
    for (int i = 0; i < points.length; i++) {
      if (points[i] != null && (points[i][0] != 0 && points[i][1] != 0)) {
        curveVertex(points[i][0], points[i][1], size);
      }
    }
    endShape();
    
    updatePoints();
  }
}
