class Nutriment {
  PVector pos;
  int size;
  

  Nutriment(float x, float y, int size) {
    this.pos = new PVector(x, y);
    this.size = size;
  }

  void display() {
    colorMode(RGB);
    fill(255, 0, 0, 150);
    ellipse(pos.x+CELL_SIZE/2, pos.y+CELL_SIZE/2, size*CELL_SIZE/2, size*CELL_SIZE/2);
  }
  
  void move(float x, float y) {
    pos = new PVector(x, y);
  }
  
  void addNutriment(int amount) {
    size += amount;
  }
  
  void removeNutriment() {
    size--;
  }
  
  boolean isThere() {
    return size > 0;
  }
  
  float getSize() {
    return size;
  }
}
