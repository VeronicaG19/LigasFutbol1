class Positions{
  String preferencePosition;
  int preferencePositionId;

 Positions({required this.preferencePosition, required this.preferencePositionId});

  @override
  String toString() {
    return '{ ${this.preferencePosition}, ${this.preferencePositionId}, }';
  }
}