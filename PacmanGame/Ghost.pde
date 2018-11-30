class Ghost {
  PVector pos;
  PVector vel = new PVector(-1, 0);

  String name;
  color colour; //The colour of the ghost in RGB format
  
  PVector turnTo = new PVector(-1, 0);
  boolean turn = false;


  Ghost(PVector pos, color colour, String name) {
    this.pos = pos;
    this.colour = colour;
    this.name = name;
  }

  void setPath() {

  }

  void show() {
    fill(colour);
    stroke(colour);
    ellipse(pos.x, pos.y, 20, 20);
  }

  void move() {
    if (this.checkPosition()) {
      pos.add(vel);
      this.turn = false;
    }
  }

  void moveTo(String direction) {
    switch(direction) {
      case "UP":
        this.turnTo = new PVector(0, -1); break;
      case "RIGHT":
        this.turnTo = new PVector(1, 0); break;
      case "DOWN":
        this.turnTo = new PVector(0, 1); break;
      case "LEFT":
        this.turnTo = new PVector(-1, 0); break;
      default:
        print("Invalid direction " + direction);
    }
    
    this.turn = true;
  }

  String direction() {
    if (turnTo.x == 0 && turnTo.y == -1) {
      return "UP";
    } else if (turnTo.x == 0 && turnTo.y == 1) {
      return "DOWN";
    } else if (turnTo.x == -1 && turnTo.y == 0) {
      return "LEFT";
    } else {
      return "RIGHT";
    }
  }

  boolean checkPosition() {
    if (pacman.hitPacman(pos)) {//if hit pacman
      pacman.kill();
    }

    if ((pos.x-8)%16 == 0 && (pos.y - 8)% 16 ==0) {//if on a critical position
      PVector matrixPosition = new PVector((pos.x-8)/16, (pos.y - 8)/16);//convert position to an array position
      PVector positionToCheck = new PVector(matrixPosition.x + turnTo.x, matrixPosition.y+ turnTo.y); // the position in the tiles double array that the player is turning towards

      if (tiles[floor(positionToCheck.y)][floor(positionToCheck.x)].wall) {//check if there is a free space in the direction that it is going to turn
        if (tiles[floor(matrixPosition.y + vel.y)][floor(matrixPosition.x + vel.x)].wall) {//if not check if the path ahead is free
          return false;//if neither are free then dont move
        } else {//forward is free
          return true;
        }
      } else {//free to turn
        vel = new PVector(turnTo.x, turnTo.y);
        return true;
      }
    } else {
      if ((pos.x+10*vel.x-8)%16 == 0 && (pos.y + 10*vel.y - 8)% 16 ==0) {//if 10 places off a critical position in the direction that pacman is moving
        PVector matrixPosition = new PVector((pos.x+10*vel.x-8)/16, (pos.y+10*vel.y-8)/16);//convert that position to an array position
      }
      
      if (turnTo.x + vel.x == 0 && vel.y + turnTo.y ==0) {//if turning chenging directions entirely i.e. 180 degree turn
        vel = new PVector(turnTo.x, turnTo.y);//turn
        return true;
      }
      return true;//if not on a critical postion then continue forward
    }

  }
}