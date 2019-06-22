class GridItem {
  int x, y;

  ArrayList<Pheromone> pheromones;
  ArrayList<Food> foods;

  GridItem (int x, int y) {
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
    println(x, y);
    pheromones.add(new Pheromone(x*GRID_SIZE, y*GRID_SIZE, 10, 1000));
  }

  void addFood(Food food) {
    foods.add(food);
  }
}
