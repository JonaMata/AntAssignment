class WorldManager {
  Grid grid;
  Nest nest;
  ArrayList<Ant> ants;

  WorldManager() {
    grid = new Grid();
    nest = new Nest(grid.getRandomPos());
    ants = new ArrayList<Ant>(ANTS);
    for (int i = 0; i < ANTS; i++) {
      ants.add(new Ant(grid.getRandomPos(), CELL_SIZE, nest.getPos()));
    }
    grid.placeRandomNutrition();
  }

  void run() {
    grid.display();
    grid.update();
    nest.display();
    if (DEBUG) grid.displayGrid();
    for (Ant ant : ants) {
      ant.run();
      ArrayList<Cell> antSightCells = grid.getSight(ant.getSearchPos(), ant.getHeading());
      ant.move(antSightCells);
    }
  }

  void addAnts(int amount) {
    for (int i = 0; i < amount; i++) {
      ants.add(new Ant(grid.getRandomPos(), CELL_SIZE, nest.getPos()));
    }
  }
}
