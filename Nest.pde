class Nest {
  PVector pos;
  
  Nest(PVector pos) {
    this.pos = new PVector(pos.x+CELL_SIZE/2, pos.y+CELL_SIZE/2);
  }

  void display() {
    fill(0);
    ellipse(pos.x, pos.y, CELL_SIZE, CELL_SIZE);
  }
  
  Ant spawnAnt() {
    return new Ant(pos.copy(), CELL_SIZE, pos);
  }
  
  PVector getPos() {
    return pos;
  }
}
