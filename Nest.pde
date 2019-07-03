// Nest object is able to spawn ants at its location and keeps track of all nutrition collected.

class Nest {
  PVector pos;
  int nutriments = 0;
  int minNutriments = 2;
  
  Nest(PVector pos) {
    this.pos = pos;
  }
  
  void display() {
    fill(0);
    pushMatrix();
    translate(pos.x+CELL_SIZE/2,pos.y+CELL_SIZE/2);
    ellipse(0,0, CELL_SIZE, CELL_SIZE);
    popMatrix();
  }
  
  PVector getPos() {
    return pos;
  }
  
  void addNutriment() {
    nutriments++;
  }
  
  // returns the amount of ants that should be spawned
  int getSpawnAmount() {
    int spawnAmount = 0;
    while (nutriments >= minNutriments) {
      nutriments -= minNutriments;
      spawnAmount++;
    }
    return spawnAmount;
  }
  
}
