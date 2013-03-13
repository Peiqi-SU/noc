boolean hasripple = false;
class Ripple {
  float ripplex, rippley; // The start point of the ripple
  float rippleColorH, rippleColorS, rippleColorB, thisAlpha; // Color of the ripple
  float[] ripple = new float[30]; // Number of the ripple

  Ripple(float _ripplex, float _rippley, float _rippleColorH, float _rippleColorS, float _rippleColorB, float _thisAlpha) {
    ripplex = _ripplex;
    rippley = _rippley;
    rippleColorH = _rippleColorH;
    rippleColorS = _rippleColorS;
    rippleColorB = _rippleColorB;
    thisAlpha = _thisAlpha;
  }

  void render() {
    noStroke();
    fill(rippleColorH, rippleColorS, rippleColorB, thisAlpha);
    ellipse( ripplex, rippley, 50, 50);
  }
}

