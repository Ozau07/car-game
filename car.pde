
float car1X, car1Y;
float car1Angle = 0;
float car1Speed = 0;
int car1Laps = 0;
boolean car1CrossedLine = false;


float car2X, car2Y;
float car2Angle = 0;
float car2Speed = 0;
int car2Laps = 0;
boolean car2CrossedLine = false;

boolean w, s, a, d;
boolean up, down, left, right;

boolean gameOver = false;
String winner = "";

void setup() {
  size(800, 800);
 
  car1X = width / 2 - 50;
  car1Y = height / 2 - 220; 
  car2X = width / 2 - 80;
  car2Y = height / 2 - 180; 
}

void draw() {
  background(0);


  fill(100);
  ellipse(width/2, height/2, 500, 500);  
  fill(0);
  ellipse(width/2, height/2, 300, 300);  


  stroke(255);
  strokeWeight(4);
  line(width/2, height/2-150, width/2, height/2 -250);
  noStroke();

  if (!gameOver) {
   
    if (w) car1Speed += 0.1;
    if (s) car1Speed -= 0.1;
    car1Speed *= 0.98;
    if (a) car1Angle -= 3;
    if (d) car1Angle += 3;
    car1X += cos(radians(car1Angle)) * car1Speed;
    car1Y += sin(radians(car1Angle)) * car1Speed;
    float dist1 = dist(car1X, car1Y, width/2, height/2);
    if (dist1 > 250 || dist1 < 150) car1Speed = 0; // Keep car on track


    if (up) car2Speed += 0.1;
    if (down) car2Speed -= 0.1;
    car2Speed *= 0.98;
    if (left) car2Angle -= 3;
    if (right) car2Angle += 3;
    car2X += cos(radians(car2Angle)) * car2Speed;
    car2Y += sin(radians(car2Angle)) * car2Speed;
    float dist2 = dist(car2X, car2Y, width/2, height/2);
    if (dist2 > 250 || dist2 < 150) car2Speed = 0;

  
   
    if (car1X > width/2 -5  && car1X < width/2 +100) { // Near the white line X position
      if (car1Y <= height/2 +100 && !car1CrossedLine) {
        car1Laps++;
        car1CrossedLine = true;
      } else if (car1Y > height/2 ) {
        
        car1CrossedLine = false;
      }
    }

    // For Car 2:
    if (car2X > width/2 - 5 && car2X < width/2 + 100) {
      if (car2Y <= height/2 +100 && !car2CrossedLine) {
        car2Laps++;
        car2CrossedLine = true;
      } else if (car2Y > height/2 ) {
        car2CrossedLine = false;
      }
    }


    if (car1Laps >= 3) {
      winner = "Car 1 Wins!";
      gameOver = true;
    } else if (car2Laps >= 3) {
      winner = "Car 2 Wins!";
      gameOver = true;
    }


    float collisionDist = dist(car1X, car1Y, car2X, car2Y);
    if (collisionDist < 25) {
      float angleBetween = atan2(car2Y - car1Y, car2X - car1X);
      car1Speed = -0.5;
      car2Speed = -0.5;
      car1X += cos(angleBetween + PI) * 5;
      car1Y += sin(angleBetween + PI) * 5;
      car2X += cos(angleBetween) * 5;
      car2Y += sin(angleBetween) * 5;
    }
  }

 
  drawCar(car1X, car1Y, car1Angle, color(255, 0, 0));
  drawCar(car2X, car2Y, car2Angle, color(0, 0, 255));


  fill(255);
  textSize(20);
  text("Car 1 Laps: " + car1Laps, 20, 30);
  text("Car 2 Laps: " + car2Laps, 20, 60);

  if (gameOver) {
    textSize(32);
    text(winner, width/2 - 100, height/2);
  }
}

void drawCar(float x, float y, float angle, color c) {
  pushMatrix();
  translate(x, y);
  rotate(radians(angle));
  fill(c);
  rectMode(CENTER);
  rect(0, 0, 40, 20);
  popMatrix();
}

void keyPressed() {
  if (key == 'w' || key == 'W') w = true;
  if (key == 's' || key == 'S') s = true;
  if (key == 'a' || key == 'A') a = true;
  if (key == 'd' || key == 'D') d = true;

  if (keyCode == UP) up = true;
  if (keyCode == DOWN) down = true;
  if (keyCode == LEFT) left = true;
  if (keyCode == RIGHT) right = true;
}

void keyReleased() {
  if (key == 'w' || key == 'W') w = false;
  if (key == 's' || key == 'S') s = false;
  if (key == 'a' || key == 'A') a = false;
  if (key == 'd' || key == 'D') d = false;

  if (keyCode == UP) up = false;
  if (keyCode == DOWN) down = false;
  if (keyCode == LEFT) left = false;
  if (keyCode == RIGHT) right = false;
}
