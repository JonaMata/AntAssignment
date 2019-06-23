class Cell {
  int x, y;

  ArrayList<Pheromone> pheromones;
  ArrayList<Nutriment> nutrition;

  Cell (int x, int y) {
    this.x = x;
    this.y = y;

    this.pheromones = new ArrayList<Pheromone>();
    this.nutrition = new ArrayList<Nutriment>();
  }

  void update() {
  }

  void display() {
    for (Pheromone pheromone : pheromones) {
      pheromone.display();
    }
    for(Nutriment nutriment : nutrition) {
      nutriment.display();
    }
  }

  void addPheromone() {
    pheromones.add(new Pheromone(x, y, CELL_SIZE/2, 1000));
  }

  void addFood() {
    nutrition.add(new Nutriment(x, y, CELL_SIZE));
  }
}
