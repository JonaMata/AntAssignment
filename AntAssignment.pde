/*
 Ant algorithm based on realistic ant movement.
 By Jesse Visser & Jonathan Matarazzi
*/

WorldManager worldManager;
ImageLoader imageLoader;

void setup() {
  surface.setSize(GRID_WIDTH*CELL_SIZE, GRID_HEIGHT*CELL_SIZE);
  imageLoader = new ImageLoader();
  worldManager = new WorldManager();
}

void draw() {
  background(255);
  worldManager.run();
}

void mousePressed() {
  worldManager.mouseClick(mouseX, mouseY);
}
