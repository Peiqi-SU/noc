class Liquid {

  // Liquid is a rectangle --> Todo: change to dynamic shape
  float x, y, w, h;
  // Coefficient of drag
  float c;

  Liquid(float x_, float y_, float w_, float h_, float c_) {
    x = x_;
    y = y_;
    w = w_;
    h = h_;
    c = c_;
  }

  // Is the Mover in the Liquid?
  boolean contains(Mover m) {
    PVector l = m.location;
    if (l.x > x && l.x < x + w && l.y > y && l.y < y + h) {
      return true;
    }  
    else {
      return false;
    }
  }

  // Calculate drag force
  PVector drag(Mover m) {
    // Apply the physics & maths here
    float speed = m.velocity.mag();
    float dragMagnitude = ((m.mass)*(m.mass)*0.4-0.3)*0.05;
    //    println(dragMagnitude);

    // Direction is velocity
    PVector dragForce = new PVector(0, -1);
    dragForce.normalize();
    dragForce.mult(dragMagnitude);
    return dragForce;
  }

  void display() {
    noStroke();
    fill(0, 147, 155);
    rect(x, y, w, h);
  }
}

