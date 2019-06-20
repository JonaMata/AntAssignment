class Animation {
  ArrayList<PImage> frames;
  int frameNumber, count;
  boolean isPaused;

  Animation(String imageFolder, int count, int w, int h) {
    frames = new ArrayList<PImage>();
    imageMode(CENTER);
    this.count = count;
    for (int i = 0; i < count; i++) {
      String filename = imageFolder + "/" + "frame_" + nf(i, 2) + ".png";
      frames.add(loadImage(filename));
      PImage frame = frames.get(i);
      frame.resize(w, h);
    }
  }

  void display(float x, float y, float r) {
    if (!isPaused) frameNumber = (frameNumber + 1) % count;
    pushMatrix();
    translate(x, y);
    rotate(r+HALF_PI);
    image(frames.get(frameNumber), 0, 0);
    popMatrix();
  } 

  void togglePause(boolean pauseState) {
    isPaused = pauseState;
  }
}
