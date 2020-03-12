import 'package:test/test.dart';

void main() {
  test('test runtime type from dynamic params', () {
    assert('param'.runtimeType == String);
    assert('param'.runtimeType.toString() == 'String');

    dynamic param = '===';
    assert(param.runtimeType == String);

    Object param2 = '----';
    assert(param2.runtimeType == String);

    num param3 = 44;
    assert(param3.runtimeType != num);
    assert(param3.runtimeType == int);

    param3 = 4.4;
    assert(param3.runtimeType != num);
    assert(param3.runtimeType == double);
  });
}
