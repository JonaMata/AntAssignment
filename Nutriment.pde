class Nutriment {
  PVector pos;
  float size;
  

  Nutriment(float x, float y, int size) {
    this.pos = new PVector(x, y);
    this.size = size;
  }

  void display() {
    colorMode(RGB);
    fill(255, 0, 0);
    ellipse(pos.x+CELL_SIZE/2, pos.y+CELL_SIZE/2, size/2, size/2);
  }
}
