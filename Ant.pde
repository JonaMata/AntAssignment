class Ant {
  Animation animation;
  PVector pos, vel, acc;
  Cell dest;
  int[] heading;

  float maxSpeed = 1;

  Ant(float x, float y, int w, int h) {
    pos = new PVector(x, y);
    dest = null;
    vel = new PVector(0, 0);
    acc = new PVector(0, 0);
    animation = new Animation("Ant", 60, w, h);
    //pheromones = new ArrayList<Pheromone>();
    heading = new int[] {1, 0};
  }

  void display() {
    animation.display(pos.x, pos.y, vel.heading());
    animation.play();
    update();
  }

  void setDest(Cell cell) {
    int[] cellPos = getCellPos();
    int[] destPos = cell.getGridPos();
    heading = new int[] {cellPos[0]-destPos[0], cellPos[1]-destPos[1]};
    this.dest = cell;
  }

  int[] getCellPos() {
    return new int[]{(int)pos.x/CELL_SIZE, (int)pos.y/CELL_SIZE};
  }

  int[] getHeading() {
    return heading;
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
  }



  boolean canSearch() {
    if(dest == null) return true;
    else return dist(pos.x, pos.y, dest.getPos().x, dest.getPos().y)<4;
  }
}
