//Toomie's Robota Pysche midterm project: Babysitting Simulator. March 9th, 2022.
// Use the mouse to give the children candy when they misbehave so that they listen to you and begin to like you. Once their adoration levels reach a certain value,they will stop trying to cause mischief!
// changes made to fit the integrated ecosystem: no more mouse, the babysitter is a character like the children now

class toomiesEcosystem {

PImage pbabysitter, pmei, psam, bg, candy, mei1, mei2, mei3, sam1, sam2, sam3, bscandy, bsnormal, bshappy;
PFont font;
int r = 80;
float dsam, dmei;
Mei mei;
Sam sam;
Babysitter babysitter;

  // the classes tab:

// mei's class;
class Mei {
  float sizew= 130;
  float sizeh = 200;
  PVector location, velocity ;
  float adoration = 1;
  boolean timerstarted = false;
  float timer, G, mass;

  Mei(float posx, float posy, float vx, float vy) {
    location = new PVector(posx, posy);
    velocity = new PVector(vx, vy);
    pmei = mei1;
    mass = 20;
    G = 0.4;
  }  //constructor end

  //display function : just displays the image and changes its height if the image changes.
  void display() {
    image(pmei, location.x, location.y, sizew, sizeh);

    if (pmei == mei3) {
      sizeh = 250;
    } else {
      sizeh = 200;
    }
  }
  // move function : she gets a random velocity and moves around the yard. Also contains the timer stuff, so she gets angry every 4 seconds and the timer restarts. If her adoration is >= 10 her image switches.
  void move() {
    if (adoration >= 1 && adoration < 10) {
      velocity.x += random (-1, 1);
      velocity.y += random(-.1, .1);
      location.add(velocity); // she moves around

      if (pmei == mei1 && frameCount % 240 == 0) { // every 4 seconds
        pmei = mei2;

        if (timerstarted == false) {
          timer = millis();
          timerstarted = true;
        }

        if (millis() > timer + 7000) { // if you ignore her for 7 seconds you lose a point
          adoration -=1;
          timerstarted = false;
        }
      } else if (adoration >= 10) {
        pmei = mei3;
        // she is happy and behaved
      }
    }
  } // move function end

  // the edge function is just to make sure she doesnt fly offscreen, so i change her velocity to get her moving in the opposite direction
  void edge() {
    if (location.x >= width-50) {
      velocity.x =  random(-1, 0);
    } else if (location.x <= 50) {
      velocity.x = random(0, 1);
    } else if (location.y >= height-100) {
      velocity.y = random(-1, 0);
    } else if (location.y <=500) {
      velocity.y = random(0, 1) ;
    }
  }//edge function

  void happy() {
    if ( pmei == mei1) {
      mei.velocity.mult(0);
      mei.location.add(mei.velocity);
    } // she stops moving around for some time if shes happy

    if (pmei == mei1 && mei.adoration >= 10) {
      mei.velocity.mult(0);
      mei.location.add(mei.velocity);
      pmei = mei3;
    } // she's happy and likes you! she stops moving around now!
  }// happy function end
} // end of mei's class

class Sam {
  float sizew= 110;
  float sizeh = 200;
  PVector location, velocity, acceleration;
  float adoration = 1;
  float gravity = .5;
  boolean timerstarted = false;
  float timer, up, down, maxspeed;
  int ground = 500;
  float jumpspeed = 10;
  boolean jump = false;

  Sam(float posx, float posy, float vx, float vy) {
    location = new PVector(posx, posy);
    velocity = new PVector(vx, vy);
    acceleration = new PVector(0, 0);
    maxspeed = 5;
    psam = sam1;
  } //constructor end

  //display function : just displays the image and changes its height if the image changes.
  void display() {
    image(psam, location.x, location.y, sizew, sizeh);
    if (psam == sam3) {
      sizeh = 250;
    } else {
      sizeh = 200;
    }
  }
  // sam's move contains the timer and adoration code similar to mei's.
  void move() {
    if (adoration >= 1 && adoration < 10) {
      if (frameCount % 300 == 0) { // every 6 seconds
        psam = sam2;

        if (timerstarted == false) {
          timer = millis();
          timerstarted = true;
        }

        if (millis() > timer + 8000) { // if you ignore him for 8 seconds you lose a point
          adoration -=1;
          timerstarted = false;
        }
      }
    } else if (adoration >= 10) {
      psam = sam3;
      jump = false; // he is happy and behaved
    }
  } // move function end

  void update() {
    if (jump == false) {
      velocity.add(acceleration);
      velocity.limit(maxspeed);
      location.add(velocity);
      acceleration.mult(0);
    }
  }

  void edge() {
    if (location.x >= width-50) {
      velocity.x =  random(-1, 0);
    } else if (location.x <= 50) {
      velocity.x = random(0, 1);
    } else if (location.y >= height-100) {
      velocity.y = random(-1, 0);
    } else if (location.y <=500) {
      velocity.y = random(0, 1) ;
    }
  }//edge function end


  // the jump function : jump is true when sam is angry, and if sam is above ground, gravity is applied so he jumps back down,
  // he stops jumping if jump is false (when mouse is pressed) and if jump is true and he is on the ground he will jump up.
  void jump() {
    if (psam == sam2) {
      jump = true;
    }
    if (location.y < ground ) { //if its above ground apply gravity
      velocity.y += gravity;
      location.add(velocity);
    } else {
      velocity.y = 0;
      location.add(velocity);
    }

    if (jump == true && location.y >= ground ) { // if its on the ground and jump is true then it'll go up
      velocity.y = -jumpspeed;
      location.add(velocity);
    }
    if (jump == false && location.y >= ground ) {
      velocity.mult(0);
      location.add(velocity);
    }
  }//jump end
}// end of sam's class

class Babysitter {
  float sizew= 130;
  float sizeh = 200;
  PVector location, velocity, acceleration ;
  float maxforce, maxspeed; // for steering

  Babysitter(float posx, float posy, float vx, float vy) {
    location = new PVector(posx, posy);
    velocity = new PVector(vx, vy);
    acceleration = new PVector(0, 0);
    maxforce = .2;
    maxspeed = 5;
    pbabysitter = bsnormal;
  }  //constructor end

  //display function : just displays the image and changes its height if the image changes.
  void display() {
    image(pbabysitter, location.x, location.y, sizew, sizeh);
  }

  //same as mei's edge function
  void edge() {
    if (location.x >= width-50) {
      velocity.x =  random(-1, 0);
    } else if (location.x <= 50) {
      velocity.x = random(0, 1);
    } else if (location.y >= height-100) {
      velocity.y = random(-1, 0);
    } else if (location.y <=500) {
      velocity.y = random(0, 1) ;
    }
  }//edge function end

  void update() {
    velocity.add(acceleration);
    velocity.limit(maxspeed);
    location.add(velocity);
    acceleration.mult(0);
  }

  // Newton’s second law; we could divide by mass if we wanted.
  void applyForce(PVector force) {
    acceleration.add(force);
  } //this is called in the seek function

  void seek() {
    // desired velocity = target - location
    // steering force = desired velocity - current velocity
    if (dsam < dmei && psam == sam2 || dsam > dmei && pmei == mei1 && psam == sam2) {
      pbabysitter = bsnormal;
      PVector desired = PVector.sub(sam.location, location);
      desired.setMag(maxspeed);
      PVector steer = PVector.sub(desired, velocity);
      steer.limit(maxforce); //limiting the steering force
      applyForce(steer);
      pbabysitter = bscandy;
    } else if (dmei < dsam && pmei == mei2 || dmei > dsam && psam == sam1 && pmei == mei2) {
      pbabysitter = bsnormal;
      PVector desired = PVector.sub(mei.location, location);
      desired.setMag(maxspeed);
      PVector steer = PVector.sub(desired, velocity);
      steer.limit(maxforce); //limiting the steering force
      applyForce(steer);
      pbabysitter = bscandy;
    }
  }

  void candy() {
    // if the babysitter collides with the kids (giving them the candy) then they get happy & behaved - their timers reset and adoration increases by 1.
    if ( dsam < r && psam == sam2 ) {
      psam = sam1;
      sam.adoration +=1;
      sam.timerstarted =false;
      sam.jump = false;
      pbabysitter = bshappy;
    }
    if ( dmei < r && pmei == mei2 ) {
      pmei = mei1;
      mei.adoration += 1;
      mei.timerstarted = false;
      pbabysitter = bshappy;
    }
  }
} // end of babysitter's class

void setup() {
  mei1 = loadImage("mei1.png");
  mei2 = loadImage("mei2.png");
  mei3 = loadImage("mei3.png");
  sam1 = loadImage("sam1.png");
  sam2 = loadImage("sam2.png");
  sam3 = loadImage("sam3.png");
  bscandy = loadImage("bscandy.png");
  bsnormal = loadImage("bsnormal.png");
  bshappy = loadImage("bshappy.png");
  font  = createFont("/Users/fatimaaljneibi/Downloads/Fonts/Hubballi/Hubballi-Regular.ttf", 32);
  noStroke();
  smooth(4);
  imageMode(CENTER);
  textAlign(CENTER);

  // class objects: (people)
  sam= new Sam(random(100, width-100), random(500, height-100), random(2, -2), random(2, -2));
  mei = new Mei(random(100, width-100), random(500, height-100), random(2, -2), random(2, -2));
  babysitter = new Babysitter(random(100, width-100), random(500, height-100), random(2, -2), random(2, -2));
}

 void draw() {
  background(150);

  // calling class functions :
  sam.display();
  sam.move();
  sam.jump();
  sam.update();

  mei.display();
  mei.move();
  mei.edge();
  mei.happy();

  babysitter.display();
  babysitter.edge();
  babysitter.update();
  babysitter.seek();
  babysitter.candy();

  //collision detection calculation between babysitter & kids:
  dsam = PVector.dist(babysitter.location, sam.location);
  dmei = PVector.dist(babysitter.location, mei.location);

  // visual rep of their levels:
  pushStyle();
  textAlign(LEFT);
  textSize(20);
  text("sam's adoration levels:", 20, 50);
  text("mei's adoration levels:", 20, 90);
  fill(#6583ED);
  rect(2, 55, sam.adoration*20, 20);
  fill(#A449F0);
  rect(2, 95, mei.adoration*20, 20);
  popStyle();


  //might leave this out
  if (mei.adoration >= 10 && sam.adoration >=10) {
    textFont(font, 40);
    text("The kids like their babysitter know! Mission:Success!", width/2, height/2);
  }
} // draw end

  void mouseClicked() {
  }

  void keyPressed() {
  }
  
}// ecosystem end
