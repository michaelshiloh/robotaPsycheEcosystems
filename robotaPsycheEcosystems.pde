// Import all the files from all the ecosystems

// create objects for each ecosystem

// Indoors (top left)
EhtishamsEcosystem ehtisham = new EhtishamsEcosystem();
YiyangEcosystem yiyang = new YiyangEcosystem();
toomiesEcosystem toomie = new toomiesEcosystem();

// Sky (top right)
ChinonyeremsEcosystem chinonyerem = new ChinonyeremsEcosystem();
PhillipEcosystem phillip = new PhillipEcosystem();

// Land outdoors (lower left)
AdinasEcosystem adina = new AdinasEcosystem();
SnehilsEcosystem snehil = new SnehilsEcosystem();
BadrsEcosystem badr = new BadrsEcosystem();
AbdulEcosystem abdul = new AbdulEcosystem();
GenieEcosystem genie = new GenieEcosystem();

// Water (lower right)
BriansEcosystem brian = new BriansEcosystem();
JiayiEcosystem jiayi = new JiayiEcosystem();
YejisEcosystem yeji = new YejisEcosystem();

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
  chinonyerem.setup();
  phillip.setup();
  popMatrix();

  // Land outdoors (lower left)
  zoneHeight = height/2;
  zoneWidth = width/2;
  pushMatrix();
  translate(0, height/2);
  adina.setup();
  snehil.setup();
  badr.setup();
  abdul.setup();
  genie.setup();
  popMatrix();

  // Water (lower right)
  zoneHeight = height/2;
  zoneWidth = width/2;
  pushMatrix();
  translate(width/2, height/2);
  brian.setup();
  jiayi.setup();
  yeji.setup();
  popMatrix();

}


void draw() {

  doIndoors(); // Indoors (top left)
  doSky(); // Sky (top right)
  doOutdoors(); // Land outdoors (lower left)
  doWater(); // Water (lower right)
  
}

void doWater() {
  zoneHeight = height/2;
  zoneWidth = width/2;
  pushMatrix();
  translate(width/2, height/2);

  fill(00, 100, 100);
  noStroke();
  rect(0, 0, zoneWidth, zoneHeight);

  brian.draw();
  jiayi.draw();
  yeji.draw();
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

  adina.draw();
  snehil.draw();
  badr.draw();
  abdul.draw();
  genie.draw();
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

  chinonyerem.draw();
  phillip.draw();
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
  brian.mouseClicked();
  chinonyerem.mouseClicked();
  ehtisham.mouseClicked();
  adina.mouseClicked();
  snehil.mouseClicked();
  toomie.mouseClicked();
}

void keyPressed() {
  snehil.keyPressed();
}
