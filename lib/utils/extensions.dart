

extension StringEx on String {
  bool get asBool {
    return this == 'true' ? true : false;
  }

  double get asDouble {
    return double.tryParse(this ?? '');
  }

  int get asInt {
    return int.tryParse(this ?? '');
  }
}
