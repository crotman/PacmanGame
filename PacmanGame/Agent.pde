class Agent {
  
  int i = 0;
  
  void movePacman() {
    // random move
    
    if (! pacman.checkPosition() && pacman.turn == false) {
      print("Move: " + this.i);
      
      if (this.i == 0) {
        pacman.moveTo("DOWN");
      } else if (this.i == 1) {
        pacman.moveTo("LEFT");
      } else if (this.i == 2) {
        pacman.moveTo("DOWN");
      } else if (this.i == 3) {
        pacman.moveTo("RIGHT");
      }
      
      this.i += 1;
    }
  }
  
  void reset() {
    this.i = 0;
  }
}
