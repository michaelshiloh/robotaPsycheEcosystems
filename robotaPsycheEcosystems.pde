// Import all the files from all the ecosystems

// create objects for each ecosystem
MichaelsEcosystem system1 = new MichaelsEcosystem();
BriansEcosystem system2 = new BriansEcosystem();
ChinonyeremsEcosystem system3 = new ChinonyeremsEcosystem();
EhtishamsEcosystem system4 = new EhtishamsEcosystem();

void setup(){
 
  fullScreen();
  system1.setup(); // call setup for each ecosystem
  system2.setup();
  system3.setup();
  system4.setup();
}


void draw() {
  background(200);
  system1.draw();// call draw for each ecosystem
  system2.draw();
  system3.draw();// call draw for each ecosystem
  system4.draw();
}

void mouseClicked() {
  system1.mouseClicked(); // call mouseClicked for each ecosystem
  system2.mouseClicked();
  system3.mouseClicked(); 
  system4.mouseClicked();
}
