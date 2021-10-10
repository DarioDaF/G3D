
class MouseBar {

  boolean visible = false;
  PVector pos = new PVector(0, 0);
  int cH = 10;
  int cW = 2;
  int w = 120;
  int padding = 5;

  float value = 255;
  float max = 255;
  float min = 0;

  boolean getIn(int cursorX, int cursorY) {
    int halfW = w / 2 + padding;
    int halfH = cH / 2 + padding;
    return visible && (cursorX >= pos.x - halfW) && (cursorX <= pos.x + halfW) && (cursorY >= pos.y - halfH) && (cursorY <= pos.y + halfH);
  }

  void show(PVector p) {
    pos = p;
    visible = true;
  }

  void show(int x, int y) {
    pos.set(x, y, 0);
    visible = true;
  }

  void show() {
    show(mouseX, mouseY);
  }

  void hide() {
    visible = false;
  }

  void render() {
    if(visible) {
      stroke(0, 0, 120);
      strokeWeight(2);
      rectMode(CENTER);
      pushMatrix();
      translate(pos.x, pos.y);
      fill(0, 0, 200);
      rect(0, 0, w + 2 * padding, cH + 2 * padding);
      float halfW = w / 2;
      line(-halfW, 0, +halfW, 0);
      fill(0, 0, 255);
      rect(map(value, min, max, -halfW, +halfW), 0, cW, cH);
      popMatrix();
    }
  }

}
