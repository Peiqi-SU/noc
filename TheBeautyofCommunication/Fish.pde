/**
 This class extends Animal class to inheri
 **/
int fishColorH = 334, fishColorS = 87, fishColorB = 80, fishColorA = 60;
boolean callFish = false;

class Fish extends Animal {

  int num; // the number of fish
  float fsize = random(10, 14);

  Fish(float x, float y) {
    super(x, y);
    super.maxspeed = 2;
    super.maxforce = 0.01;
    super.desiredseparation = 30;
  }

  // override the shape method
  void render() {
    float theta = velocity.heading() + radians(90);
    fill(fishColorH, fishColorS, fishColorB, fishColorA);
    noStroke();
    pushMatrix();
    translate(location.x, location.y);
    rotate(theta);
    //    rect(0,0, 10,10);
    beginShape( POLYGON );
    // 0-3
    vertex( 0*fsize, -1.5*fsize );
    bezierVertex( 0.5*fsize, -1.5*fsize, 1*fsize, -0.5*fsize, 1*fsize, 0*fsize  );
    // 4-6
    bezierVertex( 1*fsize, 1.5*fsize, 0*fsize, 2.5*fsize, -0.5*fsize, 3.5*fsize  );
    // 7-9
    bezierVertex( 0*fsize, 3.5*fsize, 0*fsize, 3.5*fsize, 0.5*fsize, 3.5*fsize  );
    // 10-12
    bezierVertex( 0*fsize, 2.5*fsize, -1*fsize, 1.5*fsize, -1*fsize, 0*fsize  );
    // 13-15
    bezierVertex( -1*fsize, -0.5*fsize, -0.5*fsize, -1.5*fsize, 0*fsize, -1.5*fsize  );
    endShape();
    popMatrix();
  }

  void update() {
    super.update();
    acceleration.mult(0.9);
    // Call back th fish
    if (callFish) {
      super.acceleration = new PVector(0-super.location.x, height/2-super.location.y);
    }
  }

  // end of the class
}

