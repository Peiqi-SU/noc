Mover[] movers = new Mover[80];
int border = 40; // the border from window
int colorRange = 100; // 0-360

void setup() {
  size(800, 800);
  frameRate(30);
  for (int i = 0; i < movers.length; i++) {
    movers[i] = new Mover();
  }
}

void draw() {
  background(0);
  for (int i = 0; i < movers.length; i++) {
    movers[i].update();
    movers[i].checkEdges();
    movers[i].display();
    
    // draw a line if two circles come close
    for (int j = i+1; j < movers.length; j++) {
      // the distance of 2 vectors
      float distance = PVector.dist(movers[i].location, movers[j].location);
      if (distance<100) {
        line( movers[i].location.x, movers[i].location.y, movers[j].location.x, movers[j].location.y);
      }
    }
  }
}

class Mover {
  PVector location;
  PVector velocity;
  PVector acceleration;
  float maxspeed;
  
  // for perlin noise
  float increment = 0.01;
  float xoff = random(0, 1000);
  float coff = random(0, 200);

  Mover() {
    // Start in the center
    location = new PVector(random(width/2-border, width/2+border), random(height/2-border, height/2+border), 0);
    velocity = new PVector(0, 0, 0);
    maxspeed = 3;
  }

  void update() {
    //    acceleration = new PVector(random(-1, 1), random(-1, 1), random(-1, 1));
    acceleration = PVector.random3D();
    acceleration.normalize();
    acceleration.mult(noise(xoff)*2);
    xoff += increment; 

    velocity.add(acceleration);
    velocity.limit(maxspeed);
    location.add(velocity);
  }

  void display() {
    // map the z location to radius
    float radius = map(location.z, -300, 300, 10, 80);
    colorMode(HSB, 360, 100, 100, 100);
    // z location -- alpha
    stroke(noise(coff)*colorRange, 40, 100, constrain(radius+30, 0, 80));
    strokeWeight(0.8);
    fill(noise(coff)*colorRange, 80, 100, constrain(radius-10, 0, 50));
    ellipse(location.x, location.y, radius, radius);
    coff += increment;
  }

  void checkEdges() {
    // bounce back
    if (location.x > width-border) {
      location.x = width-border;
    } 
    else if (location.x < border) {
      location.x = border;
    }

    if (location.y > height-border) {
      location.y = height-border;
    } 
    else if (location.y < border) {
      location.y = border;
    }

    if (location.z > 300) {
      location.z = 300;
    } 
    else if (location.z < -300) {
      location.z = -300;
    }
  }
}

