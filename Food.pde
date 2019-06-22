class Food {
  PVector pos;
  Render animation;

  Food(float x, float y) {
    pos = new PVector(x, y);
    animation = new Render("Food", 10, 50, 50);
  }

  void display() {
    animation.display(pos.x, pos.y, 0);
    animation.playFor(3);
  }
}
