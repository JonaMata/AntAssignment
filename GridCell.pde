/* A class for single grid cell.
 * It can contain multiple objects and has methods to modify those and check their availability.
 * A cell can contain nutriments, pheromones and possibly an obstacle.
*/

class Cell {
  int x, y;
  PVector pos;
  boolean obstacle = false;

  Pheromone pheromone;
  Nutriment nutriment;

  Cell (int x, int y) {
    this.x = x;
    this.y = y;
    this.pos = new PVector(x*CELL_SIZE, y*CELL_SIZE);
    this.pheromone = null;
    this.nutriment = null;
  }

  PVector getPos() {
    return pos;
  }

  int[] getCellIndex() {
    return new int[] {x, y};
  }

  boolean hasNutriment() {
    if (nutriment != null) return nutriment.isThere();
    else return false;
  }

  boolean hasPheromone() {
    if (pheromone != null) return pheromone.isThere();
    else return false;
  }

  float getPheromoneValue() {
    if(pheromone != null) return pheromone.getValue();
    else return 0;
  }

  void placePheromone() {
    if (pheromone != null) pheromone.addPheromone();
    else pheromone = new Pheromone(pos, 1);
  }

  void placeNutriment(int amount) {
    if (nutriment != null) nutriment.addNutriment(amount);
    else nutriment = new Nutriment(pos, amount);
  }

  void takeNutriment() {
    if (nutriment != null) {
      nutriment.removeNutriment();
      if (!nutriment.isThere()) nutriment = null;
    }
  }

  void highlight() {
    colorMode(RGB);
    fill(0, 255, 0, 50);
    rect(pos.x, pos.y, CELL_SIZE, CELL_SIZE);
  }

  void display() {
    if (pheromone != null) pheromone.run();
    if (nutriment != null) nutriment.display();
    if (obstacle) {
      colorMode(RGB);
      fill(255, 0, 0);
      rect(pos.x, pos.y, CELL_SIZE, CELL_SIZE);
    }
  }

  void toggleObstacle() {
    obstacle = !obstacle;
  }

  boolean hasObstacle() {
    return obstacle;
  }
}
