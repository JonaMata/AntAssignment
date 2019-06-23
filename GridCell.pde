class Cell {
  int x, y;
  PVector pos;

  Pheromone pheromone;
  ArrayList<Nutriment> nutrition;

  Cell (int x, int y) {
    this.x = x;
    this.y = y;

    this.pos = new PVector(x*CELL_SIZE, y*CELL_SIZE);

    this.pheromone = new Pheromone(pos.x, pos.y, 0, 1000);
    this.nutrition = new ArrayList<Nutriment>();
  }

  PVector getPos() {
    return pos;
  }

  int[] getGridPos() {
    return new int[] {x, y};
  }


  boolean hasFood() {
    return nutrition.size()>0;
  }

  boolean hasPheromone() {
    return pheromone.isThere();
  }

  float getPheromoneScore() {
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
    for (Nutriment nutriment : nutrition) {
      nutriment.display();
    }
  }

  void addFood(int amount) {
    for (int i = 0; i < amount; i++) {
      nutrition.add(new Nutriment(x, y, CELL_SIZE));
    }
  }
}
