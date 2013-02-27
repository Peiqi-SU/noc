class Particle {
  PVector location;
  PVector velocity;
  PVector acceleration;
  PVector mouseClickLocation;

  float lifespan;
  float pRadious;

  // color of the particle
  int red2, green2, blue2;
  int hue2, sat2, bri2;

  Particle(PVector a, PVector l, PVector m, float r) {
    acceleration = a.get();
    velocity = new PVector(random(-0.2, 0.2), random(-0.2, 0.2));
    location = l.get();
    mouseClickLocation = m.get();

    pRadious = r;
    lifespan = 255.0;
  }

  void run() {
    update();
    setColor();
    display();
  }

  // How the particle move
  void applyForce(PVector force) {
    PVector f = force.get();
    f.div(1);   
    acceleration.add(f);
  }

  // Update location
  void update() {
    velocity.add(acceleration);
    location.add(velocity);
    acceleration.mult(0);
    lifespan -= 0.8;
  }

  void setColor() {
    float tempd = distance(location.x, location.y, mouseClickLocation.x, mouseClickLocation.y);
    colorMode(HSB, 360, 100, 100, 255);
    float tempd2 = map(pRadious, 2,10, 50, 200);
    hue2 = (int)map(tempd, 0, 150*150, tempd2, tempd2-50);
    sat2 = 63;
    bri2 = 81;

    //      if (tempd > 120*120) {
    //      // Pink
    //      red2 = 255;
    //      green2 = 102;
    //      blue2 = 204;
    //    } 
    //    else if (tempd > 100*100) {
    //      // Orange
    //      red2 = 204;
    //      green2 = 102;
    //      blue2 = 0;
    //    } 
    //    else if (tempd > 85*85) {
    //      // Orange
    //      red2 = 162;
    //      green2 = 209;
    //      blue2 = 76;
    //    } 
    //    else {
    //      // Blue
    //      red2 = 10;
    //      green2 = 91;
    //      blue2 = 124;
    //    }
  }

  void display() {
    //    stroke(red2+50, green2+50, blue2+50,map(lifespan,0,255, 0,10));
    stroke(hue2, sat2+10, bri2+10, map(lifespan, 0, 255, 0, 10));
    strokeWeight(2);
    //    fill(red2, green2, blue2, map(lifespan,0,255, 0,5));
    fill(hue2, sat2, bri2, map(lifespan, 0, 255, 0, 5));
    ellipse(location.x, location.y, pRadious, pRadious);
  }

  // Is the particle still useful?
  boolean isDead() {
    if (lifespan < 0.0) {
      return true;
    } 
    else {
      return false;
    }
  }

  // overwrite the distance func
  float distance(float x1, float y1, float x2, float y2) {
    return (sq(x1-x2) + sq(y1-y2));
  }

  // end of the class
}

