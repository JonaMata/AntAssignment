class Ant {
  Cell dest;
  Render animation;
  Nutriment nutriment;
  int[] heading;
  PVector pos, vel, acc;
  boolean hasNutriment;
  float maxSpeed;

  Ant(float x, float y, int size, Cell cell) {
    this.pos = new PVector(x, y);
    this.dest = cell;
    this.vel = new PVector(0, 0);
    this.acc = new PVector(0, 0);
    this.maxSpeed = 1;
    this.animation = new Render("Ant", 60, size, size+size/4, 0);
    this.heading = new int[] {1, 0};
    this.nutriment = new Nutriment(pos.x, pos.y, 1);
  }

  void display() {
    animation.display(pos.x, pos.y, vel.heading());
    animation.play();

    if (hasNutriment) {
      nutriment.display();
      nutriment.move(pos.x, pos.y);
    }
  }

  void move(Cell[][] cells) {
    if (canSearch()) {
      int[] cellPos = getSearchPos();
      ArrayList<Cell> emptyCells = new ArrayList<Cell>();
      ArrayList<Cell> pheromoneCells = new ArrayList<Cell>();
      ArrayList<Cell> foodCells = new ArrayList<Cell>();

      for (int i = (heading[0]<1 ? -1 : 0); i < (heading[0]>-1 ? 2 : 1); i++) {
        for (int j = (heading[1]<1 ? -1 : 0); j < (heading[1]>-1 ? 2 : 1); j++) {
          if (!(i==0&&j==0) && cellPos[0]+i >= 0 && cellPos[0]+i < GRID_WIDTH && cellPos[1]+j >= 0 && cellPos[1]+j < GRID_HEIGHT) {
            Cell cell = cells[cellPos[0]+i][cellPos[1]+j];
            cell.highlight();
            if (cell.hasNutriment()) {
              foodCells.add(cell);
            } else if (cell.hasPheromone()) {
              pheromoneCells.add(cell);
            } else {
              emptyCells.add(cell);
            }
          }
        }
      }

      if (foodCells.size() > 0) {
        setDest(foodCells.get(0));
        grabNutriment(foodCells.get(0));
      } else if (pheromoneCells.size() > 0 && (random(0, 100)>EXPLORE_CHANCE || emptyCells.size() == 0 || hasNutriment)) {
        Cell chosenCell = null;
        for (Cell cell : pheromoneCells) {
          if (chosenCell == null || cell.getPheromoneValue() > chosenCell.getPheromoneValue()) {
            chosenCell = cell;
          }
          if (random(0, 100)<RANDOM_PHEROMONE_CHANCE) {
            chosenCell = cell;
            break;
          }
        }
        if (chosenCell != null) setDest(chosenCell);
      } else if (emptyCells.size() > 0) {
        setDest(emptyCells.get(floor(random(0, emptyCells.size()))));
      }
    }
  }

  void setDest(Cell cell) {
    if (dest != null) dest.placePheromone();
    int[] cellPos = getCellIndex();
    int[] destPos = cell.getCellIndex();
    heading = new int[] {destPos[0]-cellPos[0], destPos[1]-cellPos[1]};
    this.dest = cell;
  }

  int[] getCellIndex() {
    return new int[]{(int)pos.x/CELL_SIZE, (int)pos.y/CELL_SIZE};
  }

  int[] getSearchPos() {
    if (dest == null) return getCellIndex();
    return dest.getCellIndex();
  }

  int[] getHeading() {
    return heading;
  }

  void grabNutriment(Cell cell) {
    if (!hasNutriment) {
      hasNutriment = true;
      cell.takeNutriment();
      heading[0] *= -1;
      heading[1] *= -1;
    }
  }
  
  void atNest() {
    hasNutriment = false;
  }

  void update() {    
    PVector force = dest.getPos().copy().sub(pos).setMag(0.2);
    acc.add(force);
    vel.add(acc);
    vel.limit(maxSpeed);
    pos.add(vel);
    acc.mult(0);
    if (canSearch()) pos = dest.getPos().copy();
  }

  boolean canSearch() {
    if (dest == null) return true;
    else return dist(pos.x, pos.y, dest.getPos().x, dest.getPos().y)<4;
  }
}
