class Player {

  float x;
  float y;

  float imgW = 140;
  float imgH = 110;

  float w = 80;   // largura do hitbox
  float h = 80;   // altura do hitbox

  float hitX;
  float hitY;

  float velocityY = 0;
  float gravity = 1;

  boolean jumping = false;

  PImage spriteNormal;
  PImage spritePulo;

  int frameAtual = 0;
  int contadorFrame = 0;
  int velocidadeAnimacao = 10;

  Player() {
    x = 120;
    y = 360;
    spriteNormal = loadImage("player.png");
    spritePulo   = loadImage("player_pulo.png");
  }

  void update() {
    velocityY += gravity;
    y += velocityY;

    if (y >= 360) {
      y = 360;
      velocityY = 0;
      jumping = false;
    }

    // hitbox centralizada na imagem
    hitX = x + (imgW - w) / 2;
    hitY = y + (imgH - h) / 2;

    if (!jumping) {
      contadorFrame++;
      if (contadorFrame >= velocidadeAnimacao) {
        contadorFrame = 0;
        frameAtual = (frameAtual + 1) % 2;
      }
    }
  }

  void display() {
    if (jumping) {
      image(spritePulo, x, y, imgW, imgH);
    } else {
      if (frameAtual == 0) {
        image(spriteNormal, x, y, imgW, imgH);
      } else {
        image(spritePulo, x, y, imgW, imgH);
      }
    }

    // descomente para ver a hitbox (debug)
    // noFill();
    // stroke(255, 0, 0);
    // rect(hitX, hitY, w, h);
  }

  void jump() {
    if (!jumping) {
      velocityY = -18;
      jumping = true;
    }
  }

  void moveLeft() {
    x -= 30;
    if (x < 50) {
      x = 50;
    }
  }

  void moveRight() {
    x += 30;
    if (x > width - 150) {
      x = width - 150;
    }
  }
}
