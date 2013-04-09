// reference: http://processing.org/learning/anatomy/

class Star {

  Star(int n, float cx, float cy, float w, float h, float startAngle, float proportion) {
    if (n > 2) {
      float angle = TWO_PI/ (2 *n);  // twice as many sides
      float dw; // draw width
      float dh; // draw height

      w = w / 2.0;
      h = h / 2.0;

      beginShape();
      for (int i = 0; i < 2 * n; i++) {
        dw = w;
        dh = h;
        if (i % 2 == 1) {
          dw = w * proportion;
          dh = h * proportion;
        }
        vertex(cx + dw * cos(startAngle + angle * i), 
        cy + dh * sin(startAngle + angle * i));
      }
      endShape(CLOSE);
    }
  }
}

