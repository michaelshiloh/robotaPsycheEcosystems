// Import all the files from all the ecosystems

// create objects for each ecosystem
MichaelsEcosystem system1 = new MichaelsEcosystem();
BriansEcosystem system2 = new BriansEcosystem();
ChinonyeremsEcosystem system3 = new ChinonyeremsEcosystem();
EhtishamsEcosystem system4 = new EhtishamsEcosystem();
AdinasEcosystem system5 = new AdinasEcosystem();

// for Adina's ecosystem
import java.io.*;
import java.util.*;


void setup(){
 
  fullScreen();
  system1.setup(); // call setup for each ecosystem
  system2.setup();
  system3.setup();
  system4.setup();
  system5.setup();
}


void draw() {
  background(200);
  system1.draw();// call draw for each ecosystem
  system2.draw();
  system3.draw();
  system4.draw();  
  system5.draw();
}

void mouseClicked() {
  system1.mouseClicked(); // call mouseClicked for each ecosystem
  system2.mouseClicked();
  system3.mouseClicked(); 
  system4.mouseClicked(); 
  system5.mouseClicked();
}

void keyPressed() {
}
