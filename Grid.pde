//A class that manages the grid and all its cells

class Grid {
  Cell[][] cells;

  Grid() {
    //Create the grid cells based on the defined constants
    cells = new Cell[GRID_WIDTH][GRID_HEIGHT];
    for (int i = 0; i < GRID_WIDTH; i++) {
      for (int j = 0; j < GRID_HEIGHT; j++) {
        cells[i][j] = new Cell(i, j);
      }
    }
  }

  //Display each cell.
  void display() {
    for (Cell[] cellRow : cells) {
      for (Cell cell : cellRow) {
        cell.display();
      }
    }
  }
  
  //A method to randomly place nutrition across the grid based on perlin noise and a nutrition chance defined as a constant.
  void placeRandomNutrition() {
    for (int i = 0; i < GRID_HEIGHT; i++) {
      for (int j = 0; j < GRID_WIDTH; j++) {
        if (noise(i, j) < NUTRITION_CHANCE) {
          int amount = constrain((int)random(0, 6), 0, 5);
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

  //Get the cells an ant can see based on its current position and its heading.
  ArrayList<Cell> getSight(int[] pos, int[] heading) {
    ArrayList<Cell> sightCells = new ArrayList<Cell>();

    int[] usedHeading = new int[2];
    arrayCopy(heading, usedHeading);
    
    //A while loop to asure no empty arraylist is returned.
    while (sightCells.size() < 1) {
      //Check if the heading is straight or diagonal.
      if (usedHeading[0]*usedHeading[1]!=0) {
        //Loop through the visible cells using two nested for loops.
        for (int i = (usedHeading[0]<1 ? -1 : 0); i < (usedHeading[0]>-1 ? 2 : 1); i++) {
          for (int j = (usedHeading[1]<1 ? -1 : 0); j < (usedHeading[1]>-1 ? 2 : 1); j++) {
            //Check if the cell is not the current position or outside of the grid.
            if (!(i==0&&j==0) && pos[0]+i >= 0 && pos[0]+i < GRID_WIDTH && pos[1]+j >= 0 && pos[1]+j < GRID_HEIGHT) {
              Cell cell = cells[(int)pos[0]+i][(int)pos[1]+j];
              //Add the cell to the visible cells if it doesn't contain an obstacle.
              if (!cell.hasObstacle()) {
                sightCells.add(cell);
                if (DEBUG) cell.highlight();
              }
            }
          }
        }
      } else {
        //Loop through the visible cells using two nested for loops.
        for (int i = (usedHeading[0]<1 ? -1 : 1); i < (usedHeading[0]>-1 ? 2 : 0); i++) {
          for (int j = (usedHeading[1]<1 ? -1 : 1); j < (usedHeading[1]>-1 ? 2 : 0); j++) {
            //Check if the cell is not the current position or outside of the grid.
            if (!(i==0&&j==0) && pos[0]+i >= 0 && pos[0]+i < GRID_WIDTH && pos[1]+j >= 0 && pos[1]+j < GRID_HEIGHT) {
              Cell cell = cells[(int)pos[0]+i][(int)pos[1]+j];
              //Add the cell to the visible cells if it doesn't contain an obstacle.
              if (!cell.hasObstacle()) {
                sightCells.add(cell);
                if (DEBUG) cell.highlight();
              }
            }
          }
        }
      }
      
      //Create a random new heading that is used if no visible cells were found.
      usedHeading[0] = round(random(-1, 1));
      usedHeading[1] = round(random(-1, 1));
    }
    return sightCells;
  }

  //Display all the grid lines.
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

  //Handle the mouse click event.
  void mouseClick(int clickX, int clickY, int button) {
    //Get the cell that was clicked on.
    int[] cellIndex = {(int)clickX/CELL_SIZE, (int)clickY/CELL_SIZE};
    Cell cell = cells[cellIndex[0]][cellIndex[1]];
    //Check which mousebutton was pressed.
    if (button == LEFT) {
      //If left mouse button, toggle if the cell contains an obstacle.
      cell.toggleObstacle();
    } else if (button == RIGHT) {
      //If left mouse button, add a nutriment to the cell.
      cell.placeNutriment(1);
    }
  }
}
