class WorldManager {
  Grid grid;
  ArrayList<Ant> ants;

  WorldManager() {
    grid = new Grid();
    ants = new ArrayList<Ant>(ANTS);
    for (int i = 0; i < ANTS; i++) {
      ants.add(new Ant(grid.getRandomPos(), CELL_SIZE));
    }
    grid.getRandomCell().addNest();
    grid.placeRandomNutrition();
  }

  void run() {
    grid.display();
    grid.update();
    if (DEBUG) grid.displayGrid();
    for (Ant ant : ants) {
      ant.run(); 
      ant.move(grid.cells);
    }
  }

  void addAnts(int amount) {
    for (int i = 0; i < amount; i++) {
      ants.add(new Ant(grid.getRandomPos(), CELL_SIZE));
    }
  }
}
