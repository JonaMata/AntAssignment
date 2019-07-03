//A class for the ants, it handles the movement and decision making of the ants.
 
class Ant {
  Cell dest;
  Render render;
  Nutriment nutriment;
  int[] heading;
  PVector pos, vel, acc, nestPos;
  boolean hasNutriment;
  float maxSpeed;

  Nest nest;

  Ant(PVector pos, int size, Nest nest) {
    this.pos = pos.copy();
    this.vel = new PVector(0, 0);
    this.nest = nest;
    this.nestPos = nest.getPos();
    this.acc = new PVector(0, 0);
    this.maxSpeed = 1;
    this.render = new Render(0, size/2, 2*size/3);
    this.heading = new int[] {1, 0};
    this.nutriment = new Nutriment(pos, 1);
  }

  //Display the ant on its current position using its heading to give it the correct rotation
  void display() {
    render.play(pos.x, pos.y, vel.heading());
    
    //Also display a nutriment on the ant if it is carrying one
    if (hasNutriment) {
      nutriment.display();
    }
  }

  //Update the position and handle the ant arriving at the nest or at a cell containing nutriments
  void update() {
    if (hasNutriment) {
      nutriment.move(pos);
      if (dist(pos.x, pos.y, nestPos.x, nestPos.y) < CELL_SIZE) {
        //Call the atNest() method if the ant arrived at the nest
        atNest();
      }
    }

    if (dest != null) {
      PVector destPos = dest.getPos();
      if (!hasNutriment && dest.hasNutriment() &&  dist(pos.x, pos.y, destPos.x, destPos.y) < CELL_SIZE) {
        //Grab a nutriment if not already carrying one once arrived at a cell containing nutriments
        grabNutriment(dest);
      }
      
      //Move the ant towards its destination
      PVector force = dest.getPos().copy().sub(pos).setMag(0.1);
      acc.add(force);
      vel.add(acc);
      vel.limit(maxSpeed);
      pos.add(vel);
      acc.mult(0);
      
      //Fixate the ant on its destination if it's really close
      if (canSearch()) pos = dest.getPos().copy();
    }
  }

  //Run the update and display methods of the ant
  void run() {
    display();
    update();
  }

  //A method the sets a new destination for the ant based on the cells it can see and some checks
  void move(ArrayList<Cell> cells) {
    //Check if the ant is at it's destination and a new destination can be set
    if (canSearch()) {
      
      //Check if the ant is carrying a nutriment, if it is it should walk back to the nest
      if (hasNutriment) {
        //Find the cell closest to the nest and set it as a new destination
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
        //If the ant is not carrying a nutriment, divide the cells in categories.
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

        //Decide which cell to set as the new destination. Prioritize nutriments over everything, after that follow the pheromones (with a chance to explorer), after that choose a random cell.
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


  //Set the new destination
  void setDest(Cell cell) {
    //If the ant is holding nutriment, place pheromones on the previous cell.
    if (dest != null && hasNutriment) dest.placePheromone();
    int[] cellPos = getCellIndex();
    int[] destPos = cell.getCellIndex();
    heading = new int[] {destPos[0]-cellPos[0], destPos[1]-cellPos[1]};
    this.dest = cell;
  }

  //Get the cellIndex of the current location of the ant.
  int[] getCellIndex() {
    return new int[]{(int)pos.x/CELL_SIZE, (int)pos.y/CELL_SIZE};
  }

  //Get the location of the and from where it can search for a new destination.
  int[] getSearchPos() {
    if (dest == null) return getCellIndex();
    return dest.getCellIndex();
  }

  //Get the current heading of the ant.
  int[] getHeading() {
    return heading;
  }

  //Grab one nutriment from a cell if the ant is not already carrying a nutriment and flip the heading.
  void grabNutriment(Cell cell) {
    if (!hasNutriment) {
      hasNutriment = true;
      cell.takeNutriment();
      heading[0] *= -1;
      heading[1] *= -1;
    }
  }
  
  //Drop the nutriment in the nest
  void atNest() {
    hasNutriment = false;
    nest.addNutriment();
  }
  
  //Check if the ant is close enough to its current destination so it can search for a new destination.
  boolean canSearch() {
    if (dest == null) return true;
    else return dist(pos.x, pos.y, dest.getPos().x, dest.getPos().y)<4;
  }
}
