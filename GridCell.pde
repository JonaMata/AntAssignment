class Cell {
  int x, y;
  PVector pos;
  boolean obstacle = false;

  Pheromone pheromone;
  Nutriment nutriment;

  Cell (int x, int y) {
    this.x = x;
    this.y = y;
    this.pos = new PVector(x*CELL_SIZE, y*CELL_SIZE);
    this.pheromone = new Pheromone(pos, 0);
    this.nutriment = null;
  }

  PVector getPos() {
    return pos;
  }

  int[] getCellIndex() {
    return new int[] {x, y};
  }

  boolean hasNutriment() {
    if (nutriment != null) return nutriment.isThere();
    else return false;
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
    if (nutriment != null) {
      nutriment.addNutriment(amount);
    } else {
      nutriment = new Nutriment(pos, amount);
    }
  }

  void takeNutriment() {
    if (nutriment != null) nutriment.removeNutriment();
    if (nutriment.value < 1) nutriment = null;
  }

  void highlight() {
    colorMode(RGB);
    fill(0, 255, 0, 50);
    rect(pos.x, pos.y, CELL_SIZE, CELL_SIZE);
  }

  void display() {
    pheromone.run();
    if (nutriment != null) nutriment.display();
    if (obstacle) {
      fill(255, 0, 0);
      rect(pos.x, pos.y, CELL_SIZE, CELL_SIZE);
    }
  }

  void toggleObstacle() {
    obstacle=!obstacle;
  }

  boolean hasObstacle() {
    return obstacle;
  }
}
