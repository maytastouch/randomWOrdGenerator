import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:word_generator/data/models/random_model.dart';

import '../../helpers/json_reader.dart';

void main() {
  const tRandomModel = RandomModel(randomWord: 'boozing');
  test(
    'should return [RandomModel] is status code is [200]',
    () async {
      final String jsonMap =
          json.decode(readFirstJson('helpers/dummy_data/random_response.json'));
      //act
      final result = RandomModel.fromJson(jsonMap);
      //assert
      expect(result, equals(tRandomModel));
    },
  );
}
