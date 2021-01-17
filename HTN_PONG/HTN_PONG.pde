//Ball
int ballX = 500;
int ballY = 350;
int ballHeight = 35;
int ballWidth = 35;
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
  ellipse(ballX, ballY, ballHeight, ballWidth);

  moveCircle();
  movePaddle();
  moveCollisions();
}


void moveCircle() {  
  ballX = ballX + speedX * 1;
  ballY = ballY + speedY * 1;

  if (ballX > width- ballWidth +20 || ballX < ballWidth) {
    speedX *= -1;
  }
  if (ballY > height- ballHeight +20 || ballY < ballHeight) {
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
  if ((ballX - ballWidth / 2 < player1X + 40) && (ballY - ballHeight / 2 < player1Y + 140) && (ballY + ballHeight / 2 > player1Y)) {
    if (speedX < 0) {
      speedX = -speedX*1;
    }
  } else if ((ballX + ballWidth / 2 > player2X) && (ballY - ballHeight / 2 < player2Y + 140) && (ballY + ballHeight/2 > player2Y)) {
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
