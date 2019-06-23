class Pheromone {
  float x, y, size, hue, lifespan;

  Pheromone(float x, float y, float size, float lifespan) {
    this.x = x+CELL_SIZE/2;
    this.y = y+CELL_SIZE/2;
    this.size = size;
    this.lifespan = lifespan;
    hue = random(0, 255);
    colorMode(HSB);
  }

  void display() {
    pushMatrix();
    translate(x,y);
    noStroke();
    colorMode(HSB);
    fill(hue, 255, 255, lifespan);
    ellipse(0, 0, size*CELL_SIZE/2, size*CELL_SIZE/2);
    popMatrix();
    size *= exp(-0.001);
  }
  
  void addPheromone() {
    size++;
  }
  
  boolean isThere() {
    return size > 0.1;
  }
  
  float getSize() {
    return size;
  }
}
