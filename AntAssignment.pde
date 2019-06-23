Grid grid;

void setup() {
  surface.setSize(GRID_WIDTH*CELL_SIZE, GRID_HEIGHT*CELL_SIZE);
  grid = new Grid();
  grid.addAnts(1);
  grid.addNutrition();
}

void draw() {
  background(255);
  grid.displayGrid();
  grid.display();
}

void mousePressed() {
}
