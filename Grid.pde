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
    for(Ant ant : ants) {
      ant.display();
      if(ant.canSearch()) {
        int[] cellPos = ant.getCellPos();
        int[] heading = ant.getHeading();
        ArrayList<Cell> emptyCells = new ArrayList<Cell>();
        ArrayList<Cell> pheromoneCells = new ArrayList<Cell>();
        ArrayList<Cell> foodCells = new ArrayList<Cell>();
        for(int i = (heading[0]<1 ? -1 : 0); i < (heading[0]>-1 ? 2 : 1); i++) {
          for(int j = (heading[1]<1 ? -1 : 0); j < (heading[1]>-1 ? 2 : 1); j++) {
            if(!(i==0&&j==0) && cellPos[0]+i >= 0 && cellPos[0]+i < GRID_WIDTH && cellPos[1]+j >= 0 && cellPos[1]+j < GRID_HEIGHT) {
              println(i,j);
              Cell cell = cells[cellPos[0]+i][cellPos[1]+j];
              if(cell.hasFood()) {
                foodCells.add(cell);
              } else if(cell.hasPheromone()) {
                pheromoneCells.add(cell);
              } else {
                emptyCells.add(cell);
              }
            }
          }
        }
        println(foodCells,pheromoneCells,emptyCells);
        
        if(foodCells.size() > 0) {
          ant.setDest(foodCells.get(0));
        } else if(pheromoneCells.size() > 0 && (random(0,100)<EXPLORE_CHANCE || emptyCells.size() == 0)) {
          Cell chosenCell = null;
          for(Cell cell : pheromoneCells) {
            if(chosenCell == null || cell.getPheromoneScore() > chosenCell.getPheromoneScore()) {
              chosenCell = cell;
            }
            if(random(0,100)<RANDOM_PHEROMONE_CHANCE) {
              chosenCell = cell;
              break;
            }
          }
          if(chosenCell != null) ant.setDest(chosenCell);
        } else {
          ant.setDest(emptyCells.get(floor(random(0,emptyCells.size()+1))));
        }
      }
    }
    //for (int i = 0; i < GRID_HEIGHT; i++) {
    //  for (int j = 0; j < GRID_WIDTH; j++) {
    //    cells[i][j].displayContent();
    //  }
    //}
  }

  void addRandomAnts() {
    Cell randomCell = cells[(int)random(0, GRID_WIDTH)][(int)random(0, GRID_HEIGHT)];
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
