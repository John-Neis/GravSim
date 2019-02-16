/***********************************************/
/* This was just a pure physics lesson here.   */
/* I wanted to apply kinematics to my knowledge*/
/* of graphics programming, and this is what I */
/* came up with. Thar ya filthy animal-JohnNeis*/
/***********************************************/

// Github available: https://github.com/John-Neis/GravSim.git //

Player b = new Player();
int imgLR = 0;
boolean[] KEYS;

final short acc = -10; // Does the acceleration of earth ever change? No, so this is constant.

short calcYPos(short y, short spd, short acc) {
  short pos = 0;
  pos = (short)(y - spd - .5 * acc); // Remember kinematics from high school physics? I bastardized it.
  return pos;
}

short calcYSpd(short spd, short acc) {
  spd = (short)(spd + acc); // This is the derivative of position. Fun fact, the derivative of this is acceleration.
  return spd;
}

void setup() {
 KEYS = new boolean[255];
 b.sprite = loadImage("sprite.png");
 frameRate(30); 
 size(600, 600);
 background(0);
 noStroke();
}

void draw() {
  background(0);
  
  fill(0, 255, 0);                     
  text("y = " + b.y, 10, 20);            //
  text("x = " + b.x, 10, 30);            // Just some debugging stuff
  text("y speed = " + b.y_spd, 10, 40);  // I thought was useful and 
  text("x speed = " + b.x_spd, 10, 50);  // fun to look at.
  text("On Ground: " + b.OG, 10, 60);    //
  
  //ground
  fill(0, 255, 0);
  rect(0, height - 10, width, 10);
  
  // block
  fill(155, 0, 155);
  if(imgLR == 0)
    image(b.sprite, b.x, b.y);
  else {
    pushMatrix();
    scale(-1.0, 1.0);
    image(b.sprite, -b.x - b.w , b.y);
    popMatrix();
  }
  
  // Basically if the block is on the ground, I don't want to be changing its position vertically
  if(!b.OG) {
    b.y = calcYPos(b.y, b.y_spd, acc);
    b.y_spd = calcYSpd(b.y_spd, acc);
    b.x += b.x_spd;
  }
  
  // Here is where the block splats on the ground
  if(b.y > height - 10 - b.h) {
    b.OG = true;
    b.y = (short)(height - 10 - b.h);
    b.y_spd = 0;
  }
  
  // Horizontal border checking
  if(b.x < 0) {
    b.x = 0;
    b.x_spd = 0;
  }
  if(b.x > width - b.w) {
    b.x = (short)(width - b.w);
    b.x_spd = 0;
  }
  
  if(!KEYS[65] && !KEYS[68] && b.OG) {
    b.x_spd = 0;
  }
  else if(KEYS[68] && KEYS[65] && b.OG) {
    b.x_spd = 0;
  }
  else if(KEYS[65] && !KEYS[68] && b.OG && b.x > 0) {
    b.x_spd = -10;
    b.x += b.x_spd;
    imgLR = 1;
  } 
  else if(KEYS[68] && !KEYS[65] && b.OG && b.x < width - b.w) {
    b.x_spd = 10;
    b.x += b.x_spd;
    imgLR = 0;
  }
  
  if(KEYS[87] && b.OG) {
    b.y_spd = 75;
    b.OG = false;
  }
}

void keyPressed() {
  if(key != CODED && keyCode < 255)
    KEYS[keyCode] = true;
    System.out.println("\"" + keyCode + "\" has been pressed");
    System.out.println(KEYS[keyCode]);
}

void keyReleased() {
  if(key != CODED && keyCode < 255) {
    KEYS[keyCode] = false;
    System.out.println("\"" + keyCode + "\" has been released");
    System.out.println(KEYS[keyCode]);
  } 
}
