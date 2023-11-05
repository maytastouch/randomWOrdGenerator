import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:word_generator/data/models/word_model.dart';
import 'package:word_generator/domain/entities/word_entity.dart';

import '../../helpers/json_reader.dart';

void main() {
  const tWordModel = WordModel.empty();
  const tWordJson = {
    'meanings': [
      {
        'definitions': [
          {'definition': 'Strong affection.'}
        ]
      }
    ]
  };
  group('WordModel', () {
    test(
      'should be a subclass of [WordEntity]',
      () async {
        //assert
        expect(tWordModel, isA<WordEntity>());
      },
    );

    test(
      'should return a [WordModel] from [JSON]',
      () async {
        //arrange

        final Map<String, dynamic> jsonMap = json.decode(
            readFirstJson('helpers/dummy_data/dummy_word_response.json'));
        //act
        final result = WordModel.fromJson(jsonMap);
        //assert
        expect(result, equals(tWordModel));
      },
    );

    test(
      'should return a [JSON] from [WordModel]',
      () async {
        //act
        final result = tWordModel.toJson();
        //assert
        expect(result, equals(tWordJson));
      },
    );
  });
}
