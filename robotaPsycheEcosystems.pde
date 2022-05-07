// Import all the files from all the ecosystems

// create objects for each ecosystem

// Indoors (top left)
EhtishamsEcosystem ehtisham = new EhtishamsEcosystem();
YiyangEcosystem yiyang = new YiyangEcosystem();
toomiesEcosystem toomie = new toomiesEcosystem();

// Sky (top right)
ChinonyeremsEcosystem chinonyerem = new ChinonyeremsEcosystem();
PhillipEcosystem phillip = new PhillipEcosystem();

// Outdoors (lower left)
AdinasEcosystem adina = new AdinasEcosystem();
SnehilsEcosystem snehil = new SnehilsEcosystem();
BadrsEcosystem badr = new BadrsEcosystem();
AbdulEcosystem abdul = new AbdulEcosystem();
GenieEcosystem genie = new GenieEcosystem();
SarahsEcosystem sarah = new SarahsEcosystem();


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
int textSize = 14;
color textFill = color(0);

void setup() {

  size (1850, 1000);
  //fullScreen();
  textAlign(LEFT, TOP);

  // All zones are the same size
  zoneHeight = height/2;
  zoneWidth = width/2;

  // There are four zones, corresponding to the four quadrants of the canvas
  // Parameters are the top left corner of each zone
  setupIndoors(0, 0); // Indoors (top left)
  setupSky(width/2, 0); // Do the sky zone (top right);
  setupOutdoors(0, height/2); // Outdoors outdoors (lower left)
  setupWater(width/2, height/2); // Water (lower right)
}

void draw() {
  drawIndoors(0, 0); // Indoors (top left)
  drawSky(width/2, 0); // Sky (top right)
  drawOutdoors(0, height/2); // Outdoors outdoors (lower left)
  drawWater(width/2, height/2); // Water (lower right)
}

void setupIndoors(int xloc, int yloc) {
  pushMatrix();
  translate(xloc, yloc);
  ehtisham.setup();
  toomie.setup();
  yiyang.setup();
  popMatrix();
}
void setupSky(int xloc, int yloc) {
  pushMatrix();
  translate(xloc, yloc);
  chinonyerem.setup();
  phillip.setup();
  popMatrix();
}
void setupOutdoors(int xloc, int yloc) {
  pushMatrix();
  translate(xloc, yloc);
  adina.setup();
  snehil.setup();
  badr.setup();
  abdul.setup();
  genie.setup();
  sarah.setup();
  popMatrix();
}
void setupWater(int xloc, int yloc) {
  pushMatrix();
  translate(xloc, yloc);
  brian.setup();
  jiayi.setup();
  yeji.setup();
  popMatrix();
}

void drawIndoors(int xloc, int yloc) {
  // Indoors (top left)
  pushMatrix();
  translate(xloc, yloc);

  fill(230);
  noStroke();
  rectMode(CORNER);
  rect(0, 0, zoneWidth, zoneHeight);

  ehtisham.draw(); // Ehtisham
  toomie.draw();
  yiyang.draw();

  fill(textFill);
  int yOffset = ehtisham.writeText(20, 150, textSize);
  //yOffset = toomie.writeText(20, yOffset+20, textSize);
  //yiyang.writeText(20, yOffset+20, textSize);

  popMatrix();
}
void drawSky(int xloc, int yloc) {

  pushMatrix();
  translate(xloc, yloc);

  fill(#91e3e3);
  noStroke();
  rectMode(CORNER);
  rect(0, 0, zoneWidth, zoneHeight);

  chinonyerem.draw();
  phillip.draw();

  fill(textFill);
  int yOffset = chinonyerem.writeText(20, 0, textSize);
  phillip.writeText(20, yOffset+20, textSize);

  popMatrix();
}
void drawOutdoors(int xloc, int yloc) {

  pushMatrix();
  translate(xloc, yloc);

  fill(0, 200, 0);
  noStroke();
  rectMode(CORNER);
  rect(0, 0, zoneWidth, zoneHeight);

  pushStyle();
  sarah.draw();
  popStyle();
  adina.draw();
  snehil.draw();
  badr.draw();
  abdul.draw();
  genie.draw();

  fill(textFill);
  int yOffset = adina.writeText(20, 0, textSize);
  yOffset = snehil.writeText(20, yOffset + 20, textSize);
  yOffset = badr.writeText(20, yOffset + 20, textSize);
  yOffset = abdul.writeText(20, yOffset + 20, textSize);
  genie.writeText(20, yOffset + 20, textSize);

  popMatrix();
}
void drawWater(int xloc, int yloc) {

  pushMatrix();
  translate(xloc, yloc);

  fill(00, 100, 100);
  noStroke();
  rectMode(CORNER);
  rect(0, 0, zoneWidth, zoneHeight);

  brian.draw();
  jiayi.draw();
  yeji.draw();

  fill(textFill);
  int yOffset = 0;//brian.writeText(20, 0, textSize);
  yOffset = jiayi.writeText(20, yOffset + 20, textSize);
  yeji.writeText(20, yOffset + 20, textSize);

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
