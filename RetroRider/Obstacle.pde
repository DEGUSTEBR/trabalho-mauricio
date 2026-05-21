class Obstacle {

  float x;
  float y;

  float w;
  float h;

  float imgW;
  float imgH;

  float hitX;
  float hitY;

  int type;

  PImage img;

  Obstacle(int t) {
    type = t;
    x = width + 100;

    if (type == 0) {
      y = 355;
      imgW = 120;
      imgH = 160;
      w = 35;
      h = 130;
      img = loadImage("tipe_1.png");
    }
    if (type == 1) {
      y = 375;
      imgW = 190;
      imgH = 120;
      w = 140;
      h = 70;
      img = loadImage("tipe_2.png");
    }
    if (type == 2) {
      y = 385;
      imgW = 160;
      imgH = 100;
      w = 110;
      h = 50;
      img = loadImage("tipe_3.png");
    }
  }

  void update() {
    x -= gameSpeed;
    hitX = x + (imgW - w) / 2;
    hitY = y + (imgH - h) / 2;
  }

  void display() {
    image(img, x, y, imgW, imgH);

    // descomente para ver a hitbox (debug)
    // noFill();
    // stroke(255, 0, 0);
    // rect(hitX, hitY, w, h);
  }

  boolean hits(Player p) {
    return (
      p.x + p.w > hitX &&
      p.x < hitX + w &&
      p.y + p.h > hitY &&
      p.y < hitY + h
    );
  }

  boolean offscreen() {
    return x < -150;
  }
}
