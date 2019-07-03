class Render {
  ArrayList<PImage> frames;
  int frameNumber;

  Render(int i, int w, int h) {
    frames = new ArrayList<PImage>();
    frames = imageLoader.getAnimation(i);
    for (PImage frame : frames) {
      frame.resize(w, h);
    }
  }

  void display(float x, float y, float r) {
    pushMatrix();
    translate(x+CELL_SIZE/2, y+CELL_SIZE/2);
    rotate(r+HALF_PI);
    image(frames.get(frameNumber), 0, 0);
    popMatrix();
  }

  void play() {
    frameNumber = (frameNumber + 1) % frames.size();
  } 
  
  void displayFrame(int i, PVector pos, float r) {
    pushMatrix();
    translate(pos.x+CELL_SIZE/2, pos.y+CELL_SIZE/2);
    rotate(r+HALF_PI);
    image(frames.get(constrain(i, 0, frames.size())), 0, 0);
    popMatrix();
  }
}
