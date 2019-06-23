class Ant {
  Render animation;
  PVector pos, vel, acc;
  Cell dest;
  Nutriment nutriment;
  int[] heading;
  boolean hasNutriment;

  float maxSpeed = 1;

  Ant(float x, float y, int size, Cell cell) {
    this.pos = new PVector(x, y);
    this.dest = cell;
    this.vel = new PVector(0, 0);
    this.acc = new PVector(0, 0);
    this.animation = new Render("Ant", 60, size, size+size/4, 0);
    this.heading = new int[] {1, 0};
    this.nutriment = new Nutriment(pos.x, pos.y, 1);
  }

  void display() {
    animation.display(pos.x, pos.y, vel.heading());
    animation.play();
    update();

    if (hasNutriment) {
      nutriment.display();
      nutriment.move(pos.x, pos.y);
    }
  }

  void setDest(Cell cell) {
    if (dest != null) dest.placePheromone();
    int[] cellPos = getCellPos();
    int[] destPos = cell.getGridPos();
    heading = new int[] {destPos[0]-cellPos[0], destPos[1]-cellPos[1]};
    this.dest = cell;
  }

  int[] getCellPos() {
    return new int[]{(int)pos.x/CELL_SIZE, (int)pos.y/CELL_SIZE};
  }

  int[] getSearchPos() {
    if (dest == null) return getCellPos();
    return dest.getGridPos();
  }

  int[] getHeading() {
    return heading;
  }

  void grabNutriment(Cell cell) {
    if (!hasNutriment) {
      hasNutriment = true;
      cell.takeNutriment();
      heading[0] *= -1;
      heading[1] *= -1;
    }
  }

  void atNest() {
    hasNutriment = false;
  }

  void update() {    
    if (dest != null) {
      PVector force = dest.getPos().copy().sub(pos).setMag(0.2);
      acc.add(force);
      vel.add(acc);
      vel.limit(maxSpeed);
      pos.add(vel);
      acc.mult(0);
    }
    if (canSearch()) pos = dest.getPos().copy();
  }

  boolean canSearch() {
    if (dest == null) return true;
    else return dist(pos.x, pos.y, dest.getPos().x, dest.getPos().y)<4;
  }
}
