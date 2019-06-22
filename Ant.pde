class Ant {
  Render animation;
  PVector pos, vel, acc, dest;

  float maxSpeed = 1;

  Ant(float x, float y, int size) {
    pos = new PVector(x, y);
    dest = pos.copy();
    vel = new PVector(0, 0);
    acc = new PVector(0, 0);
    animation = new Render("Ant", 60, size, size+size/4);
  }

  void display() {
    animation.display(pos.x, pos.y, vel.heading());
    animation.play();
    update();
  }

  void setDest(Cell cell) {
    this.dest = new PVector(cell.x, cell.y);
  }

  Cell getCell(Cell[][] cells) {
    return cells[(int)pos.x/CELL_SIZE][(int)pos.y/CELL_SIZE];
  }

  void update() {    
    PVector force = dest.copy().sub(pos).setMag(0.2);
    acc.add(force);
    vel.add(acc);
    vel.limit(maxSpeed);
    pos.add(vel);
    acc.mult(0);
  }

  boolean canSearch() {
    return dist(pos.x, pos.y, dest.x, dest.y)<4;
  }
}
