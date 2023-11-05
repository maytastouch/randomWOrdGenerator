import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:word_generator/core/errors/Exceptions.dart';
import 'package:word_generator/core/errors/Failures.dart';
import 'package:word_generator/data/models/word_model.dart';
import 'package:word_generator/data/repositories/word_repository_impl.dart';
import 'package:word_generator/domain/entities/word_entity.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockWordRemoteDataSource mockWordRemoteDataSource;
  late WordRepositoryImpl repositoryImpl;

  setUp(() {
    mockWordRemoteDataSource = MockWordRemoteDataSource();
    repositoryImpl =
        WordRepositoryImpl(wordRemoteDataSource: mockWordRemoteDataSource);
  });

  const tWord = 'Love';
  const tWordEntity = WordEntity.empty();
  const tWordModel = WordModel.empty();

  group('word_repository_impl_test', () {
    test(
      'should return [WordEntity] when successful',
      () async {
        //arrange
        when(mockWordRemoteDataSource.getDefinition(tWord))
            .thenAnswer((_) async => tWordModel);
        //act
        final result = await repositoryImpl.getDefinition(tWord);
        //assert
        expect(result, equals(const Right(tWordEntity)));
      },
    );
    test(
      'should return connection failure when the device has no internet',
      () async {
        //arrange
        when(mockWordRemoteDataSource.getDefinition(tWord)).thenThrow(
          const SocketException('Failed to connect to the network'),
        );

        //act
        final result = await repositoryImpl.getDefinition(tWord);

        //assert
        expect(
            result,
            equals(const Left(
                ConnectionFailure('Failed to connect to the network'))));
      },
    );

    test(
      'should return server failure when a call to data source is unsuccessful',
      () async {
        //arrange
        when(mockWordRemoteDataSource.getDefinition(tWord)).thenThrow(
          ServerException(),
        );

        //act
        final result = await repositoryImpl.getDefinition(tWord);
        // assert
        expect(
            result, equals(const Left(ServerFailure('An error has occurred'))));
      },
    );
  });
}
