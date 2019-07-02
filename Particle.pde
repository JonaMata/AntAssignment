class Particle {
  PVector pos, vel;
  float hue;
  
  float range = 0.1;  
  float alpha = 1000;
  
  // initialize particle with random velocity and acceleration
  Particle(PVector pos, float hue) {
    this.pos = pos.copy();
    this.vel = new PVector(random(-range, range), random(-range, range));
    this.hue = constrain(hue, 0, 255);
  }
  
  // accelerate particle and exponentialy decay it's alpha value
  void update() {
    pos.add(vel);
    alpha *= exp(-0.1);
  }
  
  // update and display particle
  void run(float size) {
    update();
    display(size);
  }
  
  // display particle
  void display(float size) {
    size = size*CELL_SIZE/20;
    colorMode(HSB);
    noStroke();
    fill(hue, 255, 255, alpha);
    ellipse(pos.x, pos.y, size, size);
  }
  
  // check if particle has expired
  boolean isDead() {
    return alpha < 1;
  }
}
