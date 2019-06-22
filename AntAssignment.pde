Grid grid;

void setup() {
  surface.setSize(GRID_WIDTH*CELL_SIZE, GRID_HEIGHT*CELL_SIZE);
  grid = new Grid();
  grid.addRandomAnts(1);
}

void draw() {
  background(255);
  grid.displayGrid();
  grid.display();
}

void mousePressed() {
}
