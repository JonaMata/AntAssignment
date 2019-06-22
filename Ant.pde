class Ant {
  Animation animation;
  //ArrayList<Pheromone> pheromones;
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

  //void applyForce(PVector force) {
  //  acc.add(force);
  //}

  void setDest(PVector dest) {
    this.dest = dest.mult(GRID_SIZE);
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
    //println(dist(pos.x, pos.y, dest.x, dest.y));
    return dist(pos.x, pos.y, dest.x, dest.y)<4;
  }

  PVector gridPos() {
    return new PVector(floor(pos.x/GRID_SIZE), floor(pos.y/GRID_SIZE));
  }
  
  Pheromone addPheromone() {
    return new Pheromone(gridPos().x, gridPos().y, GRID_SIZE, 1000);
  }
}
