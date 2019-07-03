class Grid {
  Cell[][] cells;

  Grid() {
    cells = new Cell[GRID_WIDTH][GRID_HEIGHT];
    for (int i = 0; i < GRID_WIDTH; i++) {
      for (int j = 0; j < GRID_HEIGHT; j++) {
        cells[i][j] = new Cell(i, j);
      }
    }
  }

  void display() {
    for (Cell[] cellRow : cells) {
      for (Cell cell : cellRow) {
        cell.display();
      }
    }
  }

  void update() {
  }

  void placeRandomNutrition() {
    for (int i = 0; i < GRID_HEIGHT; i++) {
      for (int j = 0; j < GRID_WIDTH; j++) {
        if (noise(i, j) < NUTRITION_CHANCE) {
          int amount = (int)random(0, 2);
          cells[i][j].placeNutriment(amount);
        }
      }
    }
  }

  Cell getRandomCell() {
    return cells[(int)random(0, GRID_WIDTH)][(int)random(0, GRID_WIDTH)];
  }

  PVector getRandomPos() {
    return getRandomCell().getPos();
  }

  ArrayList<Cell> getSight(int[] pos, int[] heading) {
    ArrayList<Cell> sightCells = new ArrayList<Cell>();
    
    int[] usedHeading = new int[2];
    
    arrayCopy(heading, usedHeading);
    while (sightCells.size() < 1) {
      if (usedHeading[0]*usedHeading[1]!=0) {
        for (int i = (usedHeading[0]<1 ? -1 : 0); i < (usedHeading[0]>-1 ? 2 : 1); i++) {
          for (int j = (usedHeading[1]<1 ? -1 : 0); j < (usedHeading[1]>-1 ? 2 : 1); j++) {
            if (!(i==0&&j==0) && pos[0]+i >= 0 && pos[0]+i < GRID_WIDTH && pos[1]+j >= 0 && pos[1]+j < GRID_HEIGHT) {
              Cell cell = cells[(int)pos[0]+i][(int)pos[1]+j];
              sightCells.add(cell);
              if (DEBUG) cell.highlight();
            }
          }
        }
      } else {
        for (int i = (usedHeading[0]<1 ? -1 : 1); i < (usedHeading[0]>-1 ? 2 : 0); i++) {
          for (int j = (usedHeading[1]<1 ? -1 : 1); j < (usedHeading[1]>-1 ? 2 : 0); j++) {
            if (!(i==0&&j==0) && pos[0]+i >= 0 && pos[0]+i < GRID_WIDTH && pos[1]+j >= 0 && pos[1]+j < GRID_HEIGHT) {
              Cell cell = cells[(int)pos[0]+i][(int)pos[1]+j];
              sightCells.add(cell);
              if (DEBUG) cell.highlight();
            }
          }
        }
      }
      usedHeading[0] = round(random(-1,1));
      usedHeading[1] = round(random(-1,1));
    }
    return sightCells;
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
