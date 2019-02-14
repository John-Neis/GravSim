short y = 50;
short x = 95;
short w = 10;
short h = 10;
short y_spd = 0;
short x_spd = 0;
boolean OG = false;

final short acc = -10;

short calcYPos(short y, short spd, short acc) {
  short pos = 0;
  if(y >= 0) pos = (short)(y - spd - .5 * acc);
  
  return pos;
}

short calcYSpd(short spd, short acc) {
  spd = (short)(spd + acc);
  return spd;
}

void setup() {
 frameRate(30); 
 size(200, 1000);
 background(0);
 noStroke();
}

void draw() {
  background(0);
  fill(0, 255, 0);
  //ground
  rect(0, 990, 200, 10);
  
  fill(155, 0, 155);
  // block
  rect(x, y, w, h);
  
  if(!OG) {
    y = calcYPos(y, y_spd, acc);
    y_spd = calcYSpd(y_spd, acc);
  }
  
  if(y > 980) {
    OG = true;
    y = 980;
    y_spd = 0;
  }
  
  if(x_spd < 0) {
    x += x_spd++;
  } else if (x_spd > 0) {
    x += x_spd--;
  }
}

void keyPressed() {
  if(key == CODED) {
    if(keyCode == UP) {
      y_spd = 100;
      OG = false;
    }
    else if (keyCode == LEFT) {
      x_spd = -10;
    }
    else if (keyCode == RIGHT) {
      x_spd = 10;
    }
  }
}
