// Particle object displays and moves particles that exponentially decay.

class Particle {
  PVector pos, vel;
  float hue;
  
  float range = 0.1;  
  float alpha = 1000;
  
  Particle(PVector pos, float hue) {
    this.pos = pos.copy();
    this.vel = new PVector(random(-range, range), random(-range, range));
    this.hue = constrain(hue, 0, 255);
  }
  
  void update() {
    pos.add(vel);
    alpha *= exp(-0.1); // exponentially decay particle's alpha value
  }
  
  void run(float size) {
    update();
    display(size);
  }
  
  void display(float size) {
    size = size*CELL_SIZE/20;
    colorMode(HSB);
    noStroke();
    fill(hue, 255, 255, alpha);
    ellipse(pos.x, pos.y, size, size);
  }
  
  // returns if particle has expired
  boolean isDead() {
    return alpha < 1;
  }
}
