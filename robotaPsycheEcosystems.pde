// Import all the files from all the ecosystems

// create objects for each ecosystem
MichaelsEcosystem system1 = new MichaelsEcosystem();
BriansEcosystem system2 = new BriansEcosystem();
ChinonyeremsEcosystem system3 = new ChinonyeremsEcosystem();
EhtishamsEcosystem system4 = new EhtishamsEcosystem();
AdinasEcosystem system5 = new AdinasEcosystem();
SnehilsEcosystem system6 = new SnehilsEcosystem();
toomiesEcosystem system7 = new toomiesEcosystem();
JiayiEcosystem system8 = new JiayiEcosystem();
BadrsEcosystem system9 = new BadrsEcosystem();
AbdulEcosystem system10 = new AbdulEcosystem();
YejisEcosystem system11 = new YejisEcosystem();
GenieEcosystem system12 = new GenieEcosystem();
YiyangEcosystem system13 = new YiyangEcosystem();
PhillipEcosystem system14 = new PhillipEcosystem();


// for some of the ecosystem
import java.io.*;
import java.util.*;


void setup() {

  fullScreen();
  system1.setup(); // call setup for each ecosystem
  system2.setup();
  system3.setup();
  system4.setup();
  system5.setup();
  system6.setup();
  system7.setup();
  system8.setup();
  system9.setup();
  system10.setup();
  system11.setup();
  system12.setup();
  system13.setup();
  system14.setup();
}


void draw() {
  background(200);
  system1.draw();// call draw for each ecosystem
  system2.draw();
  system3.draw();
  system4.draw();
  system5.draw();
  system6.draw();
  system7.draw();
  system8.draw();
  system9.draw();
  system10.draw();
  system11.draw();
  system12.draw();
  system13.draw();
  system14.draw();
}

void mouseClicked() {
  system1.mouseClicked(); // call mouseClicked for each ecosystem
  system2.mouseClicked();
  system3.mouseClicked();
  system4.mouseClicked();
  system5.mouseClicked();
  system6.mouseClicked();
  system7.mouseClicked();
}

void keyPressed() {
  system6.keyPressed();
}
