class Blinky extends Ghost {
  Blinky() {
    super(new PVector(13*16 +8, 11*16+8), color(255, 0, 0), "Blinky");
    setPath();
  }
}