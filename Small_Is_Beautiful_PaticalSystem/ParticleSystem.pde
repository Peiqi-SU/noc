class ParticleSystem {
  ArrayList<Particle> particles;

  PVector originLocation;
  PVector originVelocity;
  PVector originAcceleration;
  PVector mouseLocation;
  float originRadious;

  // pass parameters to child class
  ParticleSystem(PVector a, float r, PVector m) {
    originAcceleration = a.get();
    mouseLocation = m.get();
    originRadious = r;

    particles = new ArrayList<Particle>();
  }

  void addParticle() {
    // add particle with diffrent origenal location
    float temprand = random(TWO_PI);
    float temprand2 = random(10,20);
    float xoff = cos(temprand) * width/temprand2;
    float yoff = sin(temprand) * width/temprand2;
    originLocation = new PVector(xoff+mouseLocation.x, yoff+mouseLocation.y);
    particles.add(new Particle(originAcceleration, originLocation,mouseLocation, originRadious));
  }

  // A function to apply a force to all Particles
  void applyForce() {
    for (Particle p: particles) {
      PVector force = new PVector(0, 0);
      p.applyForce(force);
    }
  }

  void run() {
    for (int i = particles.size()-1; i >= 0; i--) {
      Particle p = particles.get(i);

      p.run();
      if (p.isDead()) {
        particles.remove(i);
      }
    }
  }
  // end of the class
}

