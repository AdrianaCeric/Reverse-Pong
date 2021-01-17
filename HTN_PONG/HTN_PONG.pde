import processing.sound.*;
  
  SoundFile song;
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

//Gamemode
int players = 1;

void setup() {
  size(900, 700);
  reset();
  
  //Sound
  song = new SoundFile(this, "song.mp3");
  song.play();
}

void reset() {
  //Ball
  ballX = 500;
  ballY = 350;
  ballHeight = 35;
  ballWidth = 35;
  speedX = 5;
  speedY = 5;
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
  start = "Press 1 for 1 player or 2 for 2 players"; 
  screen = true;
}// end reset



void draw() {
  background(0);


  if (screen == true) {
    startScreen();
  }

  if (key == '1') {
    players = 1;
    screen = false;
  }
  
  if (key == '2') {
    players = 2;
    screen = false;
  }

  if (screen == false) {
    /*
    background(0);
    //Empty Space**
    fill(255);
    rect(0, 0, 40, 1000);
    rect(860, 0, 40, 1000);
    */
    
    background(76, 62, 79);
    //Empty Space**
    strokeWeight(0);
    
    //Left wall
    noStroke();
    fill(238,174,202);
    rect(0, 0, 40, 140);
    fill(221,176,208);
    rect(0, 140, 40, 140);
    fill(195,180,217);
    rect(0, 280, 40, 140);
    fill(171,184,225);
    rect(0, 420, 40, 140);
    fill(148,187,233);
    rect(0, 560, 40, 140);
    
    //Right wall
    noStroke();
    fill(238,174,202);
    rect(860, 0, 40, 140);
    noStroke();
    fill(221,176,208);
    rect(860, 140, 40, 140);
    fill(195,180,217);
    rect(860, 280, 40, 140);
    fill(171,184,225);
    rect(860, 420, 40, 140);
    fill(148,187,233);
    rect(860, 560, 40, 140);

    //Paddles
    strokeWeight(0);
    fill(76, 62, 79);
    rect(player1X, player1Y, 40, 140);
    rect(player2X, player2Y, 40, 140);

    //Healthbars
    fill(bar1colour);
    rect(bar1X, bar1Y, player1health, 15);
    fill(bar2colour);
    rect(bar2X, bar2Y, player2health, 15);

    //Ball
    fill(143, 141, 222);
    ellipse(ballX, ballY, ballHeight, ballWidth);

    moveCircle();
    movePaddle();
    moveCollisions();
  }
}

void startScreen() {
  textSize(32);
  text(start, 150, 350, 10);
}


void moveCircle() {  
  ballX = ballX + speedX * 1;
  ballY = ballY + speedY * 1;

  if (ballX > width- ballWidth +20 || ballX < ballWidth / 2) {
    speedX *= -1;
  }
  if (ballY > height- ballHeight +20 || ballY < ballHeight / 2) {
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
  
  //Player 2 key movement
  if (players == 2) {
    if (upY == true) {
      player2Y = player2Y - 5;
    }
    if (downY == true) {
      player2Y = player2Y + 5;
    } 
  }
  
  //Bot movement
  if (players == 1) {
    if ((ballY <= player2Y + 70) && (speedX >= 0)) {
      player2Y = player2Y - 4;
    }
    if ((ballY > player2Y + 70) && (speedX >= 0)) {
      player2Y = player2Y + 4;
    } 
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
