//Ball
int originX = 500;
int originY = 350;
int h = 35;
int w = 35;
int speedX = 4;
int speedY = 4;
int directionX = 1;  
int directionY = 1;

//Paddle
int player1X = 30;
float player2X = 830;
int player1Y = 350;
float player2Y = 350;

//Movements
boolean upX = false;
boolean downX = false;
boolean upY = false;
boolean downY = false;

void setup() {
  size(900, 700);
}

void draw() {
  background(0);

  //Empty Space**
  fill(0);
  rect(30, 0, 40, 1000);
  rect(830, 0, 40, 1000);

  //Paddles
  fill(255);
  rect(player1X, player1Y, 40, 140);
  rect(player2X, player2Y, 40, 140);

  //Ball
  fill(194, 16, 0);
  ellipse(originX, originY, h, w);

  moveCircle();
  movePaddle();
  moveCollisions();
}


void moveCircle() {  
  originX = originX + speedX*1;
  originY = originY + speedY*1;

  if (originX > width-w+20 || originX < w) {
    speedX *= -1;
  }
  if (originY > height-h+20 || originY < h) {
    speedY *= -1;
  }
}

void movePaddle() {
  //key movements
  if (upX == true) {
    player1Y = player1Y - 5;
  }
  if (downX == true) {
    player1Y = player1Y + 5;
  }
  if (upY == true) {
    player2Y = player2Y - 5;
  }
  if (downY == true) {
    player2Y = player2Y + 5;
  } 

  //Wrap around
  if (player1Y > 700) {
    player1Y = 0;
  } else if (player1Y + 140 < 0) {
    player1Y = 700;
  }
  if (player2Y > 700) {
    player2Y = 0;
  } else if (player2Y + 140 < 0) {
    player2Y = 700;
  }
}

void moveCollisions() {
  //Collisions
  if (originX - w/2 < player1X + 40/2 && originY - h/2 < player1Y + 140/2 && originY + h/2 > player1Y - 140/2 ) {
    if (speedX < 0) {
      speedX = -speedX*1;
    }
  } else if (originX + w/2 > player2X - 40/2 && originY - h/2 < player2Y + 140/2 && originY + h/2 > player2Y - 140/2 ) {
    if (speedX > 0) {
      speedX = -speedX*1;
    }
  }
}

void keyPressed() {
  if (key == 'w' || key == 'W') {
    upX = true;
  } else if (key == 's' || key == 'S') {
    downX = true;
  } else if (keyCode == UP) {
    upY = true;
  } else if (keyCode == DOWN) {
    downY = true;
  }
}

void keyReleased() {
  if (key == 'w' || key == 'W') {
    upX = false;
  } else if (key == 's' || key == 'S') {
    downX = false;
  } else if (keyCode == UP) {
    upY = false;
  } else if (keyCode == DOWN) {
    downY = false;
  }
}
