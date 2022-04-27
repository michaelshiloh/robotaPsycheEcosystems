// Import all the files from all the ecosystems

// create objects for each ecosystem

// Indoors (top left)
EhtishamsEcosystem ehtisham = new EhtishamsEcosystem();
YiyangEcosystem yiyang = new YiyangEcosystem();
toomiesEcosystem toomie = new toomiesEcosystem();

// Sky (top right)
ChinonyeremsEcosystem system3 = new ChinonyeremsEcosystem();
PhillipEcosystem system14 = new PhillipEcosystem();

// Land outdoors (lower left)
AdinasEcosystem system5 = new AdinasEcosystem();
SnehilsEcosystem system6 = new SnehilsEcosystem();
BadrsEcosystem system9 = new BadrsEcosystem();
AbdulEcosystem system10 = new AbdulEcosystem();
GenieEcosystem system12 = new GenieEcosystem();

// Water (lower right)
BriansEcosystem system2 = new BriansEcosystem();
JiayiEcosystem system8 = new JiayiEcosystem();
YejisEcosystem system11 = new YejisEcosystem();

//MichaelsEcosystem system1 = new MichaelsEcosystem();


// for some of the ecosystem
import java.io.*;
import java.util.*;

// Global variables
int	zoneHeight;
int	zoneWidth;


void setup() {

  fullScreen();

  // Indoors (top left)
  zoneHeight = height/2;
  zoneWidth = width/2;
  pushMatrix();
  translate(0, 0);
  ehtisham.setup();
  toomie.setup();
  yiyang.setup();
  popMatrix();

  // Do the sky zone (top right);
  zoneHeight = height/2;
  zoneWidth = width/2;
  pushMatrix();
  translate(width/2, 0);
  system3.setup();
  system14.setup();
  popMatrix();

  // Land outdoors (lower left)
  zoneHeight = height/2;
  zoneWidth = width/2;
  pushMatrix();
  translate(0, height/2);
  system5.setup();
  system6.setup();
  system9.setup();
  system10.setup();
  system12.setup();
  popMatrix();

  // Water (lower right)
  zoneHeight = height/2;
  zoneWidth = width/2;
  pushMatrix();
  translate(width/2, height/2);
  system2.setup();
  system8.setup();
  system11.setup();
  popMatrix();


  //system1.setup(); // call setup for each ecosystem
}


void draw() {

  doIndoors();\
  /*
  doSky();
  // Land outdoors (lower left)
  doOutdoors();
  doWater();
  */
}

void doWater() {
  // Water (lower right)
  zoneHeight = height/2;
  zoneWidth = width/2;
  pushMatrix();
  translate(width/2, height/2);

  fill(00, 100, 100);
  noStroke();
  rect(0, 0, zoneWidth, zoneHeight);

  system2.draw();
  system8.draw();
  system11.draw();
  popMatrix();
}
void doOutdoors() {
  zoneHeight = height/2;
  zoneWidth = width/2;
  pushMatrix();
  translate(0, height/2);

  fill(0, 200, 0);
  noStroke();
  rect(0, 0, zoneWidth, zoneHeight);

  system5.draw();
  system6.draw();
  system9.draw();
  system10.draw();
  system12.draw();
  popMatrix();
}
void doSky() {
  // Do the sky zone (top right);
  zoneHeight = height/2;
  zoneWidth = width/2;
  pushMatrix();
  translate(width/2, 0);

  fill(0, 0, 200);
  noStroke();
  rect(0, 0, zoneWidth, zoneHeight);

  system3.draw();
  system14.draw();
  popMatrix();
}

void doIndoors() {
  // Indoors (top left)
  zoneHeight = height/2;
  zoneWidth = width/2;

  pushMatrix();
  translate(0, 0);

  fill(230);
  noStroke();
  rect(0, 0, zoneWidth, zoneHeight);

  ehtisham.draw(); // Ehtisham
  toomie.draw();
  yiyang.draw();
  popMatrix();
}

void mouseClicked() {
  //system1.mouseClicked(); // call mouseClicked for each ecosystem
  system2.mouseClicked();
  system3.mouseClicked();
  ehtisham.mouseClicked();
  system5.mouseClicked();
  system6.mouseClicked();
  toomie.mouseClicked();
}

void keyPressed() {
  system6.keyPressed();
}
