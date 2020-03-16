class NetException implements Exception {
  final String message;

  NetException(this.message);

  @override
  String toString() {
    return message;
  }
}
