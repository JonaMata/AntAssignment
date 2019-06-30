class ImageLoader {
  String[] directories;

  ImageLoader() {
    directories = listFileNames(sketchPath() + "/data");
    for (String dir : directories) {
      ArrayList<Animation> animations = new ArrayList<Animation>(directories.length);
      String[] files = listFileNames(sketchPath() + "/data/" + dir);
      ArrayList<String> images = new ArrayList<String>(files.length);
      for (String file : files) {
        images.add(file);
        animations.add(new Animation(dir, images));
      }
    }

    if (DEBUG) {
      directories = listFileNames(sketchPath() + "/data");
      for (String dir : directories) {
        println(dir);
        String[] files = listFileNames(sketchPath() + "/data/" + dir);
        for (String file : files) {
          println("  " + file);
        }
      }
    }
  }

  String[] listFileNames(String dir) {
    File file = new File(dir); 
    if (file.isDirectory()) {
      String names[] = file.list(); 
      return names;
    } else {
      // If it's not a directory
      String error[] = {"not a directory"}; 
      return error;
    }
  }
}

class Animation extends ImageLoader {
  ArrayList<PImage> images;

  Animation(String dir, ArrayList<String> images) {
    for (String file : images) {
      this.images.add(loadImage(sketchPath() + "/data/" + dir + "/" + file));
    }
  }
}
