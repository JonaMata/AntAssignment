/*
 Ant algorithm based on realistic ant movement.
 By Jesse Visser & Jonathan Matarazzi
*/

WorldManager worldManager;
ImageLoader imageLoader;
GrassBackground grassBackground;

void setup() {
  surface.setSize(GRID_WIDTH*CELL_SIZE, GRID_HEIGHT*CELL_SIZE);
  imageLoader = new ImageLoader();
  worldManager = new WorldManager();
  grassBackground = new GrassBackground(40, 20, 0.03, 0.1);
}

void draw() {
  background(255);
  grassBackground.update();
  grassBackground.display();
  worldManager.run();
}

void mousePressed() {
  worldManager.mouseClick(mouseX, mouseY);
}
