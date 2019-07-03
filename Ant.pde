class Ant {
  Cell dest;
  Render animation;
  Nutriment nutriment;
  int[] heading;
  PVector pos, vel, acc, nestPos;
  boolean hasNutriment;
  float maxSpeed;

  Ant(PVector pos, int size, PVector nestPos) {
    this.pos = pos.copy();
    this.vel = new PVector(0, 0);
    this.nestPos = nestPos;
    this.acc = new PVector(0, 0);
    this.maxSpeed = 1;
    this.animation = new Render(0, 60, size, size+size/4, 0);
    this.heading = new int[] {1, 0};
    this.nutriment = new Nutriment(pos.x, pos.y, 1);
  }

  void display() {
    animation.display(pos.x, pos.y, vel.heading());
    animation.play();

    if (hasNutriment) {
      nutriment.move(pos);
      nutriment.display();
    }
  }

  void update() {

    if (dist(pos.x, pos.y, nestPos.x, nestPos.y)<CELL_SIZE) {
      atNest();
    }


    if (dest != null) {
      PVector destPos = dest.getPos();
      if (dest.hasNutriment() &&  dist(pos.x, pos.y, destPos.x, destPos.y)<CELL_SIZE) {
        grabNutriment(dest);
      }

      PVector force = dest.getPos().copy().sub(pos).setMag(0.2);
      acc.add(force);
      vel.add(acc);
      vel.limit(maxSpeed);
      pos.add(vel);
      acc.mult(0);
      if (canSearch()) pos = dest.getPos().copy();
    }
  }

  void run() {
    display();
    update();
  }

  void move(ArrayList<Cell> cells) {
    if (canSearch()) {
      if (hasNutriment) {

        println(dist(pos.x, pos.y, nestPos.x, nestPos.y));

        Cell closestToNest = null;
        float closestDist = Float.POSITIVE_INFINITY;
        for (Cell cell : cells) {
          PVector cellPos = cell.getPos();
          float nestDistance = dist(nestPos.x, nestPos.y, cellPos.x, cellPos.y);
          if (nestDistance < closestDist) {
            closestDist = nestDistance;
            closestToNest = cell;
          }
        }
        setDest(closestToNest);
      } else {
        ArrayList<Cell> emptyCells = new ArrayList<Cell>();
        ArrayList<Cell> pheromoneCells = new ArrayList<Cell>();
        ArrayList<Cell> foodCells = new ArrayList<Cell>();

        for (Cell cell : cells) {
          if (DEBUG) cell.highlight();
          if (cell.hasNutriment()) {
            foodCells.add(cell);
          } else if (cell.hasPheromone()) {
            pheromoneCells.add(cell);
          } else {
            emptyCells.add(cell);
          }
        }

        if (foodCells.size() > 0) {
          setDest(foodCells.get((int) random(foodCells.size())));
        } else if (pheromoneCells.size() > 0 && (random(0, 100)>EXPLORE_CHANCE || emptyCells.size() == 0 || hasNutriment)) {
          Cell chosenCell = null;
          for (Cell cell : pheromoneCells) {
            if (chosenCell == null || cell.getPheromoneValue() > chosenCell.getPheromoneValue()) {
              chosenCell = cell;
            }
            if (random(0, 100) < RANDOM_PHEROMONE_CHANCE) {
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
  }

  void setDest(Cell cell) {
    if (dest != null && hasNutriment) dest.placePheromone();
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

  boolean canSearch() {
    if (dest == null) return true;
    else return dist(pos.x, pos.y, dest.getPos().x, dest.getPos().y)<4;
  }
}
