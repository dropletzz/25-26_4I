public enum Collisione {
  SOPRA,
  SOTTO,
  DX,
  SX,
  NESSUNA
}


class Giocatore {
  public float x, y, w, h;
  public float vx, vy, ax, ay;
  public boolean aTerra = false;
  
  private color colore = #db0012;
  
  private boolean vaVersoSx = false, vaVersoDx = false;
  private float velocitaMovimento = 350;
  private float velocitaSalto = 550;
  private float gravita = 900;
  
  public Giocatore(float px, float py, float pw, float ph) {
    this.x = px;
    this.y = py;
    this.w = pw;
    this.h = ph;
    this.vx = 0;
    this.vy = 0;
    this.ax = 0;
    this.ay = 0;
  }
  
  public void muoviSx(boolean v) {
    this.vaVersoSx = v;
  }
  
  public void muoviDx(boolean v) {
    this.vaVersoDx = v;
  }
  
  public Collisione collideCon(Piattaforma p) {
    float gX1 = x, gX2 = x + w;
    float gY1 = y, gY2 = y + h;
    float pX1 = p.x, pX2 = p.x + p.w;
    float pY1 = p.y, pY2 = p.y + p.h;
    
    boolean xOverlap = gX1 < pX2 && gX2 > pX1;
    if (xOverlap) {
      if (gY2 > pY1 && gY1 < pY1) return Collisione.SOPRA;
      if (gY1 < pY2 && gY2 > pY2) return Collisione.SOTTO;
    }
    
    boolean yOverlap = gY1 < pY2 && gY2 > pY1;
    if (yOverlap) {
      if (gX2 > pX1 && gX1 < pX1) return Collisione.SX;
      if (gX1 < pX2 && gX2 > pX2) return Collisione.DX;
    }
    
    return Collisione.NESSUNA;
  }
    
  public void salta() {
    if (aTerra) {
      vy = -velocitaSalto;
    }
  }
  
  public void aggiorna(float dt) {
    if      (vaVersoDx && !vaVersoSx) vx = velocitaMovimento;
    else if (vaVersoSx && !vaVersoDx) vx = -velocitaMovimento;
    else vx = 0;
    
    ay = gravita;
    vx += ax * dt;
    vy += ay * dt;
    x += vx * dt;
    y += vy * dt;
  }

  public void disegna() {
    fill(colore);
    stroke(colore);
    rect(x, y, w, h);
  }
}
