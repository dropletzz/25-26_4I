
class Astronave {
  public float velocitaAngolare = PI; // radianti al secondo
  public float accelerazione = 230;
  public float coeffAttrito = 0.5;
  
  public float px, py;
  public float vx, vy;
  public float ax, ay;
  public float angolo, vang;
  public float altezza, larghezza;
  
  public Fuoco fuoco;
  public boolean staAccelerando;
  
  public Astronave(float px, float py, float larghezza, float altezza) {
    this.px = px;
    this.py = py;
    this.vx = 0;
    this.vy = 0;
    this.ax = 0;
    this.ay = 0;
    this.angolo = 0;
    this.vang = 0;
    this.altezza = altezza;
    this.larghezza = larghezza;
    
    float latoFuoco = larghezza*0.75;
    this.fuoco = new Fuoco(-latoFuoco/2, altezza/2, latoFuoco, latoFuoco);
  }
  
  public void aggiorna(float dt) {
    if (staAccelerando) {
      ax = accelerazione * cos(angolo-PI/2);
      ay = accelerazione * sin(angolo-PI/2);
    } else {
      ax = 0;
      ay = 0;
    }
    ax = ax - coeffAttrito * vx;   
    ay = ay - coeffAttrito * vy;
    vx += ax * dt;
    vy += ay * dt;
    px += vx * dt;
    py += vy * dt;
    angolo += vang * dt;
    
    if (px < 0) px += width;
    if (py < 0) py += height;
    if (px > width) px -= width;
    if (py > height) py -= height;
    
    fuoco.aggiorna(dt);
  }
  
  public void ruotaOrario() {
    vang = velocitaAngolare;
  }
  
  public void ruotaAntiorario() {
    vang = -velocitaAngolare;
  }
  
  public void nonRuota() {
    vang = 0;
  }
  
  public void accelera() {
    staAccelerando = true;
  }
  
  public void nonAccelera() {
    staAccelerando = false;
  }
  
  public void disegna() {
    pushMatrix();
    translate(px, py);
    rotate(angolo);
    fill(#C3C3C3);
    stroke(0, 0);
    triangle(0, -altezza/2, -larghezza/2, altezza/2, larghezza/2, altezza/2);
    

    if (staAccelerando) {
      fuoco.disegna();
    }
    popMatrix();
  }
  
}
