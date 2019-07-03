// WorldManager manages the world consisting of the grid, nest and ants.

class WorldManager {
  Grid grid;
  Nest nest;
  ArrayList<Ant> ants;

  WorldManager() {
    grid = new Grid();
    nest = new Nest(grid.getRandomPos());
    ants = new ArrayList<Ant>(ANTS);
    grid.placeRandomNutrition();
    addAnts(ANTS);
  }

  void run() {
    grid.display();
    grid.update();
    nest.display();
    if (DEBUG) grid.displayGrid(); // display the grid lines when debugging
    for (Ant ant : ants) {
      ant.run();
      ArrayList<Cell> antSightCells = grid.getSight(ant.getSearchPos(), ant.getHeading());
      ant.move(antSightCells);
    }
    
    addAnts(nest.getSpawnAmount()); // spawn ants at nest when enough nutrition is collected
  }
  
  // spawn ants at the nest's location
  void addAnts(int amount) {
    for (int i = 0; i < amount; i++) {
      ants.add(new Ant(nest.getPos(), CELL_SIZE, nest));
    }
  }
  
  // handle mouse inputs
  void mouseClick(int clickX, int clickY, int button) {
    grid.mouseClick(clickX, clickY, button);
  }
}
