class Nest {
  int x, y;
  Cell cell;
  
  Nest(Cell cell) {
    this.cell = cell;
    this.x = cell.x*CELL_SIZE+CELL_SIZE/2;
    this.y = cell.y*CELL_SIZE+CELL_SIZE/2;
  }

  void display() {
    fill(0);
    ellipse(x, y, CELL_SIZE, CELL_SIZE);
  }
  
  Ant spawnAnt() {
    return new Ant(x, y, CELL_SIZE, cell);
  }
}
