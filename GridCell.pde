class Cell {
  int x, y;
  PVector pos;

  Pheromone pheromone;
  ArrayList<Food> foods;

  Cell (int x, int y) {
    this.x = x;
    this.y = y;
    
    this.pos = new PVector(x*CELL_SIZE,y*CELL_SIZE);

    this.pheromone = new Pheromone(pos.x, pos.y, 0, 1000);
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
    pheromone.display();
  }
  
  PVector getPos() {
    return pos;
  }
  
  int[] getGridPos() {
    return new int[] {x,y};
  }
  
  
  boolean hasFood() {
    return foods.size()>0;
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
    fill(0,255,0);
    rect(pos.x,pos.y,CELL_SIZE,CELL_SIZE);
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
