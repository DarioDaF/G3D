
import java.util.List;
import java.util.LinkedList;
import java.util.ListIterator;

class Interactor {

  List<Grav> lG;

  Interactor(List<Grav> l) {
    lG = l;
  }

  Interactor() {
    this(new LinkedList<Grav>());
  }

  void move() {
    for(ListIterator<Grav> iA = lG.listIterator(); iA.hasNext(); ) {
      Grav gA = iA.next();
      PVector pA = gA.getPos();
      PVector sA = gA.getSpeed();
      float mA = gA.getMass();
      for(ListIterator<Grav> iB = lG.listIterator(iA.nextIndex()); iB.hasNext(); ) {
        Grav gB = iB.next();
        PVector dS = gB.getPos().get();
        dS.sub(pA);
        float d2 = dS.magSq();
        dS.normalize();
        dS.mult(mA * gB.getMass() / d2);
        //
        //float dR = gA.getRadius() + gB.getRadius();
        //if(d2 < dR * dR) {
        //  dS.mult(-1);
        //}
        //
        sA.add(dS);
        gB.getSpeed().sub(dS);
      }
      gA.move();
    }
  }

  void collide() {
    /* Process collisions */
  }

}
