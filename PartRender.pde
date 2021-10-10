
import java.util.List;
import java.util.ArrayList;

class PartRender {

  byte alpha = (byte) 255;
  List<Particle> lP;

  PartRender(List<Particle> l) {
    lP = l;
  }

  PartRender() {
    this(new ArrayList<Particle>());
  }

  void render(boolean sphere) {
    if(sphere) {
      noStroke();
    }
    for(Particle p: lP) {
      pushMatrix();
      PVector pos = p.getPos();
      translate(pos.x, pos.y, pos.z);
      if(sphere) {
        fill((p.getColor() & 0xffffff) | (alpha << 24));
        sphere(p.getRadius());
      } else {
        stroke(p.getColor());
        strokeWeight(p.getRadius());
        point(0, 0);
      }
      popMatrix();
    }
  }

}
