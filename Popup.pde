
class Popup {

  PFont font;
  ArrayList<String> items = new ArrayList<String>();
  boolean visible = false;
  PVector pos = new PVector(0, 0);
  int size = 12;
  int padding = 3;

  Popup(PFont f) {
    font = f;
  }

  int getYIndex(int cursorX, int cursorY, float w, int h) {
    if((cursorX >= pos.x) && (cursorX <= pos.x + w)) {
      return int((cursorY - pos.y) / h);
    }
    return -1;
  }

  int getYIndex(int cursorX, int cursorY) {
    return getYIndex(cursorX, cursorY, maxWidth() + 2 * padding, size + 2 * padding);
  }

  float maxWidth() {
    float max = 0;
    for(String s: items) {
      float w = textWidth(s);
      if(w > max) {
        max = w;
      }
    }
    return max;
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

  void render(int cursorX, int cursorY) {
    if(visible) {
      if(font != null) {
        textFont(font);
      }
      textSize(size);
      textAlign(LEFT, TOP);
      stroke(0, 0, 120);
      strokeWeight(2);
      pushMatrix();
      rectMode(CORNER);
      translate(pos.x, pos.y);
      float max = maxWidth();
      float w = max + 2 * padding;
      int h = size + 2 * padding;
      int selected = getYIndex(cursorX, cursorY, w, h);
      for(int i = 0; i < items.size(); ++i) {
        if(i == selected) {
          fill(0, 0, 255);
        } else {
          fill(0, 0, 200);
        }
        rect(0, 0, w, h);
        fill(0, 0, 0);
        text(items.get(i), padding, padding);
        translate(0, h);
      }
      popMatrix();
    }
  }

}
