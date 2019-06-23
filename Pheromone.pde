class Pheromone {
  float x, y, hue, size, maxSize;
  
  Pheromone(float x, float y, int size) {
    this.x = x+CELL_SIZE/2;
    this.y = y+CELL_SIZE/2;
    this.size = size;
    this.maxSize = 2;
    hue = random(0, 255);
    colorMode(HSB);
  }

  void display() {
    pushMatrix();
    translate(x, y);
    noStroke();
    colorMode(HSB);
    fill(hue, 255, 255);
    ellipse(0, 0, size*CELL_SIZE/2, size*CELL_SIZE/2);
    popMatrix();
    size *= exp(-0.001);
  }

  void addPheromone() {
    if (size+0.5 < maxSize) {
      size += 0.5;
    }
  }

  boolean isThere() {
    return size > 0.1;
  }

  float getSize() {
    return size;
  }
}
