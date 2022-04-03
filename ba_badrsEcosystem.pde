class BadrsEcosystem {

  ArrayList<Creature> creatures = new ArrayList<Creature>(); // ArrayList to store all the creatures
  ArrayList<Food> foodlist = new ArrayList<Food>(); // ArrayList to store the food
  //Slider slider1; // Initialize the sliders
  //Slider slider2; // Initialize the sliders
  //Slider slider3; // Initialize the sliders
  int temperature = 24; // optimal/default temperature
  boolean dragged = false; // flag for sliders
  int size = 50; // default amount of food

  void setup() {
    //size(960, 480);
    // Create the creatures and add them to the ArrayList "creatures"
    for (int i = 0; i < 30; i++) {
      float x = random(width);
      float y = random(height);
      creatures.add(new Creature(x, y));
    }
    // Create the food and add it to the ArrayList "foodlist"
    for (int j = 0; j < 50; j++) {
      foodlist.add(new Food());
    }
    //// create the sliders
    //slider1 = new Slider(40);
    //slider2 = new Slider(90);
    //slider3 = new Slider(140);
    //// set the sliders to the default values
    //slider1.reset(892);
    //slider2.reset(910);
    //slider3.reset(920);
  }

  void draw() {
    //background(50);
    //fill(255);
    // Draw all geometry with smooth edges
    smooth();
    // As the food is being eaten, add more food
    if (random(1) < 0.5 && foodlist.size()<size) {
      foodlist.add(new Food());
    }
    // Display the food
    for (int i = 0; i < foodlist.size(); i++) {
      foodlist.get(i).display();
    }
    int cnt = 0;
    int cnt2 = 0;
    // Display the creatures
    for (int i = creatures.size() - 1; i >= 0; i--) {
      Creature c = creatures.get(i);
      // Set the boundaries (edges)
      c.boundaries();
      // Set the creatures behaviours towards food
      c.behaviors(foodlist);
      // Update location, speed, acceleration
      c.update();
      // Display the creatures
      c.display();
      // Count how many healthy and unhealthy creatures there are
      if (c.dna.health<5) {
        cnt2++;
      } else {
        cnt++;
      }
      // Clone the creatures
      Creature newCreature = c.clone();
      if (newCreature != null) {
        creatures.add(newCreature);
      }
      // Set the max speed depending on the temperature
      if (temperature <= 16) {
        c.dna.maxspeed = 2.5;
      } else if (temperature > 16 && temperature < 28) {
        c.dna.maxspeed = 9 - c.dna.size;
      } else if (temperature >= 28) {
        c.dna.maxspeed = 3.5;
      }
      // If creature is dead, remove it
      if (c.dead()) {
        creatures.remove(i);
      }
    }
    // Display the counters
    //fill(255);
    //textSize(14);
    //text("Alive: " + creatures.size(), 10, 20);
    //text("Food: " + foodlist.size(), 10, 40);
    //text("Healthy: " + cnt, 10, 60);
    //text("Unhealthy: " + cnt2, 10, 80);
    //text("Temperature: " + temperature + " °C", width/2-55, 20);
    //noStroke();
    //// Display the sliders
    //rect(width-100, 0, 100, height/2-40);
    //fill(0);
    //rectMode (CENTER);
    //slider1.display(2, 0, 100);
    //slider2.display(3, 0, 100);
    //slider3.display(2, 15, 32);
    //rectMode(CORNER);
    //text("Creatures", width-76, 20);
    //text("Food", width-65, 70);
    //text("Temperature", width-85, 120);
    //// Reset button
    //fill(50);
    //rect(width-70, 170, 40, 20, 5);
    //fill(255);
    //text("Reset ", width-66, 183);
    //rect(0, height-65, width/3+60, 65);
    //fill(0);
    //textSize(10);
    //text("- Green means that the creature is healthy, red means it is unhealthy.", 10, height-50);
    //text("- Eating food decreases hunger, and increases energy. ", 10, height-40);
    //text("- With time and movement, hunger increases.", 10, height-30);
    //text("- If the energy is too low or the creature hits the edges, its health decreases.", 10, height-20);
    //text("- The creature dies when its health is too low, and reproduces when its energy is high.", 10, height-10);
    //// Set the number of creatures, amount of food, temperature depending on the sliders
    //if (dragged) {
    //  dragged=false;
    //  // Add more creatures
    //  if (slider1.sliderInt > creatures.size()) {
    //    int tmp = creatures.size();
    //    for (int i = 0; i < slider1.sliderInt-tmp; i++) {
    //      float x = random(width);
    //      float y = random(height);
    //      creatures.add(new Creature(x, y));
    //    }
    //  }
    //  // Remove some creatures (randomly)
    //  else if (slider1.sliderInt < creatures.size()) {
    //    int tmp2 = creatures.size();
    //    for (int i = 0; i < tmp2-slider1.sliderInt; i++) {
    //      creatures.remove(creatures.get((int)random(creatures.size())));
    //    }
    //  }
    //  // Add more food
    //  if (slider2.sliderInt > foodlist.size()) {
    //    int tmp = foodlist.size();
    //    for (int i = 0; i < slider2.sliderInt-tmp; i++) {
    //      foodlist.add(new Food());
    //    }
    //  }
    //  // Remove some food (randomly)
    //  else if (slider2.sliderInt < foodlist.size()) {
    //    int tmp2 = foodlist.size();
    //    for (int i = 0; i < tmp2-slider2.sliderInt; i++) {
    //      foodlist.remove(foodlist.get((int)random(foodlist.size())));
    //    }
    //  }
    //  // Set the amount of food
    //  size = slider2.sliderInt;
    //}
  }

  //void mouseDragged() {
  //  // Drag the sliders
  //  slider1.drag();
  //  slider2.drag();
  //  slider3.drag();
  //  // Set the flag to true
  //  dragged=true;
  //  // Change the temperature
  //  temperature = slider3.sliderInt;
  //}
  void keyPressed() {
  }
  void mouseClicked() {
    // When user clicks on reset
    //if (mouseX>width-70 && mouseX<width-30 && mouseY>170 && mouseY<190) {
    //  temperature = 24;
    //  size = 50;
    //  // Restore the default amount of food
    //  // Add more food
    //  if (50 > foodlist.size()) {
    //    int tmp = foodlist.size();
    //    for (int i = 0; i < 50-tmp; i++) {
    //      foodlist.add(new Food());
    //    }
    //  }
    //  // Remove some food (randomly)
    //  else if (50 < foodlist.size()) {
    //    int tmp2 = foodlist.size();
    //    for (int i = 0; i < tmp2-50; i++) {
    //      foodlist.remove(foodlist.get((int)random(foodlist.size())));
    //    }
    //  }
    //  // Restore the default number of creatures
    //  // Add more creatures
    //  if (30 > creatures.size()) {
    //    int tmp = creatures.size();
    //    for (int i = 0; i < 30-tmp; i++) {
    //      float x = random(width);
    //      float y = random(height);
    //      creatures.add(new Creature(x, y));
    //    }
    //  }
    //  // Remove some creatures (randomly)
    //  else if (30 < creatures.size()) {
    //    int tmp2 = creatures.size();
    //    for (int i = 0; i < tmp2-30; i++) {
    //      creatures.remove(creatures.get((int)random(creatures.size())));
    //    }
    //  }
    //  // Reset the sliders
    //  slider1.reset(892);
    //  slider2.reset(910);
    //  slider3.reset(920);
    //}
    // Apply the wind force, if user clicks somewhere on the screen
    //if (mouseX<width-100 || mouseX>width-100 && mouseY>height/2-40) {
    PVector wind;
    if (mouseX<=width/2) {
      wind = new PVector(60, 0);
    } else {
      wind = new PVector(-60, 0);
    }
    for (int i = 0; i < creatures.size(); i++) {
      creatures.get(i).applyForce(wind);
    }
    //}
  }

  // DNA class for creatures
  class DNA {
    PVector acceleration; // Creature's acceleration
    PVector velocity; // Creature's velocity
    float size = random(3, 6); // Creature's size
    float maxspeed = 9 - size; // Creature's maxspeed (depending on size)
    float maxforce = random(0.2, 1); // Creature's maxforce
    float health = map(size, 3, 6, 10, 13); // Creature's health (depending on size)
    float mutation = random(0.001, 0.01); // Creature's chance of mutation
    float hunger = 0; // Creature's hunger counter
    float hungerthreshold = map(size, 3, 6, 6, 9); // Creature's hunger threshold (depending on size)
    float energy = random(3, 6); // Creature's energy
    float injuries = 0; // Creature's injuries counter
    boolean lowspeed = false; // flag for lowspeed
  };

  // Creature class
  class Creature {
    PVector position;
    float lst[];
    DNA dna = new DNA();
    float initHealth = dna.health;

    // Constructor
    Creature(float x, float y) {
      this(x, y, null);
    }

    // Constructor 2
    Creature(float x, float y, float lst_[]) {
      dna.acceleration = new PVector(0, 0);
      dna.velocity = new PVector(0, -2);
      position = new PVector(x, y);

      lst = new float[2];
      if (lst_ == null) {
        // Food weight
        lst[0] = random(-2, 2);
        // Food perception
        lst[1] = random(90, 100);
      } else {
        // Mutation
        lst[0] = lst_[0];
        // Affects the food weight
        if (random(1) < dna.mutation) {
          lst[0] += random(-0.1, 0.1);
        }
        lst[1] = lst_[1];
        // Affects the food perception
        if (random(1) < dna.mutation) {
          lst[1] += random(-10, 10);
        }
      }
    }

    // Update location
    void update() {
      // Creature's health is affected by injuries
      dna.health = initHealth - dna.injuries;
      // The hunger increases with time and movement
      dna.hunger += 0.01;
      // If hunger is higher than the creature's hunger threshold, the energy decreases
      if (dna.hunger > dna.hungerthreshold) {
        dna.energy -= 0.02;
      }
      // If energy is below 0, the injuries increase
      if (dna.energy <= 0) {
        dna.injuries +=  0.02;
      }
      // If the health is too low, the maxspeed decreases to 3
      if (dna.health < 3 && !dna.lowspeed) {
        dna.lowspeed = true;
        dna.maxspeed = 3;
      }
      // Update velocity
      dna.velocity.add(dna.acceleration);
      // Limit speed
      dna.velocity.limit(dna.maxspeed);
      position.add(dna.velocity);
      // Reset acceleration at each cycle
      dna.acceleration.mult(0);
    }
    // Apply the force
    void applyForce(PVector force) {
      dna.acceleration.add(force);
    }
    // Behavior of creature towards food (steering)
    void behaviors(ArrayList<Food> good) {
      PVector steerG = eat(good, 2, lst[1]);
      steerG.mult(lst[0]);
      applyForce(steerG);
    }
    // Clone the creatures if energy is higher than 5
    Creature clone() {
      if (random(1) < 0.001 && dna.energy > 5) {
        return new Creature(position.x, position.y, lst);
      } else {
        return null;
      }
    }
    // Eating method
    PVector eat(ArrayList<Food> list, float nutrition, float perception) {
      float record = Float.POSITIVE_INFINITY;
      PVector closest = null;
      for (int i = list.size() - 1; i >= 0; i--) {
        float d = position.dist(list.get(i).location);

        if (d < dna.maxspeed) {
          // hunger decreases
          dna.hunger -= nutrition;
          // energy increases
          dna.energy += nutrition/10;
          // remove food
          list.remove(i);
        } else {
          if (d < record && d < perception) {
            record = d;
            closest = list.get(i).location;
          }
        }
      }
      // creature eats
      if (closest != null) {
        return seek(closest);
      }
      return new PVector(0, 0);
    }

    // calculate a steering force towards food
    PVector seek(PVector target) {
      // A vector pointing from the location to the food
      PVector desired = PVector.sub(target, position);

      // Scale to maximum speed
      desired.setMag(dna.maxspeed);

      // Steering force
      PVector steer = PVector.sub(desired, dna.velocity);
      // Limit to maximum steering force
      steer.limit(dna.maxforce);
      return steer;
    }

    // Creature dies if healt is less than 0
    boolean dead() {
      return dna.health <= 0;
    }

    void display() {
      // Triangle faces the direction of velocity
      float angle = dna.velocity.heading() + PI / 2;
      pushMatrix();
      translate(position.x, position.y);
      rotate(angle);
      color gr = color(0, 255, 0); // If healthy
      color rd = color(255, 0, 0); // If unhealthy
      // Map the colors to the health
      float amt = map(dna.health, 0, initHealth, 0, 1);
      color col = lerpColor(rd, gr, amt);
      fill(col);
      stroke(col);
      strokeWeight(1);
      // Draw the triangle
      beginShape();
      vertex(0, -dna.size * 2);
      vertex(-dna.size, dna.size * 2);
      vertex(dna.size, dna.size * 2);
      endShape(CLOSE);
      popMatrix();
    }


    void boundaries() {
      float d = 25;
      PVector desired = null;
      // If creature hits the right or left border
      if (position.x < d) {
        desired = new PVector(dna.maxspeed, dna.velocity.y);
      } else if (position.x > width - d) {
        desired = new PVector(-dna.maxspeed, dna.velocity.y);
      }
      // If creature hits the top or bottom border
      if (position.y < d) {
        desired = new PVector(dna.velocity.x, dna.maxspeed);
      } else if (position.y > height - d) {
        desired = new PVector(dna.velocity.x, -dna.maxspeed);
      }

      if (desired != null) {
        // Add injuries if creatures hits the borders
        dna.injuries += 0.25;
        // turn
        desired.normalize();
        desired.mult(dna.maxspeed);
        PVector steer = PVector.sub(desired, dna.velocity);
        steer.limit(dna.maxforce);
        applyForce(steer);
      }
    }
  };

  // Food class
  class Food {
    float x;
    float y;
    PVector location;

    // Constructor
    Food() {
      x = random(25, width-25);
      y = random(25, height-25);
      location = new PVector(x, y);
    }

    // Draw the food
    void display() {
      fill(0, 255, 0);
      noStroke();
      ellipse(location.x, location.y, 4, 4);
    }
  };
}
