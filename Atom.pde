
class Atom implements Grav, Particle {

  PVector pos, speed;
  float density;
  float radius;

  PVector getPos() { return pos; }
  PVector getSpeed() { return speed; }
  void move() { pos.add(speed); }
  float getRadius() { return radius; }
  float getMass() { return radius * radius * density; } // Volume Natural Unit (V = r^2)
  int getColor() { return color(map(density, 0.2, 20, 0, 255), 255, 255); }

  Atom(PVector p, PVector s, float d, float r) {
    pos = p;
    speed = s;
    density = d;
    radius = r;
  }

  Atom(PVector p, float d, float r) {
    this(p, new PVector(0, 0), d, r);
  }

}
