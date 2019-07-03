class ImageLoader {
  ArrayList<ArrayList<PImage>> animations = new ArrayList<ArrayList<PImage>>();

  ImageLoader() {
    imageMode(CENTER);
    String[] directories = listFileNames(sketchPath() + "/data");
    for (int i = 0; i < directories.length; i++) {
      String[] files = listFileNames(sketchPath() + "/data/" + directories[i]);
      ArrayList<PImage> images = new ArrayList<PImage>();
      for (String file : files) {
        images.add(loadImage(sketchPath() + "/data/" + directories[i] + "/" + file));
      }
      animations.add(images);
    }

    if (DEBUG) {
      directories = listFileNames(sketchPath() + "/data");
      for (int i = 0; i < directories.length; i++) {
        println(directories[i]);
        String[] files = listFileNames(sketchPath() + "/data/" + directories[i]);
        for (String file : files) {
          println("  " + file);
        }
      }
    }
  }
  
  ArrayList<PImage> getAnimation(int index) {
    return animations.get(index);
  }

  String[] listFileNames(String dir) {
    File file = new File(dir); 
    if (file.isDirectory()) {
      String files[] = file.list(); 
      return files;
    } else {
      String errors[] = {"not a directory"};
      return errors;
    }
  }
}
