class Ant {
  Animation animation;
  ArrayList<Pheromone> pheromones;
  PVector pos, vel, acc;

  float startTime = millis();
  float maxSpeed = 1;

  Ant(float x, float y, int w, int h) {
    pos = new PVector(x, y);
    vel = new PVector(0, 0);
    acc = new PVector(0, 0);
    animation = new Animation("Ant", 60, w, h);
    pheromones = new ArrayList<Pheromone>();
  }

  void display() {
    for (Pheromone pheromone : pheromones) {
      pheromone.display();
    }
    animation.display(pos.x, pos.y, vel.heading());
    update();
    spawnPheromones();
  }

  void applyForce(PVector force) {
    acc.add(force);
  }

  void update() {
    vel.add(acc);
    vel.limit(maxSpeed);
    pos.add(vel);
    acc.mult(0);

    PVector mouse = new PVector(mouseX, mouseY);
    acc = PVector.sub(mouse, pos);
    acc.setMag(0.2);
  }

  void spawnPheromones() {
    float deltaTime = millis() - startTime;
    if (deltaTime > 1000) {
      pheromones.add(new Pheromone(pos.x, pos.y, 15, 10000));
      startTime = millis();
    }
  }
}
