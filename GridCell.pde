class Cell {
  int x, y;
  PVector pos;

  Pheromone pheromone;
  Nutriment nutriment;
  Nest nest;

  Cell (int x, int y) {
    this.x = x;
    this.y = y;
    this.pos = new PVector(x*CELL_SIZE, y*CELL_SIZE);
    this.pheromone = new Pheromone(pos, 0);
    this.nutriment = new Nutriment(pos.x, pos.y, 0);
    this.nest = null;
  }

  PVector getPos() {
    return pos;
  }

  int[] getCellIndex() {
    return new int[] {x, y};
  }

  boolean hasNutriment() {
    return nutriment.isThere();
  }

  boolean hasPheromone() {
    return pheromone.isThere();
  }

  float getNutrimentValue() {
    return nutriment.getSize();
  }

  float getPheromoneValue() {
    return pheromone.getSize();
  }

  void placePheromone() {
    pheromone.addPheromone();
  }

  void placeNutriment(int amount) {
    nutriment.addNutriment(amount);
  }

  void takeNutriment() {
    nutriment.removeNutriment();
  }

  void addNest() {
    nest = new Nest(pos.copy());
  }

  boolean hasNest() {
    return nest != null;
  }

  void highlight() {
    colorMode(RGB);
    fill(0, 255, 0, 50);
    rect(pos.x, pos.y, CELL_SIZE, CELL_SIZE);
  }

  void display() {
    pheromone.run();
    nutriment.display();
    if (nest != null) nest.display();
  }
}
