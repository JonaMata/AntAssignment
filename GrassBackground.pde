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

    grassHeight = GRID_HEIGHT*CELL_SIZE/rows;
    grassWidth = GRID_WIDTH*CELL_SIZE/columns;

    for (int i = 0; i<grasses.length; i++) {
      grasses[i] = new Grass(2, grassHeight, grassWidth);
    }
  }

  void update() {
    for (int i = 0; i<grasses.length; i++) {
      float windGrassDist = abs(i-windPos);
      if (windGrassDist < 1) {
        grasses[i].addForce((1-windGrassDist)*windPower);
      }
      grasses[i].update();
    }
    windPos+=windPosModifier;
    windPos%=columns;
  }

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
}
