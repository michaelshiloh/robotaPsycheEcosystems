//Toomie's Robota Pysche midterm project: Babysitting Simulator. March 9th, 2022.
// Use the mouse to give the children candy when they misbehave so that they listen to you and begin to like you. Once their adoration levels reach a certain value,they will stop trying to cause mischief!

class toomiesEcosystem {

  //import ddf.minim.*;
  //Minim minim;
  //AudioPlayer bgm;

  PImage pmei, psam, bg, candy, mei1, mei2, mei3, sam1, sam2, sam3;
  //PFont font;
  int screenmode = 1;
  int r = 60;
  float dsam, dmei;
  Mei mei;
  Sam sam;

  // mei's class;

  class Mei {
    float sizew= 130;
    float sizeh = 200;
    PVector location, velocity ;
    float adoration = 1;
    boolean timerstarted = false;
    float timer;

    Mei(float posx, float posy, float vx, float vy) {
      location = new PVector(posx, posy);
      velocity = new PVector(vx, vy);
      pmei = mei1;
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

        if (frameCount % 240 == 0) { // every 4 seconds
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
  } // end of mei's class

  class Sam {
    float sizew= 110;
    float sizeh = 200;
    PVector location, velocity ;
    float adoration = 1;
    float gravity = .5;
    boolean timerstarted = false;
    float timer, up, down;
    int ground = 500;
    float jumpspeed = 10;
    boolean jump = false;

    Sam(float posx, float posy, float vx, float vy) {
      location = new PVector(posx, posy);
      velocity = new PVector(vx, vy);
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

  void setup() {
    //size(1200, 700);
    mei1 = loadImage("mei1.png");
    mei2 = loadImage("mei2.png");
    mei3 = loadImage("mei3.png");
    sam1 = loadImage("sam1.png");
    sam2 = loadImage("sam2.png");
    sam3 = loadImage("sam3.png");
    //bg = loadImage("bg.png");
    candy = loadImage("candy.png");
    //font  = createFont("/Users/fatimaaljneibi/Downloads/Fonts/Hubballi/Hubballi-Regular.ttf", 32);
    noStroke();
    smooth(4);

    imageMode(CENTER);
    textAlign(CENTER);

    sam= new Sam(random(100, width-100), 500, random(2, -2), random(2, -2));
    mei = new Mei(random(100, width-100), random(500, height-100), random(2, -2), random(2, -2));
  }

  void draw() {
    //start screen , background info
    if (screenmode == 1) {
      //background(#728DC6);
      // text(70);
      text("babysitting simulator!", width/2, height/2-100);
      //textFont( 30);
      text("-press the space key to start-", width/2, height/2);
      text("Your little sister Mei has invited her friend over to play", width/2, height/2+60);
      text("with her in your home's backyard, but it is your job to", width/2, height/2+100);
      text("babysit them and make sure they don't cause any chaos!", width/2, height/2+140);
      text("(give them candy to make them listen to you!)", width/2, height/2+180);

      // moving to next screen , resetting some values for the next screen
      if (keyPressed) {
        if (key == ' ' ) {
          screenmode = 2;
          sam.adoration = 1;
          mei.adoration = 1;
          pmei = mei1;
          psam = sam1;
          mei.timerstarted = false;
          sam.timerstarted = false;
        }
      }
    }  // title screen end
    if (screenmode == 2) {
      //background(bg);

      // calling class functions :

      sam.display();
      sam.move();
      sam.jump();

      mei.display();
      mei.move();
      mei.edge();

      //detect if the mouse is touching the kids:

      dsam = dist(mouseX, mouseY, sam.location.x, sam.location.y);
      dmei = dist(mouseX, mouseY, mei.location.x, mei.location.y);

      if (mousePressed) {
        if ( dsam < r && psam == sam2 ) {
          psam = sam1;
          sam.adoration +=1;
          sam.timerstarted =false;
          sam.jump = false;
        }
        if ( dmei < r && pmei == mei2 ) {
          pmei = mei1;
          mei.adoration += 1;
          mei.timerstarted = false;
        }
      }
      if ( pmei == mei1) {
        mei.velocity.mult(0);
        mei.location.add(mei.velocity);
      } // she stops moving around for some time

      if (pmei == mei1 && mei.adoration >= 10) {
        mei.velocity.mult(0);
        mei.location.add(mei.velocity);
        pmei = mei3;
      } // she's happy and likes you! she stops moving around now!

      // just for my reference:
      //println("sam:", sam.adoration);
      //println("mei:", mei.adoration);

      // code for going back to the main screen, + instructions:
      pushStyle();

      fill(255, 180);
      noStroke();
      rect(2, height-24, 350, 20, 20);
      rect(2, 6, 430, 20, 20);
      rect(10, 35, 200, 20, 20);
      rect(10, 75, 200, 20, 20);
      textAlign(LEFT);
      //textFont( 20);
      fill(0);
      text("press 'b' to go back to the main screen!", 10, height-8);
      text("click your mouse on the kids to give them candy!", 10, 20);

      // visual rep of their levels:
      text("sam's adoration levels:", 20, 50);
      text("mei's adoration levels:", 20, 90);
      fill(#6583ED);
      rect(2, 55, sam.adoration*20, 20);
      fill(#A449F0);
      rect(2, 95, mei.adoration*20, 20);

      popStyle();

      if (mei.adoration >= 10 && sam.adoration >=10) {
        //textFont( 40);
        text("The kids like you know! Mission:Success!", width/2, height/2);
      }

      if (keyPressed) {
        if (key == 'b' || key == 'B'  ) {
          screenmode = 1;
        }
      }

      // candy image on mouse
      image(candy, mouseX, mouseY, 150, 150);
    } // main screen end
  } // draw end

  void mouseClicked() {
  }

  void keyPressed() {
  }
  
}// ecosystem end