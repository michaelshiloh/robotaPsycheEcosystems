//The ecosystme project: the fireflies ecosystem
//attempt to put all in one system
//Genie Hou
//2022/03/28


//This is a fireflies ecosystem 
//1. fireflies reproduce larvae (if condition met)
//2. when there are light then the fireflies fly outwards disappeared 
//3. when there are no light then the fireflies roam around 
//4. female and male meet 
//5. fireflies eat the worms
//6. human comes in and the ecosystem is disrupted  

class GenieEcosystem {
  //create the male and female movers list
  Mover[] movers = new Mover[25];
  FMover[] fmovers= new FMover[25];
  Worms[] worms= new Worms[25];

  //count the worms eaten
  int count=0;
  //count how many time they reproduced
  int reproduce=0;
  int larvae;

  //set up function
  void setup() {

    for (int i = 0; i < movers.length; i++) {
      movers[i] = new Mover();
    }
    for (int i = 0; i < fmovers.length; i++) {
      fmovers[i] = new FMover();
    }
    for (int i = 0; i < worms.length; i++) {
      worms[i] = new Worms();
    }
  }

  //draw function
  void draw() {
    if (mouseX>=40&&mouseX<=140&&mouseY>=60&&mouseY<=100&&mousePressed)
    {
      for (int i = 0; i < movers.length; i++) {
        //worms and the attract forces
        worms[i].update();
        worms[i].display();
        PVector force=worms[i].attract(movers[i]);
        PVector forcefemale=fmovers[i].attract(movers[i]);

        //apply attract force to the fireflies
        movers[i].applyForce(force);
        fmovers[i].applyForce(force);
        movers[i].applyForce(forcefemale);
        //female dosplaying
        fmovers[i].nolightupdate();
        fmovers[i].checkEdges();
        fmovers[i].nolight();
        //male displaying
        movers[i].nolightupdate();
        movers[i].checkEdges();
        movers[i].nolight();
      }

      //button
      //buttonclick();
    } else 
    {
      for (int i = 0; i < movers.length; i++) {
        //worms and the attract forces
        worms[i].update();
        worms[i].display();
        PVector force1=worms[i].attract(movers[i]);
        PVector forcefemale1=fmovers[i].attract(movers[i]);

        //female displaying 
        fmovers[i].update();
        fmovers[i].checkEdges();
        //male displaying 
        movers[i].update();
        movers[i].checkEdges();
        //apply attract force to the fireflies
        movers[i].applyForce(force1);
        fmovers[i].applyForce(force1);
        movers[i].applyForce(forcefemale1);
        //displaying
        fmovers[i].display();
        movers[i].display();
      }

      //buttonclick();
      mouseposition();
    }

    //if eat more than 5 worms than if the female and male meet they can reproduce new larvae
    for (int i=0; i<movers.length; i++)
    {
      if ((worms[i].location.x-5)<movers[i].location.x&&movers[i].location.x<(worms[i].location.x+5) && 
        (worms[i].location.y-5)<movers[i].location.y&&movers[i].location.y<(worms[i].location.y+5))
      {
        count+=1;
      } else if ((worms[i].location.x-5)<fmovers[i].location.x&&fmovers[i].location.x<(worms[i].location.x+5) && 
        (worms[i].location.y-5)<fmovers[i].location.y&&fmovers[i].location.y<(worms[i].location.y+5))
      {
        count+=1;
      }

      if ((fmovers[i].location.x-5)<movers[i].location.x&&movers[i].location.x<(fmovers[i].location.x+5) && 
        (fmovers[i].location.y-5)<movers[i].location.y&&movers[i].location.y<(fmovers[i].location.y+5))
      {
        reproduce+=1;
      }
    }


    //larvae being produced
    if (count>=10 && reproduce>=3) {
      larvae=reproduce/3;
      if (larvae<50)
      {
        for (int i=0; i<larvae; i++)
        {
          fill(20, 20, 50);
          ellipse(50+15*i, 300, 10, 10);
        }
      } else
      {
        fill(20, 20, 50);
        ellipse(50, 300, 10, 10);
        text("x", 80, 300);
        text(larvae, 90, 300);
      }
    }
  }

  int textWrite(int xloc, int yloc, int textSize)
  {
    text("25 male fireflies(yellow circles)", xloc, yloc);
    text("25 female fireflies(pink circles)", xloc, yloc+20);
    text("limited amount of worms as food(little grey squares)", xloc, yloc+40);
    text("larvae reproduced when conditions(food,encounters) met", xloc, yloc+60);
    text("Triangle(your mouse!) as human(disrupt the system)", xloc, yloc+80);
    return(80);
  }
  //a function to keep track of the humans(where the mouse is)
  void mouseposition()
  {
    fill(120);
    triangle(mouseX, mouseY, mouseX-20, mouseY-40, mouseX+20, mouseY-40);
  }
  //button to switch between night and day
  //when there is light the fireflies fly away to escape
  //when there is no light the fireflies fly inwards or raom around 
  /* void buttonclick()
   {
   //button
   fill(50);
   rect(40, 60, 100, 40);
   fill(255);
   textSize(24);
   text("night", 60, 90);
   
   //show how many larvae being reproduced and how many worms eaten
   fill(0);
   textSize(20);
   text("Worms eaten:", 650, 50);
   text(count, 700, 90);
   //show how many times the fireflies reproduced
   fill(0);
   textSize(20);
   text("Reproduction encounter:", 550, 200);
   text(reproduce, 700, 240);
   
   //show how many larvaes are creadted
   fill(0);
   textSize(20);
   text("larvae created:", 40, 240);
   text(larvae, 200, 240);
   
   fill(0);
   textSize(16);
   text("In this system, the circles are the fireflies, pink are female and yellow are male", 40, 400);
   text("The tiny squares are the worms which are the food of fireflies", 40, 430);
   text("The triangle on your mouse is the human", 40, 460);
   text("The blue circle generated are the larvaes", 40, 490);
   }*/

  //food for the fireflies
  class Worms {
    float mass;
    PVector location;
    PVector velocity;
    PVector acceleration;
    float topspeed;

    Worms() {
      location = new PVector(random(zoneWidth), random(zoneHeight));
      velocity = new PVector(0, 0);
      mass = 5;
    }

    //worms attracting the fireflies
    PVector attract(Mover m) {
      PVector force = PVector.sub(location, m.location);
      force.normalize();
      topspeed=3;
      force.limit(topspeed);
      return force;
    }

    //worms move around
    void update() {
      PVector dir = new PVector(random(-25, 25), random(-25, 25));
      dir.normalize();
      acceleration = dir;
      velocity.add(acceleration);
      //update topspeed limit
      topspeed=0.5;
      velocity.limit(topspeed);

      //the flies fly freeily when no light
      location.add(velocity);
    }
    //displaying the worms
    void display() {
      stroke(0);
      fill(175, 200);
      rect(location.x, location.y, mass, mass*2);
    }
  }
  //flying MALE fireflies class
  class Mover {

    PVector location;
    PVector velocity;
    PVector acceleration;
    float topspeed;

    Mover() {
      location = new PVector(random(zoneWidth), random(zoneHeight));
      velocity = new PVector(0, 0);
    }

    void update() {
      PVector mouse = new PVector(mouseX, mouseY);
      PVector dir = PVector.sub(mouse, location);
      dir.normalize();
      acceleration = dir;
      velocity.add(acceleration);
      //let the fireflies fly away a little slower
      topspeed = 2;
      velocity.limit(topspeed);

      //the flies fly away from the light
      location.sub(velocity);
      checkLoc();
    }

    //when no light the fireflies roam around 
    void nolightupdate() {

      PVector dir = new PVector(random(-50, 50), random(-100, 100));
      dir.normalize();
      acceleration = dir;
      velocity.add(acceleration);
      //update topspeed limit
      topspeed=2;
      velocity.limit(topspeed);

      //the flies fly freeily when no light
      location.add(velocity);
      checkLoc();
    }

    //fireflies under no light has no light
    void nolight() {
      stroke(0);
      fill(random(200, 255), 204, random(10));
      ellipse(location.x, location.y, 16, 16);
    }

    //add color to create the firefles flicker appearence 
    void display() {
      stroke(0);
      fill(random(200, 255), 204, random(10));
      ellipse(location.x, location.y, 16, 16);
    }

    //apply the force of attraction
    void applyForce(PVector force) {
      PVector f = PVector.div(force, 2);
      acceleration.add(f);
    }

    //steering towards other direction when closing
    void checkLoc() {
      topspeed=1;
      if (location.x>zoneWidth-50 || location.y>zoneHeight-50 )
      {
        PVector steer1=new PVector(random(100), random(100));
        steer1.normalize();
        steer1.limit(topspeed);
        location.sub(steer1);
      }
      if (location.x<20 || location.y<20)
      {
        PVector steer1=new PVector(random(100), random(100));
        steer1.normalize();
        steer1.limit(topspeed);
        location.add(steer1);
      }
    }

    //check the edge so the fireflies stay in frame
    void checkEdges() {
      if (location.x > zoneWidth-8) {
        location.x = 400;
      } else if (location.x < 8) {
        location.x = 100;
      }

      if (location.y > zoneHeight-8) {
        location.y = 200;
      } else if (location.y < 8) {
        location.y = 50;
      }
    }
  }
  //flying FEMALE fireflies class
  class FMover {

    PVector location;
    PVector velocity;
    PVector acceleration;
    float topspeed;

    FMover() {
      location = new PVector(random(width), random(height));
      velocity = new PVector(0, 0);
    }

    //female attracting the male
    PVector attract(Mover m) {
      PVector force = PVector.sub(location, m.location);
      force.normalize();
      topspeed=5;
      force.limit(topspeed);
      return force;
    }

    //update based on the mouse
    void update() {
      PVector mouse = new PVector(mouseX, mouseY);
      PVector dir = PVector.sub(mouse, location);

      dir.normalize();
      acceleration = dir;
      velocity.add(acceleration);
      //let the fireflies fly away a little slower
      topspeed = 2;
      velocity.limit(topspeed);

      //the flies fly away from the light
      location.sub(velocity);
      checkLoc();
    }

    //when no light the fireflies roam around 
    void nolightupdate() {
      PVector dir = new PVector(random(-50, 50), random(-100, 100));
      dir.normalize();
      acceleration = dir;
      velocity.add(acceleration);
      //update topspeed limit
      topspeed=2;
      velocity.limit(topspeed);

      //the flies fly freeily when no light
      location.add(velocity);
      checkLoc();
    }

    //apply the force of attraction
    void applyForce(PVector force) {
      PVector f = PVector.div(force, 2);
      acceleration.add(f);
    }

    //fireflies under no light has no light
    void nolight() {
      stroke(0);
      fill(random(150, 200), 132, 120);
      ellipse(location.x, location.y, 16, 16);
    }

    //add color to create the firefles flicker appearence 
    void display() {
      stroke(0);
      fill(random(150, 200), 132, 120);
      ellipse(location.x, location.y, 16, 16);
    }

    //steering towards other direction when closinge 
    void checkLoc() {
      topspeed=1;
      if (location.x>zoneWidth-50 || location.y>zoneHeight-50 )
      {
        PVector steer1=new PVector(random(100), random(100));
        steer1.normalize();
        steer1.limit(topspeed);
        location.sub(steer1);
      }
      if (location.x<20 || location.y<20)
      {
        PVector steer1=new PVector(random(100), random(100));
        steer1.normalize();
        steer1.limit(topspeed);
        location.add(steer1);
      }
    }
    //check the edge so the fireflies stay in frame
    void checkEdges() {
      if (location.x > zoneWidth-8) {
        location.x = 400;
      } else if (location.x < 8) {
        location.x = 100;
      }

      if (location.y > zoneHeight-8) {
        location.y = 200;
      } else if (location.y < 8) {
        location.y = 50;
      }
    }
  }

  void mouseClicked() {
  }
  void keyPressed() {
  }
}
