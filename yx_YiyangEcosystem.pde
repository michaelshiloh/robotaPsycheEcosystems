// Yiyang Xu
// Robota Psyche with Prof. Michael Shiloh
// March 28
// This project, as an endterm assignment, is to simulate an ecosystem in Processing, as part of a larger ecosystem. It incorporates the concepts we have learned from the book *Vehicles*, and is the continuation and complication of the previous ecosystem assignment.
// The ecosystem I tried to build consists of a group of insects. Each insect has a different initial velocity represented by the black & white gradient. They have two different sets of behavior in the dark mode and the day mode.


class YiyangEcosystem {
  int mode = 0;
  Mover[] movers = new Mover[15]; // insects
  ArrayList<LightSource> LightSources = new ArrayList<LightSource>(); // light sources

  int writeText(int xloc, int yloc, int textSize) { //description
    fill(0);
    text("Yiyang's ecosystem demonstrates insects in their idle mode, stimulated by each other.", xloc, yloc);
    // if (LightSources.size() >= 5) {
    //     text("You reached the maximum number of light sources permitted.", xloc+20, yloc+20);
    // } else {
    //     text("Click the mouse to place a light source.", xloc+20, yloc+20);
    // }
    return(0);
  }
  
  void setup() {
    //size(1200,800);
    // LightSources.add(new LightSource(zoneWidth/2, zoneHeight/2));

    for (int i = 0; i < movers.length; i++) {
      // Each Mover is initialized randomly.
      movers[i] = new Mover(random(zoneWidth), random(zoneHeight)); // initial location
    }
  }

  void draw() {
    // For each mover
    for (int i = 0; i < movers.length; i++) {
      // Apply the attraction force from the LightSources on this mover
      for (int j = 0; j < LightSources.size(); j++) {
        LightSources.get(j).display();
        PVector aForce = LightSources.get(j).seek(movers[i]);
        movers[i].applyForce(aForce);
      }

      // Now apply the force from all the other movers on this mover
      for (int j = 0; j < movers.length; j++) {
        // Don’t attract yourself!
        if (i != j) {
          PVector force = movers[j].attract(movers[i]);
          movers[i].applyForce(force);
        }
      }

      movers[i].update();
      movers[i].display();
      movers[i].checkEdges();
    }
  }

  void mouseClicked() {
    if (LightSources.size() < 5) LightSources.add(new LightSource(mouseX, mouseY));
  }

  void keyPressed() {
    if (key == 'n' || key == 'N') {
      if (mode == 0) mode = 1;
      else if (mode == 1) mode = 0;
    }
  }


  class LightSource {
    float mass;
    PVector location;
    // float G;
    float maxspeed;
    float maxforce;

    LightSource(int _x_, int _y_) {
      location = new PVector(_x_, _y_);
      mass = 30;
      // G = 0.4;
      maxspeed = 5;
    }

    // PVector attract(Mover m) {
    //   PVector force = PVector.sub(location, m.location);
    //   float distance = force.mag();
    //   // Remember, we need to constrain the distance
    //   // so that our vehicle doesn’t spin out of control.
    //   distance = constrain(distance, 5.0, 25.0);

    //   force.normalize();
    //   float strength = (G * mass * m.mass) / (distance * distance);
    //   force.mult(strength);
    //   return force;
    // }

    // Our seek steering force algorithm
    PVector seek(Mover m) {
      if (mode == 0) maxforce = 0.05;
      else if (mode == 1) maxforce = 0.005;
      PVector desired = PVector.sub(location, m.location);
      desired.normalize();
      desired.mult(maxspeed);
      PVector steer = PVector.sub(desired, m.velocity);
      steer.limit(maxforce);
      return (steer);
    }

    void display() {
      fill(255,255,153);
      ellipse(location.x, location.y, mass*2, mass*2);
    }
  }



  class Mover {
    PVector location;
    PVector velocity;
    PVector acceleration;
    float mass;
    float G = 0.4;
    float myColor;

    Mover(float _x_, float _y_) {
      mass = random(0.01, 2.55);
      location = new PVector(_x_, _y_);
      velocity = new PVector(0, 0);
      acceleration = new PVector(0, 0);
      myColor = mass * 100;
    }

    // Newton’s second law.
    void applyForce(PVector force) {
      // Receive a force, divide by mass, and add to acceleration.
      PVector f = PVector.div(force, mass);
      acceleration.add(f);
    }

    // The Mover now knows how to attract another Mover.
    PVector attract(Mover m) {
      PVector force = PVector.sub(location, m.location);
      float distance = force.mag();
      if (mode == 1) distance = constrain(distance, 5, 20.0);
      force.normalize();
      float strength = (G * mass * m.mass) / (distance * distance);
      if (mode == 1 || mass - m.mass >= 2) strength *= -0.5;
      force.mult(strength);
      force.limit(50);
      return force;
    }

    void update() {
      velocity.add(acceleration);
      location.add(velocity);
      acceleration.mult(0);
    }

    void display() {
      if (mode == 0) stroke(255, 255, 255);
      else stroke (0,0,0);
      fill(myColor);
      // Rotate the mover to point in the direction of travel
      // Translate to the center of the move
      pushMatrix();
      translate(location.x, location.y);
      rotate(velocity.heading());
      triangle(0, 10, 0, -10, 30, 0);
      popMatrix();
    }

    // With this code an object bounces when it hits the edges of a window.
    // Alternatively objects could vanish or reappear on the other side
    // or reappear at a random location or other ideas. Also instead of
    // bouncing at full-speed vehicles might lose speed. So many options!
    void checkEdges() {
      if (location.x > zoneWidth*.95) {
        velocity.x *= 0.7; // slow down near the edge
      } else if (location.x < zoneWidth*0.05) {
        velocity.x *= 0.7; // slow down near the edge
      }
      if (location.y > zoneHeight*0.95) {
        velocity.x *= 0.7; // slow down near the edge
      } else if (location.y < zoneHeight*0.05) {
        velocity.x *= 0.7; // slow down near the edge
      }

      if (location.x > zoneWidth) {
        location.x = zoneWidth-5;
        velocity.x *= -0.9; // bounce back with energy loss
      } else if (location.x < 0) {
        location.x = 5;
        velocity.x *= -0.9; // bounce back with energy loss
      }
      if (location.y > zoneHeight) {
        location.y = zoneHeight-5;
        velocity.y *= -0.9; // bounce back with energy loss
      } else if (location.y < 0) {
        location.y = 5;
        velocity.y *= -0.9; // bounce back with energy loss
      }
    }
  }
}
