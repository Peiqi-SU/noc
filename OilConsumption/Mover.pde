class Mover {

  PVector location;
  PVector velocity;
  PVector acceleration;
  float xoff = 2000;

  // Mass is tied to radius
  float mass;
  int oilNum;

  Mover(int m0, float m, float x, float y) {
    oilNum = m0;
    mass = m;
    location = new PVector(x, y);
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);
  }

  // a = f/m
  void applyForce(PVector force) { 
    PVector f = PVector.div(force, mass);
    acceleration.add(f);
  }

  void update() {

    // Velocity changes according to acceleration
    velocity.add(acceleration);
    // Location changes by velocity
    location.add(velocity);
    // Add the float feeling
    location.x +=noise(xoff)*2-1;
    location.x +=random(-0.45, 0.55);
    location.y +=noise(xoff)*2-1;
    location.y +=random(-0.45, 0.55);
    xoff += 0.1;
    // We must clear acceleration each frame
    acceleration.mult(0);
  }

  void display() {
    noStroke();
    fill(0);
    ellipse(location.x, location.y, mass*16, mass*16);
    
    // Display the oil number
    fill(0, 150);
    textAlign(CENTER);
    textFont(font, 14);
    text(oilNum, location.x, location.y + mass*8+15);
  }

  // Bounce off
  void checkEdges() {
    if (location.y < topHeight) {
      velocity.y *= -0.2;  // A little dampening --> Todo: more feelings of oil drops
      location.y = topHeight;
    }
  }
}

