//Ball
int ballX;
int ballY;
int ballHeight;
int ballWidth;
int speedX;
int speedY;
int directionX; 
int directionY;

//Paddles
int player1X;
int player2X;
int player1Y;
int player2Y;

//Healthbars
int bar1X;
int bar1Y;
int player1health;
int bar1colour;
int bar2X;
int bar2Y;
int player2health;
int bar2colour;

//Movements
boolean upX;
boolean downX;
boolean upY;
boolean downY;

//Text
String start; 
boolean screen;

void setup() {
  size(900, 700);
  reset();
}

void reset() {
  //Ball
  ballX = 500;
  ballY = 350;
  ballHeight = 35;
  ballWidth = 35;
  speedX = 4;
  speedY = 4;
  directionX = 1;  
  directionY = 1;

  //Paddles
  player1X = 0;
  player2X = 860;
  player1Y = 350;
  player2Y = 350;

  //Healthbars
  bar1X = 100;
  bar1Y = 20;
  player1health = 100;
  bar1colour = #22E515;
  bar2X = 700;
  bar2Y = 20;
  player2health = 100;
  bar2colour = #22E515;

  //Movements
  upX = false;
  downX = false;
  upY = false;
  downY = false;

  //Texts
  start = "Press ENTER to begin the game."; 
  screen = true;
}// end reset

void draw() {
  background(0);


  if (screen == true) {
    startScreen();
  }

  if (key == ENTER) {
    screen = false;
  }

  if (screen == false) {
    background(0);
    //Empty Space**
    fill(255);
    rect(0, 0, 40, 1000);
    rect(860, 0, 40, 1000);

    //Paddles
    fill(0);
    rect(player1X, player1Y, 40, 140);
    rect(player2X, player2Y, 40, 140);

    //Healthbars
    fill(bar1colour);
    rect(bar1X, bar1Y, player1health, 15);
    fill(bar2colour);
    rect(bar2X, bar2Y, player2health, 15);

    //Ball
    fill(194, 16, 0);
    ellipse(ballX, ballY, ballHeight, ballWidth);

    moveCircle();
    movePaddle();
    moveCollisions();
  }
}

void startScreen() {
  textSize(32);
  text(start, 200, 350, 10);
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
  if ((ballX - ballWidth / 2 < player1X + 40) && ((ballY - ballHeight / 2 > player1Y + 140) || (ballY + ballHeight / 2 < player1Y))) {
    if (speedX < 0) {
      player1health -= 20;
      speedX = -speedX*1;
      if (player1health == 20) {
        bar1colour = #F51911;
      }
    }
  } else if ((ballX + ballWidth / 2 > player2X) && ((ballY - ballHeight / 2 > player2Y + 140) || (ballY + ballHeight/2 < player2Y))) {
    if (speedX > 0) {
      player2health -= 20;
      bar2X += 20;
      speedX = -speedX*1;
      if (player2health == 20) {
        bar2colour = #F51911;
      }
    }
  }

  if (player1health <= 0 || player2health <= 0) {
    screen = true;
    reset();
  }
}

void keyPressed() {
  screen = false;
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
  screen = false;
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
