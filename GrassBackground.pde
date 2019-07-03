/* A class for a grass field background that is being influenced by the wind.
 * All the grasses in a column are drawn from the same piece of grass to improve performance.
*/

class GrassBackground {
  int rows, columns;
  float grassHeight, grassWidth, windPower, windPosModifier, windPos = 0;
  Grass[] grasses;

  GrassBackground(int columns, int rows, float windPower, float windPosModifier) {
    this.columns = columns;
    this.rows = rows;
    this.windPower = windPower;
    this.windPosModifier = windPosModifier;
    grasses = new Grass[columns];
    
    //Calculate the size of the grasses
    grassHeight = GRID_HEIGHT*CELL_SIZE/rows;
    grassWidth = GRID_WIDTH*CELL_SIZE/columns;

    //Create the grasses
    for (int i = 0; i<grasses.length; i++) {
      grasses[i] = new Grass(2, grassHeight, grassWidth);
    }
  }

  void update() {
    //Apply wind the grasses.
    for (int i = 0; i<grasses.length; i++) {
      float windGrassDist = abs(i-windPos);
      if (windGrassDist < 1) {
        grasses[i].addForce((1-windGrassDist)*windPower);
      }
      
      //Update all the grasses.
      grasses[i].update();
    }
    
    //Move the current position of the wind.
    windPos+=windPosModifier;
    windPos%=columns;
  }

  //Display all the grasses at the correct locations.
  void display() {
    pushMatrix();
    translate(grassWidth/2, grassHeight);
    for (int i = 0; i<grasses.length; i++) {
      for (int j = 0; j<rows; j++) {
        grasses[i].display(new PVector(i*grassWidth, j*grassHeight));
      }
    }
    popMatrix();
  }
  
  
  //Run the update and dispaly methods.
  void run() {
    update();
    display();
  }
}
