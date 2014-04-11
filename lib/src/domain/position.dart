part of domain.model;

class Position {
  int _x, _y;
  int get x => _x;
  int get y => _y;

  bool equals(Position other) {
    if (other == null) {
      return false;
    }
    return other._x == _x && other._y == y;
  }

  int get hashCode => (_x * 397) ^ _y;

  bool operator ==(other) => equals(other);

  String toString() {
    return "($x,$y)";
  }

  Position(this._x, this._y);
}


