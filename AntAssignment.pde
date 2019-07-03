/*
 Ant algorithm based on realistic ant movement using pheromones.
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
  if(BACKGROUND) grassBackground.run();
  worldManager.run();
}

void mousePressed() {
  worldManager.mouseClick(mouseX, mouseY, mouseButton);
}
