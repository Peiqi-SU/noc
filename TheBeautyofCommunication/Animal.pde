/**
 Parent class: Animal
 steer
 **/

class Animal {
  PVector location;
  PVector velocity;
  PVector acceleration;
  PVector desired;
  float maxforce;    // Maximum steering force
  float maxspeed;    // Maximum speed
  float desiredseparation;

  Animal(float x, float y) {
    acceleration = new PVector(0, 0);
    velocity = new PVector(random(-1, 1), random(-1, 1));
    location = new PVector(x, y);
    // override these 2:
    maxspeed = 2;
    maxforce = 0.05;
  }

  void run(ArrayList<Animal> Animals) {
    flock(Animals);
    update();
    borders();
    render();
  }

  void applyForce(PVector force) {
    // We could add mass here if we want A = F / M
    acceleration.add(force);
  }

  // We accumulate a new acceleration each time based on three rules
  void flock(ArrayList<Animal> Animals) {
    PVector sep = separate(Animals);   // Separation
    PVector ali = align(Animals);      // Alignment
    PVector coh = cohesion(Animals);   // Cohesion
    // Arbitrarily weight these forces
    sep.mult(1.5);
    ali.mult(1.0);
    coh.mult(1.0);
    // Add the force vectors to acceleration
    applyForce(sep);
    applyForce(ali);
    applyForce(coh);
  }

  // Method to update location
  void update() {
    // Update velocity
    velocity.add(acceleration);
    // Limit speed
    velocity.limit(maxspeed);
    location.add(velocity);

    // Override these in child class
    // (Birds acceleration).mult(0)
    // (Fish acceleration).mult(0.x)
  }

  // Steer method: apply a steering force towards a target
  PVector seek(PVector target) {
    desired = PVector.sub(target, location);  // A vector pointing from the location to the target
    // Check the border first
    borders();
    // Normalize desired and scale to maximum speed
    desired.normalize();
    desired.mult(maxspeed);
    // Steering = Desired minus Velocity
    PVector steer = PVector.sub(desired, velocity);
    steer.limit(maxforce);  // Limit to maximum steering force
    return steer;
  }

  void render() {
    // Draw a triangle rotated in the direction of velocity
    float theta = velocity.heading() + radians(90);
    fill(175);
    stroke(0);
    pushMatrix();
    translate(location.x, location.y);
    rotate(theta);
    beginShape(TRIANGLES);
    // override different shape here
    endShape();
    popMatrix();
  }

  // set a round boder
  void borders() {
    if (location.x < r) {
      desired = new PVector(maxspeed, velocity.y);
      callFish = false;
    }
    else if (location.x > width -r) {
      desired = new PVector(-maxspeed, velocity.y);
      callBird = false;
    }
    if (location.y < r) {
      desired = new PVector(velocity.x, maxspeed);
    }
    else if (location.y > height-r) {
      desired = new PVector(velocity.x, -maxspeed);
    }
  }

  // Separation
  // Method checks for nearby Animals and steers away
  PVector separate (ArrayList<Animal> Animals) {
    desiredseparation = 25.0f;
    PVector steer = new PVector(0, 0, 0);
    int count = 0;
    // For every Animal in the system, check if it's too close
    for (Animal other : Animals) {
      float d = PVector.dist(location, other.location);
      // If the distance is greater than 0 and less than an arbitrary amount (0 when you are yourself)
      if ((d > 0) && (d < desiredseparation)) {
        // Calculate vector pointing away from neighbor
        PVector diff = PVector.sub(location, other.location);
        diff.normalize();
        diff.div(d);        // Weight by distance
        steer.add(diff);
        count++;            // Keep track of how many
      }
    }
    // Average -- divide by how many
    if (count > 0) {
      steer.div((float)count);
    }

    // As long as the vector is greater than 0
    if (steer.mag() > 0) {
      // Implement Reynolds: Steering = Desired - Velocity
      steer.normalize();
      steer.mult(maxspeed);
      steer.sub(velocity);
      steer.limit(maxforce);
    }
    return steer;
  }

  // Alignment
  // For every nearby Animal in the system, calculate the average velocity
  PVector align (ArrayList<Animal> Animals) {
    float neighbordist = 50;
    PVector sum = new PVector(0, 0);
    int count = 0;
    for (Animal other : Animals) {
      float d = PVector.dist(location, other.location);
      if ((d > 0) && (d < neighbordist)) {
        sum.add(other.velocity);
        count++;
      }
    }
    if (count > 0) {
      sum.div((float)count);
      sum.normalize();
      sum.mult(maxspeed);
      PVector steer = PVector.sub(sum, velocity);
      steer.limit(maxforce);
      return steer;
    } 
    else {
      return new PVector(0, 0);
    }
  }

  // Cohesion
  // For the average location (i.e. center) of all nearby Animals, calculate steering vector towards that location
  PVector cohesion (ArrayList<Animal> Animals) {
    float neighbordist = 50;
    PVector sum = new PVector(0, 0);   // Start with empty vector to accumulate all locations
    int count = 0;
    for (Animal other : Animals) {
      float d = PVector.dist(location, other.location);
      if ((d > 0) && (d < neighbordist)) {
        sum.add(other.location); // Add location
        count++;
      }
    }
    if (count > 0) {
      sum.div(count);
      return seek(sum);  // Steer towards the location
    } 
    else {
      return new PVector(0, 0);
    }
  }

  // end of the class
}

