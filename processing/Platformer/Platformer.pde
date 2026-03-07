Giocatore g;
ArrayList<Piattaforma> piattaforme;
float prima;

color coloreSfondo = #67fccd;

void setup() {
  
  size(600, 400);
  g = new Giocatore(width/2, 0, 30, 70);
  prima = millis() / 1000;
  
  piattaforme = new ArrayList<>();
  piattaforme.add(new Piattaforma(0, height - 50, width, 50));
  piattaforme.add(new Piattaforma(width/4, height/2, width/2, 50));
  piattaforme.add(new Piattaforma(0, 100, 50, height-100));
  piattaforme.add(new Piattaforma(width-50, 100, 50, height-100));
}

void draw() {
  float adesso = millis() / 1000.0;
  float dt = adesso - prima;
  prima = adesso;
  
  // gestiamo fisica e collisioni
  g.aggiorna(dt);
  g.aTerra = false;
  for (Piattaforma p : piattaforme) {
    Collisione c = g.collideCon(p);
    if (c == Collisione.SOPRA) {
      g.y = p.y - g.h;
      g.vy = 0;
      g.aTerra = true;
    }
    else if (c == Collisione.SOTTO) {
      g.y = p.y + p.h;
      g.vy = 0;
    }
    else if (c == Collisione.SX) {
      g.x = p.x - g.w;
      g.vx = 0;
    }
    else if (c == Collisione.DX) {
      g.x = p.x+ p.w;
      g.vx = 0;
    }
  }
  
  // disegnamo la scena
  background(coloreSfondo);
  for (Piattaforma p : piattaforme) p.disegna();
  g.disegna();
}


void keyPressed() {
  if (keyCode == LEFT) g.muoviSx(true);
  if (keyCode == RIGHT) g.muoviDx(true);
  if (keyCode == UP) g.salta();
}

void keyReleased() {
  if (keyCode == LEFT) g.muoviSx(false);
  if (keyCode == RIGHT) g.muoviDx(false);
}
