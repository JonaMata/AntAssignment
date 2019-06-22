Grid grid;

void setup() {
  //surface.setResizable(true);
  surface.setSize(GRID_WIDTH*GRID_SIZE, GRID_HEIGHT*GRID_SIZE);
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
