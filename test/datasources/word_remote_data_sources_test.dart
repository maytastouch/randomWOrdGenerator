import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:word_generator/core/constants/constants.dart';
import 'package:word_generator/core/errors/Exceptions.dart';
import 'package:word_generator/data/datasources/word_remote_data_sources.dart';
import 'package:http/http.dart' as http;
import 'package:word_generator/data/models/word_model.dart';

import '../helpers/json_reader.dart';
import '../helpers/test_helper.mocks.dart';

void main() {
  late MockHttpClient mockHttpClient;
  late WordRemoteDataSourceImpl wordRemoteDataSource;

  setUp(() {
    mockHttpClient = MockHttpClient();
    wordRemoteDataSource = WordRemoteDataSourceImpl(client: mockHttpClient);
  });

  const tWord = 'love';

  group(
    'WordRemoteDataSource',
    () {
      test(
        'should return [WordModel] when response code is [200]',
        () async {
          //arrange
          when(mockHttpClient.get(Uri.parse(Urls.currentDefinition(tWord))))
              .thenAnswer(
            (_) async => http.Response(
              removeInvalidCharacters(
                  'helpers/dummy_data/dummy_word_response.json'),
              200,
            ),
          );

          //act
          final result = await wordRemoteDataSource.getDefinition(tWord);
          //assert

          expect(result, isA<WordModel>());
        },
      );
      test(
        'should return [Exception] when response code is not [200]',
        () async {
          //arrange
          when(mockHttpClient.get(Uri.parse(Urls.currentDefinition(tWord))))
              .thenAnswer(
            (_) async => http.Response(
              'Not found',
              404,
            ),
          );

          //act
          final result = wordRemoteDataSource.getDefinition(tWord);
          //assert

          expect(result, throwsA(isA<ServerException>()));
        },
      );
    },
  );
}
