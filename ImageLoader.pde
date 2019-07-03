/* ImageLoader loads all the images at start up and saves each set of frames for the renderer to access.
 * Based on Listing files in directories and subdirectories by Daniel Shiffman. 
 * https://processing.org/examples/directorylist.html
 */

class ImageLoader {
  ArrayList<ArrayList<PImage>> animations = new ArrayList<ArrayList<PImage>>();
  
  // finds each directory and saves all its images as a set of frames
  ImageLoader() {
    imageMode(CENTER);
    
    String[] directories = listFileNames(sketchPath() + "/data"); // finds all directories
    for (int i = 0; i < directories.length; i++) {
      String[] files = listFileNames(sketchPath() + "/data/" + directories[i]); // finds all contained images
      ArrayList<PImage> images = new ArrayList<PImage>();
      for (String file : files) {
        images.add(loadImage(sketchPath() + "/data/" + directories[i] + "/" + file));
      }
      animations.add(images);
    }
    
    // debug function that prints the directory structure to the console
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
  
  // returns a set of frames
  ArrayList<PImage> getAnimation(int index) {
    return animations.get(index);
  }

  // returns a set of file or directory names
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
