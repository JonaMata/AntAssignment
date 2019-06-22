class Pheromone {
  float x, y, size, hue, lifespan;

  Pheromone(float x, float y, float size, float lifespan) {
    this.x = x;
    this.y = y;
    this.size = size;
    this.lifespan = lifespan;
    hue = random(0, 255);
    colorMode(HSB);
    noStroke();
  }

  void display() {
    fill(hue, 255, 255, lifespan);
    ellipse(x, y, size, size);
    lifespan *= exp(-0.05);
  }

  boolean isFaded() {
    return lifespan < 1 ? true : false;
  }
}
