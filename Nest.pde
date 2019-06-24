class Nest {
  PVector pos;
  
  Nest(float x, float y) {
    pos = new PVector(x, y);
  }

  void display() {
    fill(0);
    ellipse(pos.x, pos.y, CELL_SIZE, CELL_SIZE);
  }
  
  Ant spawnAnt() {
    return new Ant(pos.x, pos.y, CELL_SIZE, cell);
  }
}
