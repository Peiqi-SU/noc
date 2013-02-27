/* Partical system
 Small is beautiful
 */

ArrayList<ParticleSystem> ps;

void setup() {
  size(500, 500);
  background(0);

  // ParticleSystem(acceleration, radious);
  ps = new ArrayList<ParticleSystem>();
}

void draw() {
  //  background(0);
  for (ParticleSystem thisps: ps) {
    thisps.applyForce();
    thisps.addParticle();
    thisps.run();
  }
}

void mousePressed() {
  ps.add(new ParticleSystem(new PVector(0, 0), random(2,10), new PVector(mouseX,mouseY)));
}

