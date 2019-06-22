class Grid {
  ArrayList<Ant> ants;
  Cell[][] cells;
  Nest nest;

  Grid() {
    cells = new Cell[GRID_WIDTH][GRID_HEIGHT];
    for (int i = 0; i < GRID_WIDTH; i++) {
      for (int j = 0; j < GRID_HEIGHT; j++) {
        cells[i][j] = new Cell(i*CELL_SIZE, j*CELL_SIZE);
      }
    }
    ants = new ArrayList<Ant>();
    nest = new Nest(cells[(int)random(0, GRID_WIDTH)][(int)random(0, GRID_WIDTH)]);
  }

  void display() {
    for (int i = 0; i < GRID_HEIGHT; i++) {
      for (int j = 0; j < GRID_WIDTH; j++) {
        cells[i][j].display();
      }
    }
    for (Ant ant : ants) {
      ant.display();
      if (ant.canSearch()) {
        Cell currentCell = ant.getCell(cells);
        currentCell.addPheromone();
        int[] destPos = {
          constrain(currentCell.x/CELL_SIZE+(int)random(-1, 2), 0, GRID_WIDTH), 
          constrain(currentCell.y/CELL_SIZE+(int)random(-1, 2), 0, GRID_HEIGHT)
        };
        Cell newDest = cells[destPos[0]][destPos[1]];
        ant.setDest(newDest);
      }
    }
    nest.display();
  }

  void addAnts(int amount) {
    for (int i = 0; i < amount; i++) {
      ants.add(nest.spawnAnt());
    }
  }

  void displayGrid() {
    for (int x = 1; x < GRID_WIDTH; x++) {
      stroke(0);
      strokeWeight(1);
      line(x*CELL_SIZE, 0, x*CELL_SIZE, height);
    }

    for (int y = 1; y < GRID_HEIGHT; y++) {
      stroke(0);
      strokeWeight(1);
      line(0, y*CELL_SIZE, width, y*CELL_SIZE);
    }
  }
}
