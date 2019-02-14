/***********************************************/
/* This was just a pure physics lesson here.   */
/* I wanted to apply kinematics to my knowledge*/
/* of graphics programming, and this is what I */
/* came up with.                     -John Neis*/
/***********************************************/

short y = 50; // y position
short x = 95; // x position
short w = 10; // width of block
short h = 10; // height of block
short y_spd = 0; 
short x_spd = 0;
boolean OG = false; // The nature of whether the ball is on the ground, abbr. OnGrnd or OG

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
 frameRate(30); 
 size(600, 600);
 background(0);
 noStroke();
}

void draw() {
  background(0);
  
  fill(0, 255, 0);                     
  text("y = " + y, 10, 20);            //
  text("x = " + x, 10, 30);            // Just some debugging stuff
  text("y speed = " + y_spd, 10, 40);  // I thought was useful and 
  text("x speed = " + x_spd, 10, 50);  // fun to look at.
  text("On Ground: " + OG, 10, 60);    //
  
  //ground
  fill(0, 255, 0);
  rect(0, height - 10, width, 10);
  
  // block
  fill(155, 0, 155);
  rect(x, y, w, h);
  
  // Basically if the block is on the ground, I don't want to be changing its position vertically
  if(!OG) {
    y = calcYPos(y, y_spd, acc);
    y_spd = calcYSpd(y_spd, acc);
  }
  
  // The ground has friction, so the block needs to stop when on the ground, but not in air
  if(x_spd < 0 && OG) {
    x += x_spd++;
  } else if (x_spd > 0 && OG) {
    x += x_spd--;
  } else if (x_spd < 0 && !OG) {
    x += x_spd;
  } else if (x_spd > 0 && !OG) {
    x += x_spd;
  }
  
  // Here is where the block splats on the ground
  if(y > height - 20) {
    OG = true;
    y = (short)(height - 20);
    y_spd = 0;
  }
  
  // Horizontal border checking
  if(x < 0) {
    x = 0;
    x_spd = 0;
  }
  if(x > width - 10) {
    x = (short)(width - 10);
    x_spd = 0;
  }
}

void keyPressed() {
  if(key == CODED) {
    if(keyCode == UP && OG) {
      y_spd = 100;
      OG = false;
    }
    else if (keyCode == LEFT && OG) {
      x_spd = -10;
    }
    else if (keyCode == RIGHT && OG) {
      x_spd = 10;
    }
  }
}
