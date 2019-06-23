class Nutriment {
  PVector pos;
  float size;
  

  Nutriment(float x, float y, int size) {
    this.pos = new PVector(x, y);
    this.size = size;
  }

  void display() {
    fill(255);
    ellipse(pos.x, pos.y, size, size);
  }
}
