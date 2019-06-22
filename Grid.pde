class Grid {
  GridItem[] gridItems;
  ArrayList<Ant> ants;

  Grid() {
    gridItems = new GridItem[GRID_WIDTH*GRID_HEIGHT];
    for (int i = 0; i<gridItems.length; i++) {
      gridItems[i] = new GridItem(i%GRID_WIDTH, i/GRID_WIDTH);
    }
    ants = new ArrayList<Ant>();
  }

  void display() {
    for (GridItem gridItem : gridItems) {
      gridItem.display();
    }
    for (Ant ant : ants) {
      if (ant.canSearch()) {
        //println("yes");
        println(ants.indexOf(ant));
        antGridItem(ant).addPheromone();
        ant.setDest(new PVector(ant.gridPos().x+(int)random(0, 2), ant.gridPos().y+(int)random(0, 2)));
      }
      ant.display();
    }
  }

  void addRandomAnts(int amount) {
    for (int i = 0; i < amount; i++) {
      int randomLoc = (int) random(0, gridItems.length);
      ants.add(new Ant(randomLoc%GRID_WIDTH*GRID_SIZE, randomLoc/GRID_HEIGHT*GRID_SIZE, GRID_SIZE, GRID_SIZE));
    }
  }
  
  GridItem antGridItem(Ant ant) {
    return gridItems[(int) (ant.gridPos().x + ant.gridPos().y*GRID_WIDTH)];
  }

  void displayGrid() {
    stroke(0);
    strokeWeight(1);
    for (int x = 1; x < GRID_WIDTH; x++) {
      line(x*GRID_SIZE, 0, x*GRID_SIZE, height);
    }
    for (int y = 1; y < GRID_WIDTH; y++) {
      line(0, y*GRID_SIZE, width, y*GRID_SIZE);
    }
  }
}
