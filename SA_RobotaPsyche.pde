class SnehilsEcosystem {
   // An arraylist of objects
  //These objects are two kinds of preys
  ArrayList<Mover> moversRed = new ArrayList<Mover>();
  ArrayList<Mover> moversBlue = new ArrayList<Mover>();

  //this is the food source 
  Attractor ellipseAttractor;
  //predator declared
  ArrayList<Predator> predators = new ArrayList<Predator>();
  boolean singleFrame = true;
  int time = millis();
  //to show how many preys were killed or died 
  int deaths = 0;
  void setup() {
    ellipseAttractor = new Attractor(new PVector(abs(random(width) - 260), abs(random(height) - 260)));
    predators.add(new Predator());
    predators.add(new Predator());
  
    for (int i = 1; i <= 20; i++) {
      // Initialize each object in the arraylist.
      moversRed.add(new Mover(ellipseAttractor, color(255, 0, 0), i*.05));
      moversBlue.add(new Mover(ellipseAttractor, color(0, 0, 255), i*.07));
    }

}

//to stop or start loop and analyze the ecosystem closely 
void keyPressed() {
  switch (key) {
  //p pauses the loop
  case 'p':
    noLoop();
    break;
  // r resumes the loop
  case 'r':
    singleFrame = false;
    loop();
    break;
  }
}

void mouseClicked() {
}

void draw() {
  
  ellipseAttractor.display();
  //this helps to display all the number of predators that are there in the arraylist
  for (Predator predator : predators) {
    predator.display();
  }
  
  //[full] Calling functions on all the objects in the array
  for (int i = 0; i < moversRed.size(); i++) {
    moversRed.get(i).update();
    moversRed.get(i).checkEdges();
    moversRed.get(i).display();
  }
  
  //[full] Calling functions on all the objects in the array
  for (int i = 0; i < moversBlue.size(); i++) {
    moversBlue.get(i).update();
    moversBlue.get(i).checkEdges();
    moversBlue.get(i).display();
  }
  
  //Here once the prey is eaten or died the lifespan gets 0 and thus has to be removed from the arraylist 
  //This method below helps to do that 
  //removed is set to false at the start
  boolean removed = false;
  //to access all the preys we have to run a nested loop for both red and blue preys' sizes to check which object in these arraylists have a lifespan of 0. 
  for (int i = 0; i < moversRed.size(); i++) {
    Mover r = moversRed.get(i);
    for (int j = 0; j < moversBlue.size(); j++) {
      Mover b = moversBlue.get(j);
      
      //this is the check for red prey eating the blue prey when its size is bigger than the blue one
      if (dist(r.location.x, r.location.y, b.location.x, b.location.y) < 15) {
        if (moversRed.get(i).radius > moversBlue.get(j).radius) {
          moversBlue.get(j).lifespan -= 10;
        } else {
          //this is the check for blue prey eating the red prey when its size is bigger than the red one
          moversRed.get(i).lifespan -= 10;
        }
        
        //So if the prey has a lifespan of less than 50 it fades away from the screen and is not visible
        //Therefore whenever the lifespan is less than 50 that prey is removed from the arraylist for both red and blue to increase efficiency
        if (moversBlue.get(j).lifespan < 50) {
          moversBlue.remove(j);
          removed = true;
        }
        if (moversRed.get(i).lifespan < 50) {
          moversRed.remove(i);
          removed = true;
        }
        //here is the calculation of how total number of deaths are being calculated
        if (removed) {
          deaths++;
          break;
        }
      }
    }
    //for pausing or resuming the loop
    if (singleFrame) {
      noLoop(); 
    }
    if (removed) {
      break;
    }
  }

  //this helps to reproduce preys in the ecosystem again so that they are not extinct
  if (moversRed.size() == 2) {
    moversRed.add(new Mover(ellipseAttractor, color(255, 0, 0), random(1, 5)*.05));
  }

  if (moversBlue.size() == 2) {
    moversBlue.add(new Mover(ellipseAttractor, color(0, 0, 255), random(1, 5)*.05));
  }

  //Below are various text methods to display important information about the ecosystem
  String b = "Blue prey: " + moversBlue.size();
  textSize(10);
  textAlign(LEFT);
  fill(0, 0, 255);
  text(b, 10, height - 10);


  String r = "Red prey: " + moversRed.size();
  textSize(10);
  textAlign(RIGHT);
  fill(255, 0, 0);
  text(r, width - 10, height - 10);

  String p = "Prey Deaths: " + deaths;
  textSize(10);
  textAlign(CENTER);
  fill(0, 0, 255);
  text(p, width/2, height - 10);
  
  String g = "Green Predators: 2" ;
  textSize(10);
  textAlign(RIGHT,TOP);
  fill(0, 255, 0);
  text(g, width-10, 10);
  
  String text = "Press 'r' to resume and 'p' to pause" ;
  textSize(10);
  textAlign(LEFT,TOP);
  fill(0, 0, 0);
  text(text, 10, 10);
}



class Predator {
  PVector location;
  //every time the predator is made or the program runs there is a different velocity 
  PVector velocity = new PVector(random(0.3, 0.7), random(0.3, 0.7));
  int size = 15;

  Predator() {
    //random location for the predator to start
    location = new PVector(random(width / 2, width / 2 + 100), random(height / 2, height/2 + 100));
  }

  void display() {
    fill(color(0, 255, 0));
    rectMode(CENTER);
    rect(location.x, location.y, size, size);

    //the method below is to calculate the nearest distance between the prey and the predator
    //Once the nearest distance is obtained the predator follows that prey
    Mover nearest = moversRed.get(0);
    float nearestDistance = width;
    for (int i = 0; i < moversRed.size(); i++) {
      float d = dist(location.x, location.y, moversRed.get(i).location.x, moversRed.get(i).location.y);
      if (d < nearestDistance) {
        nearest = moversRed.get(i);
        nearestDistance = d;
      }
    }

    for (int i = 0; i < moversBlue.size(); i++) {
      float d = dist(location.x, location.y, moversBlue.get(i).location.x, moversBlue.get(i).location.y);
      if (d < nearestDistance) {
        nearest = moversBlue.get(i);
        nearestDistance = d;
      }
    }

    float x = nearest.location.x - location.x;
    float y = nearest.location.y - location.y;

    PVector move = new PVector(x > 0? velocity.x: -velocity.x, y > 0? velocity.y: -velocity.y);
    location.add(move);
    checkEdges();
  }
  //to keep the predator in the canvas
  void checkEdges() {

    if (location.x > width) {
      location.x = width;
      velocity.x *= -1;
    } else if (location.x < 0) {
      location.x = 0;
      velocity.x *= -1;
    }

    if (location.y > height) {
      location.y = height;
      velocity.y *= -1;
    } else if (location.y < 0) {
      location.y = 0;
      velocity.y *= -1;
    }
  }
}
class DNA {
  //Different characteristics of different preys and within the same category
  PVector velocity;
  PVector acceleration;
  float topspeed;
  float hunger;
  float lifespan;

  DNA(float _hunger) {
    velocity = new PVector(0, 0);
    topspeed = random(3, 8);
    hunger = _hunger;
    lifespan = random(1000, 1500);
  }
}

class Attractor {
  int radius = 60;
  PVector location;
  Attractor(PVector loc) {
    location = loc;
  }

  void update(PVector currentLocation) {
    location = currentLocation;
  }

  void display() {
    //new food source is created using this method once the radius reaches or is less than 10
    
    if (radius <= 10) {
      ellipseAttractor = new Attractor(new PVector(abs(random(width)), abs(random(height) - 260)));
      for (int i = 0; i < moversRed.size(); i++) {
        //the preys are indicated of the source and are instructed to move towrds it 
        moversRed.get(i).attractor = ellipseAttractor;
      }

      for (int i = 0; i < moversBlue.size(); i++) {
        //the preys are indicated of the source and are instructed to move towrds it 
        moversBlue.get(i).attractor = ellipseAttractor;
      }
    }
    fill(0);
    ellipse(location.x, location.y, radius, radius);
  }
}
class Mover extends DNA {

  PVector location;
  float radius = 8.0;
  color moverColor;
  Attractor attractor;

  Mover(Attractor att, color mC, float _hunger) {
    super(_hunger);
    location = new PVector(random(width), random(height));
    moverColor = mC;
    attractor = att;
  }

  void update() {

    // <b><u>Our algorithm for calculating acceleration</b></u>:

    //[full] Find the vector pointing towards the mouse.
    PVector mouse = new PVector(attractor.location.x, attractor.location.y);
    PVector dir = PVector.sub(mouse, location);

    //[end]
    // Normalize.
    dir.normalize();
    // Scale.
    dir.mult(hunger);
    // Set to acceleration.
    acceleration = dir;

    //[full] Motion 101! Velocity changes by acceleration.  Location changes by velocity.
    velocity.add(acceleration);
    velocity.limit(topspeed);
    location.add(velocity);
    //distance calculated between the prey and the food 
    float d = dist(location.x, location.y, attractor.location.x, attractor.location.y);
    
    //if the distance between the prey and food is more than 50 then the prey loses its lifespan, else it gains lifespan
    if (d <= 50) {
      lifespan += 2.0;
    } else {
      lifespan -= 2.0;
    }
    
    //this is using the distance calculated earlier between the food and prey
    //this is to show how the food source keeps decreasing as these prey eat it slowly while hovering over it
    if (d<10) {
      attractor.radius -= 0.01;
      
      //the red mover increases in size as it consumes food
      for (int i = 0; i < moversRed.size(); i++) {
        Mover red = moversRed.get(i);
        red.radius += 0.02;
        
        //if the size of the prey is more than 40 the more its eats the earlier it dies due to obesity(big problem)
        if (red.radius > 40) {
          red.lifespan -= 10;
        }
        
        //limits the speed as the size increases
        if (red.topspeed > 1.5) {
          red.topspeed -= 0.009;
        }
      }
      //the blue mover increases in size as it consumes food
      for (int i = 0; i < moversBlue.size(); i++) {
        Mover blue = moversBlue.get(i);
        blue.radius += 0.02;
  
        //if the size of the prey is more than 40 the more its eats the earlier it dies due to obesity(big problem)
        if (blue.radius > 40) {
          blue.lifespan -= 10;
        }
        
        //limits the speed as the size increases
        if (blue.topspeed > 1.5) {
          blue.topspeed -= 0.009;
        }
      }
    }
    
   //this is the method where the predator eats the prey
   //The prey's lifespan is set to 0 as it dies and then it is removed in display/draw function above
    for (Predator predator : predators) {
      float dis = dist(location.x, location.y, predator.location.x, predator.location.y);

      if (dis < predator.size) {
        lifespan = 0;
      }
    }
  }

  // Display the Mover
  
  void display() {
    //lifespan determines how dark or light the prey looks depending on how much more it can live
    stroke(0, lifespan);
    fill(moverColor, lifespan);
    ellipse(location.x, location.y, radius, radius);
  }

  void checkEdges() {
    if (location.x > width) {
      location.x = width;
      velocity.x *= -1;
    } else if (location.x < 0) {
      location.x = 0;
      velocity.x *= -1;
    }

    if (location.y > height) {
      location.y = height;
      velocity.y *= -1;
    } else if (location.y < 0) {
      location.y = 0;
      velocity.y *= -1;
    }
  }
}
}
