class Nest {
  PVector pos;
  Cell cell;
  
  Nest(Cell cell) {
    this.cell = cell;
    this.pos = new PVector(cell.x*CELL_SIZE+CELL_SIZE/2, cell.y*CELL_SIZE+CELL_SIZE/2);
  }

  void display() {
    fill(0);
    ellipse(pos.x, pos.y, CELL_SIZE, CELL_SIZE);
  }
  
  Ant spawnAnt() {
    return new Ant(pos.x, pos.y, CELL_SIZE, cell);
  }
}
