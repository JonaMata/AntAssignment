class Grid {
  ArrayList<Ant> ants;
  Cell[][] cells;

  Grid() {
    ants = new ArrayList<Ant>();
    cells = new Cell[GRID_WIDTH][GRID_HEIGHT];
    for (int i = 0; i < GRID_WIDTH; i++) {
      for (int j = 0; j < GRID_HEIGHT; j++) {
        cells[i][j] = new Cell(i*CELL_SIZE, j*CELL_SIZE);
      }
    }
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
        ant.getCell(cells).addPheromone();
        println(ant.getCell(cells).x, ant.getCell(cells).y);
        int[] destPos = {constrain(ant.getCell(cells).x/CELL_SIZE+(int)random(-1, 2), 0, GRID_WIDTH), constrain(ant.getCell(cells).y/CELL_SIZE+(int)random(-1, 2), 0, GRID_HEIGHT)};
        println(destPos);
        Cell newDest = cells[destPos[0]][destPos[1]];
        ant.setDest(newDest);
      }
    }
  }

  void addRandomAnts(int amount) {
    for (int i = 0; i < amount; i++) {
      Cell randomCell = cells[(int)random(0, GRID_WIDTH)][(int)random(0, GRID_HEIGHT)];
      ants.add(new Ant(randomCell.x, randomCell.y, CELL_SIZE, CELL_SIZE));
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
