Ant ant;
ArrayList<Food> food;

void setup() {
  fullScreen();
  ant = new Ant(width/2, height/2, 30, 40);
  food = new ArrayList<Food>();
}

void draw() {
  background(255);
  for(Food food : food) {
    food.display();
  }
  ant.display();
  ant.applyForce(new PVector(0.05, 0.02));
}

void mousePressed() {
  food.add(new Food(mouseX, mouseY));
}
