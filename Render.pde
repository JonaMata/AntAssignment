class Render {
  ArrayList<PImage> frames;
  int frameNumber, count;
  boolean isPaused;

  Render(int i, int count, int w, int h, int startFrame) {
    frames = new ArrayList<PImage>();
    imageMode(CENTER);
    this.count = count;
    this.frameNumber = startFrame;
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
    if (!isPaused) frameNumber = (frameNumber + 1) % count;
  } 

  void playFor(int duration) {
    if (!isPaused && frameNumber < duration) frameNumber = (frameNumber + 1) % count;
  }

  void togglePause(boolean pauseState) {
    isPaused = pauseState;
  }
}
