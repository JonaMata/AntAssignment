class Ant {
  Animation animation;
  PVector pos, vel, acc, dest;
  
  float maxSpeed = 1;

  Ant(float x, float y, int w, int h) {
    pos = new PVector(x, y);
    dest = pos.copy();
    vel = new PVector(0, 0);
    acc = new PVector(0, 0);
    animation = new Animation("Ant", 60, w, h);
    //pheromones = new ArrayList<Pheromone>();
  }

  void display() {
    animation.display(pos.x, pos.y, vel.heading());
    animation.play();
    update();
  }

  void setDest(Cell cell) {
    this.dest = new PVector(cell.x, cell.y);
  }
  
  int[] getCellPos() {
    return new int[]{(int)pos.x/CELL_SIZE,(int)pos.y/CELL_SIZE}; 
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
