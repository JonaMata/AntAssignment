class Cell {
  int x, y;
  PVector pos;

  Pheromone pheromone;
  Nutriment nutriment;

  Cell (int x, int y) {
    this.x = x;
    this.y = y;

    this.pos = new PVector(x*CELL_SIZE, y*CELL_SIZE);

    this.pheromone = new Pheromone(pos.x, pos.y, 0, 1000);
    this.nutriment = new Nutriment(pos.x, pos.y, 0);
  }

  PVector getPos() {
    return pos;
  }

  int[] getGridPos() {
    return new int[] {x, y};
  }


  boolean hasFood() {
    return nutriment != null;
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

  void highlight() {
    colorMode(RGB);
    fill(0, 255, 0);
    rect(pos.x, pos.y, CELL_SIZE, CELL_SIZE);
  }

  void display() {
    pheromone.display();
    nutriment.display();
  }

  void placeNutriment(int amount) {
    nutriment.addNutriment(amount);
  }
}
