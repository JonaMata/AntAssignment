Grid grid;

void setup() {
  //surface.setResizable(true);
  surface.setSize(GRID_WIDTH*CELL_SIZE, GRID_HEIGHT*CELL_SIZE);
  grid = new Grid();
  grid.addRandomAnts();
  //grid.addRandomAnts(1);
}

void draw() {
  background(255);
  grid.displayGrid();
  grid.display();
}

void mousePressed() {
}
