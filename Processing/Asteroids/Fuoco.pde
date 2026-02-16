class Fuoco {
  static final color interno = #f6f94a;
  static final color esterno = #e20b04;
  static final float tempoAggiornamento = 0.1;
  
  float x, y; // posizione dell'angolo in alto a sx
  float larghezza;
  float altezza;
  float[] spostamentiCasuali;
  int numTriangoli = 3;
  float tempoPassato = 0;
  
  public Fuoco(float x, float y, float larghezza, float altezza) {
    this.x = x;
    this.y = y;
    this.larghezza = larghezza;
    this.altezza = altezza;
    this.spostamentiCasuali = new float[numTriangoli];
  }
  
  public void aggiorna(float dt) {
    tempoPassato += dt;
    if (tempoPassato > tempoAggiornamento) {
      tempoPassato -= tempoAggiornamento;
      for (int i=0; i<numTriangoli; i++) {
        spostamentiCasuali[i] = random(-1, 1);
      }
    }
  }
  
  public void disegna() {
    //debug
    //fill(#FFFFFF);
    //rect(x, y, larghezza, altezza);
    
    stroke(0, 0);
    fill(esterno);
    disegnaTriangoli(x, y, larghezza, altezza);
    fill(interno);
    disegnaTriangoli(x+larghezza/4, y, larghezza/2, altezza/2);
  }
    
  private void disegnaTriangoli(float x, float y, float l, float h) {
    float m = l/5; // margine base
    
    for (int i=0; i<numTriangoli; i++) {
      float px = x+i*l/(numTriangoli-1);
      float py = y+h + spostamentiCasuali[i] * h/5;
      
      triangle(
        x+m, y,
        x+l-m, y,
        px, py 
      );
    }
  }
}
