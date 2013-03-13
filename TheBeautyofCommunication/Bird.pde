/**
 This class extends Animal class to inheri
 **/
int birdColorH = 260, birdColorS = 87, birdColorB = 80, birdColorA = 120;
boolean callBird = false;
class Bird extends Animal {
  int num; // the number of fish
  float bsize = random(12, 16);
  Bird(float x, float y) {
    super(x, y);
    super.maxspeed = 4;
    super.maxforce = 0.03;
    super.desiredseparation = 50;
  }

  // override the shape method
  void render() {
    float theta = velocity.heading() + radians(90);
    fill(birdColorH, birdColorS, birdColorB, birdColorA);
    noStroke();
    pushMatrix();
    translate(location.x, location.y);
    rotate(theta);
    //    rect(0,0, 10,10);
    // The tail
    beginShape( POLYGON );
    // 0-3
    vertex( 0*bsize, -2.5*bsize );
    bezierVertex( 0*bsize, -2.5*bsize, 0.5*bsize, -0.5*bsize, 1*bsize, 1*bsize  );
    // 4-6
    bezierVertex( 0*bsize, 1*bsize, 0*bsize, 1*bsize, -1*bsize, 1*bsize  );
    // 7-9
    bezierVertex( -0.5*bsize, -0.5*bsize, 0*bsize, -2.5*bsize, 0*bsize, -2.5*bsize  );
    endShape();

    // The wing
    beginShape( POLYGON );
    // 0-3
    vertex( 0*bsize, -2*bsize );
    bezierVertex( 1*bsize, -2*bsize, 1*bsize, -1*bsize, 2*bsize, 0*bsize  );
    // 4-6
    bezierVertex( 1*bsize, 0*bsize, -1*bsize, 0*bsize, -2*bsize, 0*bsize  );
    // 7-9
    bezierVertex( -1*bsize, -1*bsize, -1*bsize, -2*bsize, 0*bsize, -2*bsize  );
    endShape();
    popMatrix();
  }

  void update() {
    super.update();
    acceleration.mult(0);
    // Call back th fish
    if (callBird) {
      super.acceleration = new PVector(width-super.location.x, height/2-super.location.y);
    }
  }

  // end of the class
}

