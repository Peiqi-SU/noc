// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

// Flock class
// Does very little, simply manages the ArrayList of all the Animals

class Flock {
  ArrayList<Animal> Animals; // An ArrayList for all the Animals
  int NumOfFish = 40;
  int NumOfBirds = 30;

  Flock() {
    Animals = new ArrayList<Animal>(); // Initialize the ArrayList
    addAnimal();
  }

  void run() {

    for (Animal b : Animals) {
      b.run(Animals);  // Passing the entire list of Animals to each Animal individually
    }
  }

  void addAnimal() {
    // Add fish to the animal arraylist
    for (int i = 0; i < NumOfFish; i++) {
      Animals.add(new Fish(r, height/2));
    }
    // Add birds to the animal arraylist
    for (int i = 0; i < NumOfBirds; i++) {
      Animals.add(new Bird(width-r, height/2));
    }
  }
  // end of the class
}

