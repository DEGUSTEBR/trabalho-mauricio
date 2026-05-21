// =====================================
// RETRO RIDER
// Jogo retrô estilo Atari/Motocross
// =====================================

import processing.sound.*;

Player player;
ArrayList<Obstacle> obstacles;

int score = 0;
int lives = 3;

boolean gameOver = false;
boolean gameStarted = false;

float gameSpeed = 10;
boolean musicaAtiva = true;
boolean tudoSilenciado = false;

PFont font;
PImage bg;

// Sons
SoundFile musicaFundo;
SoundFile somColisao;
// SoundFile somPulo;

void setup() {
  size(1000, 500);
  surface.setResizable(false);
  player = new Player();
  obstacles = new ArrayList<Obstacle>();
  font = createFont("Arial", 24);
  textFont(font);

  bg = loadImage("background.png");

  musicaFundo = new SoundFile(this, "Musica de fundo.mp3");
  somColisao  = new SoundFile(this, "colisao.mp3");
  // somPulo  = new SoundFile(this, "pulo.mp3");

  musicaFundo.loop();
}

void draw() {
  drawBackground();

  if (!gameStarted) {
    showStartScreen();
    return;
  }

  if (gameOver) {
    showGameOver();
    return;
  }

  score++;

  if (frameCount % 300 == 0) {
    gameSpeed += 0.5;
  }

  player.update();
  player.display();

  spawnObstacles();
  updateObstacles();

  drawHUD();
}

// =====================================
// FUNDO
// =====================================

void drawBackground() {
  image(bg, 0, 0, 1000, 500);

}

// =====================================
// TELA INICIAL
// =====================================

void showStartScreen() {
  fill(255);
  textAlign(CENTER);
  textSize(50);
  text("RETRO RIDER", width/2, 180);
  textSize(24);
  text("Pressione ENTER para jogar", width/2, 260);
  textSize(18);
  text("SETAS = mover | ESPACO = pular", width/2, 310);
  textSize(16);
  text("Aperte M para desligar a musica", width/2, 350);
}

// =====================================
// GAME OVER
// =====================================

void showGameOver() {
  if (musicaFundo.isPlaying()) {
    musicaFundo.stop();
  }

  fill(255, 0, 0);
  textAlign(CENTER);
  textSize(48);
  text("GAME OVER", width/2, 200);
  fill(255);
  textSize(28);
  text("Pontuacao: " + score, width/2, 260);
  textSize(22);
  text("Pressione R para reiniciar", width/2, 320);
}

// =====================================
// HUD
// =====================================

void drawHUD() {
  fill(255);
  textAlign(LEFT);
  textSize(24);
  text("Score: " + score, 20, 40);
  text("Vidas: " + lives, 20, 80);
}

// =====================================
// OBSTÁCULOS
// =====================================

void spawnObstacles() {
  if (frameCount % 70 == 0) {
    int type = int(random(3));
    obstacles.add(new Obstacle(type));
  }
}

void updateObstacles() {
  for (int i = obstacles.size()-1; i >= 0; i--) {
    Obstacle obs = obstacles.get(i);
    obs.update();
    obs.display();

    if (obs.hits(player)) {
      obstacles.remove(i);
      if (!tudoSilenciado) {
        somColisao.play();
      }
      lives--;
      if (lives <= 0) {
        gameOver = true;
      }
      continue;
    }

    if (obs.offscreen()) {
      obstacles.remove(i);
    }
  }
}

// =====================================
// CONTROLES
// =====================================

void keyPressed() {
  if (keyCode == ENTER) {
    gameStarted = true;
  }
  if (key == 'r' || key == 'R') {
    restartGame();
  }
  if (key == ' ') {
    player.jump();
    // somPulo.play();
  }
  if (keyCode == LEFT) {
    player.moveLeft();
  }
  if (keyCode == RIGHT) {
    player.moveRight();
  }
  if (key == 'm' || key == 'M') {
    if (musicaAtiva) {
      musicaFundo.stop();
      musicaAtiva = false;
    } else {
      musicaFundo.loop();
      musicaAtiva = true;
    }
  }
  if (key == 'n' || key == 'N') {
    tudoSilenciado = !tudoSilenciado;
    if (tudoSilenciado) {
      musicaFundo.stop();
    } else {
      if (musicaAtiva) {
        musicaFundo.loop();
      }
    }
  }
  if (key == '+') {
    lives = 999;
  }
}

// =====================================
// REINICIAR
// =====================================

void restartGame() {
  score = 0;
  lives = 3;
  gameSpeed = 6;
  obstacles.clear();
  player = new Player();
  gameOver = false;
  gameStarted = true;

  if (musicaAtiva && !tudoSilenciado && !musicaFundo.isPlaying()) {
    musicaFundo.loop();
  }
}
