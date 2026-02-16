color background = #161616;

Astronave nave;
float velocitaNave;
boolean ruotaSx = false;
boolean ruotaDx = false;
boolean accelera = false;

float prevTime;

void setup() {
  size(800, 600);
  
  // Astronave
  float altezza = 100;
  float larghezza = 60;
  nave = new Astronave(width/2, height/2, larghezza, altezza);
  
  prevTime = millis() / 1000.0;
}

void draw() {
  float now = millis() / 1000.0;
  float dt = now - prevTime;
  prevTime = now;
  
  fill(background);
  rect(0, 0, width, height);
  
  if (ruotaSx && !ruotaDx) nave.ruotaAntiorario();
  else if (ruotaDx && !ruotaSx) nave.ruotaOrario();
  else nave.nonRuota();
  
  if (accelera) nave.accelera();
  else nave.nonAccelera();
  
  nave.aggiorna(dt);
  nave.disegna();
}

void keyPressed() {
  if (keyCode == LEFT) ruotaSx = true;
  if (keyCode == RIGHT) ruotaDx = true;
  if (keyCode == UP) accelera = true;
}

void keyReleased() {
  if (keyCode == LEFT) ruotaSx = false;
  if (keyCode == RIGHT) ruotaDx = false;
  if (keyCode == UP) accelera = false;
}
