class Pheromone {
  float hue, value, maxValue;
  PVector origin;
  ParticleSystem pheromones;
  
  Pheromone(PVector pos, float value) {
    this.hue = 0;
    this.origin = new PVector(pos.x+CELL_SIZE/2, pos.y+CELL_SIZE/2);
    this.pheromones = new ParticleSystem(origin, hue);
    this.value = value;
    this.maxValue = 2;
  }

  void run() {
    if (isThere()) {
      pheromones.run(value);
      value -= PHEROMONE_DECAY;
    }
  }

  void addPheromone() {
    if (value < maxValue) {
      value++;
    }
  }

  boolean isThere() {
    return value > 0.1;
  }

  float getValue() {
    return value;
  }
}
