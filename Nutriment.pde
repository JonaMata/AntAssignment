class Nutriment {
  PVector pos;
  int value;
  Render render;

  Nutriment(PVector pos, int value) {
    render = new Render(1, 2*CELL_SIZE/3, 2*CELL_SIZE/3);
    this.pos = pos.copy();
    this.value = value;
  }

  void display() {
    if (value > 0) render.displayFrame(value-1, pos, 0);
  }
  
  void move(PVector pos) {
    this.pos = pos.copy();
  }
  
  void addNutriment(int amount) {
    value += constrain(amount, 0, 5-value);
  }
  
  void removeNutriment() {
    value--;
  }
  
  boolean isThere() {
    return value > 0;
  }
  
  float getSize() {
    return value;
  }
}
