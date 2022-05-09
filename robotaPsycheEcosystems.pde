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

// Robota Psyche Ecosystem Global variables
int	zoneHeight;
int	zoneWidth;
int textSize = 14;
int RSEOffsetBetweenLines = 15;
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
  textSize(textSize);
  int xOffset = 20;
  int yOffset = 150;
  text("Ehtisham:", xOffset - 10, yOffset);
  yOffset+=RSEOffsetBetweenLines;
  yOffset = ehtisham.writeText(xOffset, yOffset, textSize);
  yOffset += RSEOffsetBetweenLines;
  text("Toomie:", xOffset - 10, yOffset);
  yOffset+=RSEOffsetBetweenLines;
  yOffset = toomie.writeText(RSEOffsetBetweenLines, yOffset, textSize);
  yOffset += RSEOffsetBetweenLines;
  yOffset+=RSEOffsetBetweenLines;
  text("Yiyang:", xOffset - 10, yOffset);
  yOffset+=RSEOffsetBetweenLines;
  yiyang.writeText(RSEOffsetBetweenLines, yOffset, textSize);

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
  textSize(textSize);
  int xOffset = 20;
  int yOffset = 0;
  text("Chinonyerem:", xOffset - 10, yOffset);
  yOffset+=RSEOffsetBetweenLines;
  yOffset = chinonyerem.writeText(xOffset, yOffset, textSize);
  yOffset += RSEOffsetBetweenLines;
  text("Phillip:", xOffset - 10, yOffset);
  yOffset+=RSEOffsetBetweenLines;
  phillip.writeText(xOffset, yOffset, textSize);

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
  textSize(textSize);
  int xOffset = 20;
  int yOffset = 0;
  yOffset+=RSEOffsetBetweenLines;
  text("Sarah:", xOffset - 10, yOffset);
  yOffset+=RSEOffsetBetweenLines;
  yOffset = sarah.writeText(20, yOffset, textSize);
  yOffset+=RSEOffsetBetweenLines;
  text("Adina:", xOffset - 10, yOffset);
  yOffset+=RSEOffsetBetweenLines;
  yOffset = adina.writeText(20, yOffset, textSize);
  yOffset+=RSEOffsetBetweenLines;
  fill(textFill);
  text("Snehil:", xOffset - 10, yOffset);
  yOffset+=RSEOffsetBetweenLines;
  yOffset = snehil.writeText(20, yOffset, textSize);
  yOffset+=RSEOffsetBetweenLines;
  text("Badr:", xOffset - 10, yOffset);
  yOffset+=RSEOffsetBetweenLines;
  yOffset = badr.writeText(20, yOffset, textSize);
  yOffset+=RSEOffsetBetweenLines;
  text("Abdul:", xOffset - 10, yOffset);
  yOffset+=RSEOffsetBetweenLines;
  yOffset = abdul.writeText(20, yOffset, textSize);
  yOffset+=RSEOffsetBetweenLines;
  yOffset = 0;
  xOffset = 530;
  text("Genie:", xOffset - 10, yOffset);
  yOffset+=RSEOffsetBetweenLines;
  genie.writeText(xOffset, yOffset, textSize);

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
  textSize(textSize);
  int xOffset = 20;
  fill(textFill);
  int yOffset = 0;
  yOffset+=RSEOffsetBetweenLines;
  text("Brian:", xOffset - 10, yOffset);
  yOffset+=RSEOffsetBetweenLines;
  yOffset = brian.writeText(20, 0, textSize);
  yOffset+=RSEOffsetBetweenLines;
  text("Jiayi:", xOffset - 10, yOffset);
  yOffset+=RSEOffsetBetweenLines;
  yOffset = jiayi.writeText(20, yOffset + 40, textSize);
  yOffset+=RSEOffsetBetweenLines;
  text("Yeji:", xOffset - 10, yOffset);
  yOffset+=RSEOffsetBetweenLines;
  yeji.writeText(20, yOffset + 40, textSize);

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
