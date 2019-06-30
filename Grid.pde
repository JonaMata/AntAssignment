class Grid {
  ArrayList<Ant> ants;
  Cell[][] cells;

  Grid() {
    cells = new Cell[GRID_WIDTH][GRID_HEIGHT];
    for (int i = 0; i < GRID_WIDTH; i++) {
      for (int j = 0; j < GRID_HEIGHT; j++) {
        cells[i][j] = new Cell(i, j);
      }
    }
    ants = new ArrayList<Ant>();
  }

  void display() {
    for (Cell[] cellRow : cells) {
      for (Cell cell : cellRow) {
        cell.display();
      }
    }
    for (Ant ant : ants) {
      ant.display();
    }
  }

  void update() {
    for (Ant ant : ants) {
      ant.move(cells);
      ant.update();
    }
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
