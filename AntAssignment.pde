/*
 Ant algorithm based on realistic ant movement.
 By Jesse Visser & Jonathan Matarazzi
*/

Grid grid;

void setup() {
  surface.setSize(GRID_WIDTH*CELL_SIZE, GRID_HEIGHT*CELL_SIZE);
  grid = new Grid();
  grid.addAnts(ANTS);
  grid.addNutrition();
}

void draw() {
  background(255);
  grid.displayGrid();
  grid.display();
  grid.update();
}
