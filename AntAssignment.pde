Ant ant;

void setup() {
  fullScreen();
  ant = new Ant(width/2, height/2, 30, 40);
}

void draw() {
  background(255); 
  ant.display();
  ant.applyForce(new PVector(0.05, 0.02));
  
  
}
