import 'dart:convert';

import 'package:test/test.dart';

void main() {
  test('test map to json', () {
    var map = {
      'aaa': 1,
      'bbb': true,
      'ccc': 2,
      'ddd': "String",
    };

    assert('{"aaa":1,"bbb":true,"ccc":2,"ddd":"String"}' == jsonEncode(map));
  });

  test('test json to map', () {
    var jsonStr = '{"aaa":1,"bbb":true,"ccc":2,"userName":"String"}';
    print(jsonDecode(jsonStr).runtimeType);
  });
}
