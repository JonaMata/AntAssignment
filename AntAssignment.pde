/*
 * Ant algorithm based on realistic ant movement using pheromones.
 * Insipred by Biologic Transport Network Algorithms,
 * authored by Loes Uffelen, Dennis Vinke and Joep Schyns.
 * 
 * Program written by Jesse Visser & Jonathan Matarazzi.
*/

WorldManager worldManager;
ImageLoader imageLoader;
GrassBackground grassBackground;

void setup() {
  //Set the window size depending on the defined constants about the grid
  surface.setSize(GRID_WIDTH*CELL_SIZE, GRID_HEIGHT*CELL_SIZE);
  imageLoader = new ImageLoader();
  worldManager = new WorldManager();
  grassBackground = new GrassBackground(40, 20, 0.03, 0.1);
}

void draw() {
  background(255);
  //Run and display the grass background if it is enabled
  if(BACKGROUND) grassBackground.run();
  worldManager.run();
}

//Handle a mouse press by calling the mouseClick eventHandler of WorldManager
void mousePressed() {
  worldManager.mouseClick(mouseX, mouseY, mouseButton);
}
