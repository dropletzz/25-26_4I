class Piattaforma {
  public float x, y, w, h;
  private color colore = #333333;
  
  public Piattaforma(float px, float py, float pw, float ph) {
    x = px;
    y = py;
    w = pw;
    h = ph;
  }
  
  public void disegna() {
    fill(colore);
    stroke(colore);
    rect(x, y, w, h);
  }
}
