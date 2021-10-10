List<Atom> ll = new LinkedList<Atom>();

Interactor gi = new Interactor((List) ll);
PartRender pr = new PartRender((List) ll);

void reGen() {
  ll.clear();
  for(int x = -3; x <= 3; ++x) {
    for(int y = -3; y <= 3; ++y) {
      for(int z = -3; z <= 3; ++z) {
        ll.add(new Atom(new PVector(x * 60, y * 60, z * 60), map(x + y + z, -9, 9, 0.2, 20), map(x + y + z, -9, 9, 3, 1)));
      }
    }
  }
}

void randGen() {
  ll.clear();
  for(int x = -3; x <= 3; ++x) {
    for(int y = -3; y <= 3; ++y) {
      for(int z = -3; z <= 3; ++z) {
        ll.add(new Atom(new PVector(x * 60, y * 60, z * 60), random(0.2, 20), random(1, 3)));
      }
    }
  }
}

int fR = 60;
float zoom = 1;
boolean HUD = true;

Popup rClick;
MouseBar alphaBar;

PFont info;

void setup() {
  //size(800, 600, P3D);
  fullScreen(P3D);
  sphereDetail(10);
  noSmooth();
  colorMode(HSB);
  reGen();
  frameRate(fR);

  info = loadFont("Consolas-Bold.vlw");
  rClick = new Popup(loadFont("Verdana.vlw"));
  alphaBar = new MouseBar();

  rClick.items.add("Reset"); // 0
  rClick.items.add("Random"); // 1
  rClick.items.add("Change visual mode"); // 2
  rClick.items.add("Change alpha value"); // 3
  rClick.items.add("More FPS (+5)"); // 4
  rClick.items.add("Less FPS (-5)"); // 5
  rClick.items.add("Zoom x1"); // 6
  rClick.items.add("Show/Hide HUD"); // 7
  rClick.items.add("Exit"); // 8
}

void mouseWheel(MouseEvent mwe) {
  if(alphaBar.visible) {
    alphaBar.value = constrain(alphaBar.value - mwe.getCount() * 2, alphaBar.min, alphaBar.max);
    pr.alpha = (byte) round(alphaBar.value);
  } else {
    zoom -= mwe.getCount() / 20.0;
  }
}

boolean sphere = true;
boolean animate = false;

void draw() {
  background(0);
  translate(width / 2, height / 2);
  scale(zoom);
  if(sphere) {
    lights();
    ambientLight(0, 0, 100);
    //directionalLight(0, 0, 100, 0, -1, 0);
    pointLight(0, 0, 255, 0, 0, 0);
  }
  rotateX(map(mouseY, height, 0, -HALF_PI, HALF_PI));
  rotateY(map(mouseX, 0, width, -HALF_PI, HALF_PI));
  hint(ENABLE_DEPTH_TEST);
  pr.render(sphere);

  camera();
  hint(DISABLE_DEPTH_TEST);

  if(HUD) {
    noStroke();
    noLights();
    textFont(info);
    textSize(14);
    textAlign(RIGHT, TOP);
    fill(0, map(frameRate, 1, fR, 255, 0), 255);
    text("Real frame rate: " + String.format("%.2f", frameRate), width - 10, 10);
    fill(0, 0, 255);
    text("Requested frame rate: " + fR, width - 10, 34);
    text("Zoom: " + String.format("%.2f", zoom), width - 10, 68);
  }

  alphaBar.render();
  if(!alphaBar.getIn(mouseX, mouseY)) {
    alphaBar.hide();
  }
  rClick.render(mouseX, mouseY);

  if(animate) {
    gi.move();
    gi.collide();
  }
}

void mousePressed() {
  switch(mouseButton) {
    case RIGHT:
      rClick.show(mouseX, mouseY);
      break;
    case LEFT:
      if(rClick.visible) {
        switch(rClick.getYIndex(mouseX, mouseY)) {
          case 0:
            reGen();
            break;
          case 1:
            randGen();
            break;
          case 2:
            sphere = !sphere;
            break;
          case 3:
            alphaBar.show();
            break;
          case 4:
            fR = min(fR + 5, 120);
            frameRate(fR);
            break;
          case 5:
            fR = max(fR - 5, 5);
            frameRate(fR);
            break;
          case 6:
            zoom = 1;
            break;
          case 7:
            HUD = !HUD;
            break;
          case 8:
            exit();
            break;
        }
        rClick.hide();
      } else {
        animate = !animate;
      }
      break;
  }
}
