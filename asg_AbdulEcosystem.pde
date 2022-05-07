/*///////////////////////////////////////////////////////////////////////////
Name: Abdul Samad Gomda
Class: Robota Psyche
Date: 9th March 2022
Description: This is an ecosystem midterm project for the class Robota Psyche.

1. There are three types of movers based on their sizes; the biggest (green) is the most aggresive for food,
followed by the purple, and the least aggresive is the yellow.
2. On the mouse click, a new  enemy is created, and the movers" + " are repelled by the enemy 
3. The smallest movers are, also attracted"+ "\n" +" to the largest movers, as if for protection
4. The medium movers consume, the small"+ "\n" +" movers when largest movers, as if for protection
*//////////////////////////////////////////////////////////////////////////////

class AbdulEcosystem{

// Movers, an Attractor, and a predator
ArrayList<Mover> movers = new ArrayList<Mover>();
ArrayList<Enemy> enemy = new ArrayList<Enemy>();

// The number of enemies per game
int ENEMY_COUNT = 5;

// the attractor object
Attractor a;

// game screen specification
int GAME_SCREEN = 3;

boolean firstIteration = false;

// classes 

class Attractor {
  float mass;
  PVector location;
  float G;

  Attractor() {
    location = new PVector(random(200, zoneWidth-200), random(200, zoneHeight-200));

    // mass and gravitational constant
    mass = 200;
    G = 0.45;
  }

  PVector attract(Mover m) {
    PVector force = PVector.sub(location, m.location);
    float distance = force.mag();

    // constrain the distance
    // so that the mover doesn’t spin out of control.
    distance = constrain(distance, 5.0, 25.0);

    force.normalize();
    float strength = (G * (250 - mass) * m.mass) / (distance * distance);
    force.mult(strength);
    return force;
  }

  void display() {
    stroke(10);
    fill(149, 235, 52);
    
    ellipse(location.x, location.y, mass*2, mass*2);
  }
}


// Mover class from Monday with modifications:
// attract() method allows vehicles to attract or repel each other
// myColor sets the vehicle color
class Mover {

  PVector location;
  PVector velocity;
  PVector acceleration;
  float mass;
  int aliveThreshold;
  float G = 0.01;
  int myColor;
  int moverKind;
  int foodCount = 0;
  float maxforce;
  float maxspeed;
  boolean displaying;

  Mover(float _x_, float _y_) {
    aliveThreshold = 50;
    displaying = true;
    location = new PVector(_x_, _y_);
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);
    myColor = round(random(1));
    moverKind = round(random(2));
    maxspeed = 30;
    maxforce = 10;

    // depending on the kind of mover the mass changes
    if (moverKind == 2)
      mass = 150;
    else if (moverKind ==1)
      mass = 100;
    else
      mass = 50;
  }

  // Newton’s second law.
  void applyForce(PVector force) {
    // Receive a force, divide by mass, and add to acceleration.
    PVector f = PVector.div(force, mass);
    acceleration.add(f);
  }

  PVector seek(PVector target) {
    PVector desired = PVector.sub(target, location);
    desired.normalize();
    desired.mult(maxspeed);
    PVector steer = PVector.sub(desired, velocity);
    steer.limit(maxforce);

    return (steer);
  }

  // The Mover now knows how to attract another Mover.
  PVector attract(Mover m) {

    PVector force = PVector.sub(location, m.location);
    float distance = force.mag();
    distance = constrain(distance, 5.0, 50.0);
    force.normalize();

    float strength = (G * mass * m.mass) / (distance * distance);
    force.mult(strength);

    // If the color is different then we will be repelled
    if (myColor != m.myColor) force.mult(-1);

    return force;
  }

  // method to repel the movers 
  PVector repel(Mover m) {
    PVector force = PVector.sub(location, m.location);
    float distance = force.mag();
    mass = constrain(mass, 100.0, 200.0);

    // constrain the distance
    // so that the mover doesn’t spin out of control.
    distance = constrain(distance, 5.0, 25.0);

    force.normalize();
    float strength = 0.75 * (-G * (mass) * (m.mass - (10))) / (distance * distance);
    force.mult(strength);
    return force;
  }

  // the arriving function
  PVector arrive(PVector target) {

    // First, calculate our desired velocity vector
    PVector desired = PVector.sub(target, location);

    // The distance is the magnitude of
    // the vector pointing from location to target.
    // Save this for later.
    float d = desired.mag();

    // As before, normalize the desired velocity vector
    desired.normalize();

    // Now apply the "arriving" logic

    // If we are closer than 100 pixels...
    if (d < 100) {

      // ...set the magnitude
      // according to how close we are.
      float m = map(d, 0, 100, 0, maxspeed);
      desired.mult(m);

      // Otherwise, proceed at full speed
    } else {
      desired.mult(maxspeed);
    }

    // The usual steering = desired - velocity
    PVector steer = PVector.sub(desired, velocity);

    // Limit to our maximum ability to steer
    steer.limit(maxforce);

    // and finally return it
    return(steer);
  }



  void update() {
    velocity.add(acceleration);
    location.add(velocity);
    acceleration.mult(0);
  }

  void display() {
    stroke(0);
    // Rotate the mover to point in the direction of travel
    // Translate to the center of the move
    pushMatrix();
    translate(location.x, location.y);
    rotate(velocity.heading());
    // pointing the triangle in the right direction
    // depending on the kind of mover the mass changes
    if (moverKind == 2) {
      fill(3, 89, 26);
      triangle(0, mass/10, 0, -mass/10, mass/4, 0);
      fill(225);
      ellipse(mass/8, 0, mass/12, mass/10);
    } else if (moverKind ==1) {
      fill (85, 4, 224);
      triangle(0, mass/10, 0, -mass/10, mass/4, 0);
      fill(225);
      ellipse(mass/8, 0, mass/12, mass/10);
    } else {
      fill(188, 224, 4);
      triangle(0, mass/10, 0, -mass/10, mass/4, 0);
      fill(225);
      ellipse(mass/8, 0, mass/12, mass/12);
    }

    popMatrix();
  }

  // making the movers appear on the opposite end of the screen

  void checkEdges() {
    if (location.x > zoneWidth) {
      location.x = zoneWidth;
      velocity.x *= -1; // full velocity, opposite direction
      //velocity.x *= 0.2; // lose a bit of energy in the bounce
    } else if (location.x < 0) {
      location.x = 0;
      velocity.x *= -1; // full velocity, opposite direction
      //velocity.x *= 0.2; // lose a bit of energy in the bounce
    }
    if (location.y >= zoneHeight) {
      location.y = zoneHeight;
      velocity.y *= -1; // full velocity, opposite direction
      //velocity.y *= 0.2; // lose a bit of energy in the bounce
    } else if (location.y <= 0) {
      location.y = 0;
      velocity.y *= -1; // full velocity, opposite direction
      //velocity.y *= 0.2; // lose a bit of energy in the bounce
    }
  }
}

class Enemy {
  float mass;
  PVector location;
  float G;

  Enemy() {
    location = new PVector(mouseX, mouseY);
    // mass and gravitational constant
    mass = 100;
    G = 0.24;
  }
  // method to repel the movers 
  PVector repel(Mover m) {
    PVector force = PVector.sub(location, m.location);
    float distance = force.mag();
    mass = constrain(mass, 100.0, 200.0);

    // constrain the distance
    // so that the mover doesn’t spin out of control.
    distance = constrain(distance, 5.0, 25.0);

    force.normalize();
    float strength = 0.75 * (-G * (mass) * (m.mass - (10))) / (distance * distance);
    force.mult(strength);
    return force;
  }

  void display() {
    stroke(10);
    fill(random(255), random(255), random(255));
    ellipse(location.x, location.y, mass/3, mass/2);
  }
}

void setup() {

  //initializing the movers randomly
  for (int i = 0; i < 75; i++) {
    // Each Mover is initialized randomly.
    movers.add(new Mover(
      random(zoneWidth-50), random(zoneHeight-50))); // initial location
  }

  a = new Attractor();// to attract movers
}

int writeText(int xloc, int yloc, int textSize) {
  //text
  fill(0);
  // displaying the on screen text instructions
  textSize(textSize);
  text("1. There are three types of movers based on their sizes; "+ "\n"+"the biggest (green) is the most aggresive for food," + "\n"+ "followed by the purple, and the" + "\n" +
    " least aggresive is the yellow." + 
    "\n" +"2. On the mouse click, a new  enemy"+ 
    "\n"+" is created, and the movers" + " are repelled by the enemy " + 
    "\n"+ "3. The smallest movers are, also attracted"+ "\n" +" to the largest movers, as if for protection"  + 
    "\n"+ "4. The medium movers consume, the small"+ "\n" +" movers when largest movers, as if for protection"  + "\n" 
    , xloc, yloc);
    return yloc;
  //text end
}
void draw() {
  //instructionsText();
  // displaying a screen based on current game state
  //if (GAME_SCREEN == 1) {
  //  instructionsText();
  //  // starting the home screen when the mouse is pressed
  //  text("START >>", 350, 700); 
  //  if ((mouseX>= 308 && mouseX<=396) && (mouseY>= 679 && mouseY<=705)) {
  //    noFill();
  //    stroke(255);
  //    rect(280, 670, 150, 40);

  //    if (mousePressed) {
  //      GAME_SCREEN = 2; // changing the screen to the home screen
  //      firstIteration = true; // to remove the mover created on click
  //    }
  //  }
  //} else if (GAME_SCREEN == 2) {
  //  if (firstIteration && enemy.size() > 0) {
  //    // removing any enemies created by accidental mouse clicks before the start of the game
  //    for (int i=0; i< enemy.size(); i++)
  //      enemy.remove(0);
  //    firstIteration = false;
  //  }

    //instructionsText();
    // For each mover
    for (int i = 0; i < movers.size(); i++) {
      // Apply the attraction force from the Attractor on the mover, and the predator
      // applying the repulsive force on the movers
      for (int e = 0; e < enemy.size(); e++) {
        PVector rForce = enemy.get(e).repel(movers.get(i));
        movers.get(i).applyForce(rForce);
      }



      // making the movers slow down towards the end of the screen
      PVector screenArrive = movers.get(i).arrive(new PVector(zoneWidth, zoneHeight));
      PVector screenEndArrive = movers.get(i).arrive(new PVector(0, 0));
      movers.get(i).applyForce(screenArrive);
      movers.get(i).applyForce(screenEndArrive);

      // making the movers arrive at the food source'
      PVector attractionForce = a.attract(movers.get(i));//.attract(a.location);
      movers.get(i).applyForce(attractionForce);
      PVector arriver = movers.get(i).arrive(a.location);
      movers.get(i).applyForce(arriver);

      // displaying the mover
      movers.get(i).update();
      movers.get(i).checkEdges();
      movers.get(i).display();

      // checking for collision between the food source and the mover
      if (dist(movers.get(i).location.x, movers.get(i).location.y, a.location.x, a.location.y) <= a.mass) {
        a.mass -= 0.1;

        // checking if the food is depleted and creating a new source
        if (a.mass <= 20) {
          //implementing the game of life rules 
          for (int j = 0; j < movers.size(); j++) {
            // the mover shouldn't count itself as another organism
            if (i!=j) {
              fill(0, 255, 255);
              // checking that the movers are close enough to reproduce

              //if (dist(movers.get(i).location.x, movers.get(i).location.y, movers.get(j).location.x, movers.get(j).location.y) == (movers.get(i).mass + movers.get(j).mass)) {

              //  movers.add(new Mover(
              //    ((movers.get(i).location.x + movers.get(j).location.x)/2), (movers.get(i).location.y +  movers.get(j).location.y)/2)); // initial location
              //}
            }

            // making the smaller movers attracted to the larger movers 
            if (movers.get(i).mass == 150 && movers.get(j).mass == 50) {
              PVector bigMoverForce = movers.get(i).attract(movers.get(j));
              movers.get(j).applyForce(bigMoverForce);
            }

            // making the medium movers attracted to the smaller movers 
            if (movers.get(i).mass == 100 && movers.get(j).mass == 50) {
              PVector mediumMoverForce = movers.get(i).attract(movers.get(j));
              movers.get(i).applyForce(mediumMoverForce);
            }

            // making the small movers repelled to the smaller movers 
            if (movers.get(i).mass == 100 && movers.get(j).mass == 50) {
              PVector rMoverForce = movers.get(i).repel(movers.get(j));
              movers.get(j).applyForce(rMoverForce);
            }

            // making the medium mover consume the small mover
            //if ((movers.get(i).mass == 100 && movers.get(j).mass == 50) && (dist(movers.get(i).location.x, movers.get(i).location.y, movers.get(j).location.x, movers.get(j).location.y) <= movers.get(i).mass/2)) {
            //  movers.remove(j);
            //  i--; // removing one mover from the global movers
            //}
          }

          a = new Attractor();// to attract movers
        }
      }

      // increasing food count when the mover gets in close proximity with the attractor
      if (dist(movers.get(i).location.x, movers.get(i).location.y, a.location.x, a.location.y) <= a.mass) {
        movers.get(i).foodCount += 1;
      }

      if (movers.get(i).foodCount >=700) {

        // changing the color if the mover has consumed enough food
        movers.get(i).myColor = 3;
      }

      if (movers.get(i).foodCount >=1700) {
        // mitosis
        // older generation dies and new ones form
        movers.get(i).myColor = round(random(1));
        movers.get(i).foodCount = 0;

        // replication
        movers.add(new Mover(
          movers.get(i).location.x+20, movers.get(i).location.y+20)); // initial location
      }

      // making the predator eat the mover
      // making the enemy eat the movers 
      for (int e = 0; e < enemy.size(); e++) {
        // checking the distance between the enemy and the mover
        if (dist(movers.get(i).location.x, movers.get(i).location.y, enemy.get(e).location.x, enemy.get(e).location.y) <= enemy.get(e).mass/4) {
          movers.remove(i);
          enemy.get(e).mass += 10;
          i--;
        }
      }
    }

    // displaying the attractor and predator 
    a.display();

    // displaying the enemy
    for (int i = 0; i < enemy.size(); i++) {
      enemy.get(i).display();
    }
  }



void drawText(String text) {
  fill(0, 255, 255);
  textSize(128);
  text(text, 40, 240);
}

void mouseClicked() {
  if (mouseX < zoneWidth && mouseY <zoneHeight){
    enemy.add(new Enemy());
  }
  
}
void keyPressed(){
}
}
