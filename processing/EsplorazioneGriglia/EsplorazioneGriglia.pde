public enum Cella {
  Libera,
  Muro,
  Esplorata
}

int cols, rows;
int cellSize = 40;
Cella[][] grid;

void setup() {
  size(800, 600);
  
  // calcoliamo il numero di colonne e righe in base alla dimensione della finestra
  cols = width / cellSize;
  rows = height / cellSize;
  
  // inizializziamo la griglia
  grid = new Cella[cols][rows];
  
  // riempiamo la griglia di celle libere
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      grid[i][j] = Cella.Libera; 
    }
  }
  
  // aggiungiamo dei muri (3 rettangoli casuali)
  randomRect(); randomRect(); randomRect();
}

void randomRect() {
  int x = (int)(Math.random() * cols * 0.75);
  int xw = 3 + (int)(Math.random() * (cols - x - 4));
  int y = (int)(Math.random() * rows * 0.75);
  int yw = 3 + (int)(Math.random() * (rows - y - 4));
  
  for (int i = x; i < x+xw; i++) {
    grid[i][y] = Cella.Muro; 
    grid[i][y+yw-1] = Cella.Muro;
  } 
  for (int j = y; j < y+yw; j++) {
    grid[x][j] = Cella.Muro; 
    grid[x+xw-1][j] = Cella.Muro;
  }
}

void draw() {
  background(255);
  
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      int x = i * cellSize;
      int y = j * cellSize;
      
      if (grid[i][j] == Cella.Muro) {
        fill(50); // grigio scuro
      } 
      else if (grid[i][j] == Cella.Esplorata) {
        fill(0, 200, 0); // verde
      } else if (grid[i][j] == Cella.Libera) {
        fill(255); // bianco
      }
      
      stroke(200); // colore dei bordi della griglia
      rect(x, y, cellSize, cellSize);
    }
  }
}

class Punto {
  public int x, y;
  
  public Punto(int x, int y) {
    this.x = x; this.y = y;
  }
  
  public ArrayList<Punto> vicinato() {
    ArrayList<Punto> vicini = new ArrayList<>();
    if (x+1 < cols) vicini.add(new Punto(x+1, y));
    if (x-1 >= 0) vicini.add(new Punto(x-1, y));
    if (y+1 < rows) vicini.add(new Punto(x, y+1));
    if (y-1 >= 0) vicini.add(new Punto(x, y-1));
    return vicini;
  }
}

void mousePressed(MouseEvent e) {
  // segna come 'esplorate' tutte le celle raggiungibili partendo da quella cliccata
  int i = mouseX / cellSize;
  int j = mouseY / cellSize;

  ArrayList<Punto> daEsplorare = new ArrayList<>();
  daEsplorare.add(new Punto(i, j));
  
  while (daEsplorare.size() > 0) {
    Punto p = daEsplorare.remove(0);
    if (grid[p.x][p.y] == Cella.Libera) {
      grid[p.x][p.y] = Cella.Esplorata;
      for (Punto v : p.vicinato()) daEsplorare.add(v);
    }
  }
}
