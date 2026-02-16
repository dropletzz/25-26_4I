color background = #161616;

Astronave nave;
float tempoFramePrecedente;

void setup() {
  size(800, 600);
  
  // Astronave
  float altezza = 100;
  float larghezza = 60;
  nave = new Astronave(width/2, height/2, larghezza, altezza);
  
  tempoFramePrecedente = millis() / 1000.0;
}

void draw() {
  float adesso = millis() / 1000.0;
  float dt = adesso - tempoFramePrecedente;
  tempoFramePrecedente = adesso;
  // dt := quanto tempo e' passato dal frame precedente (in secondi)
  
  fill(background);
  rect(0, 0, width, height);
  
  nave.aggiorna(dt);
  nave.disegna();
}

void keyPressed() {
  if (keyCode == LEFT) nave.ruotaOrario(true);
  if (keyCode == RIGHT) nave.ruotaAntiorario(true);
  if (keyCode == UP) nave.accelera(true);
}

void keyReleased() {
  if (keyCode == LEFT) nave.ruotaOrario(false);
  if (keyCode == RIGHT) nave.ruotaAntiorario(false);
  if (keyCode == UP) nave.accelera(false);
}
