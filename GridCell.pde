class Cell {
  int x, y;

  ArrayList<Pheromone> pheromones;
  ArrayList<Food> foods;

  Cell (int x, int y) {
    this.x = x;
    this.y = y;

    this.pheromones = new ArrayList<Pheromone>();
    this.foods = new ArrayList<Food>();
  }

  void update() {
    //for(Pheromone pheromone : pheromones) {
    //  pheromone.update();
    //}
    //for(Food food : foods) {
    //  food.update();
    //}
  }

  void display() {
    for (Pheromone pheromone : pheromones) {
      pheromone.display();
    }
    //for(Food food : foods) {
    //  food.display();
    //}
  }

  void addPheromone() {
    pheromones.add(new Pheromone(x, y, CELL_SIZE/2, 1000));
  }

  void addFood(Food food) {
    foods.add(food);
  }
}
