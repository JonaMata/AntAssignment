class Grid {
  ArrayList<Ant> ants;
  Cell[][] cells;

  Grid() {
    ants = new ArrayList<Ant>();
    cells = new Cell[GRID_HEIGHT][GRID_WIDTH];
    for (int i = 0; i < GRID_HEIGHT; i++) {
      for (int j = 0; j < GRID_WIDTH; j++) {
        cells[i][j] = new Cell(i*CELL_SIZE, j*CELL_SIZE);
      }
    }
  }

  void display() {
    for(Ant ant : ants) {
      ant.display();
      if(ant.canSearch()) {
        ant.setDest(cells[(int)random(0, GRID_HEIGHT)][(int)random(0, GRID_WIDTH)]);
      }
    }
    //for (int i = 0; i < GRID_HEIGHT; i++) {
    //  for (int j = 0; j < GRID_WIDTH; j++) {
    //    cells[i][j].displayContent();
    //  }
    //}
  }

  void addRandomAnts() {
    Cell randomCell = cells[(int)random(0, GRID_HEIGHT)][(int)random(0, GRID_WIDTH)];
    ants.add(new Ant(randomCell.x, randomCell.y, CELL_SIZE, CELL_SIZE));
  }

  void displayGrid() {
    for (int x = 1; x < GRID_WIDTH; x++) {
      stroke(0);
      strokeWeight(1);
      line(x*CELL_SIZE, 0, x*CELL_SIZE, height);
    }
    for (int y = 1; y < GRID_WIDTH; y++) {
      stroke(0);
      strokeWeight(1);
      line(0, y*CELL_SIZE, width, y*CELL_SIZE);
    }
  }
}
