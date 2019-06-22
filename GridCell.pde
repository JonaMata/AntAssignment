class Cell {
  int x, y;

  Pheromone pheromone;
  ArrayList<Food> foods;

  Cell (int x, int y) {
    this.x = x;
    this.y = y;

    this.pheromone = new Pheromone(x, y, CELL_SIZE/2, 1000);
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

  void displayContent() {
      pheromone.display();
    //for(Food food : foods) {
    //  food.display();
    //}
  }
  
  void addFood(Food food) {
    foods.add(food);
  }
}
