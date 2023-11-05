import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:word_generator/core/errors/Failures.dart';
import 'package:word_generator/data/datasources/word_remote_data_sources.dart';
import 'package:word_generator/domain/entities/word_entity.dart';
import 'package:word_generator/domain/repositories/word_repository.dart';

import '../../core/errors/Exceptions.dart';

class WordRepositoryImpl extends WordRepository {
  final WordRemoteDataSource wordRemoteDataSource;

  WordRepositoryImpl({required this.wordRemoteDataSource});

  @override
  Future<Either<Failure, WordEntity>> getDefinition(String word) async {
    try {
      final result = await wordRemoteDataSource.getDefinition(word);
      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure('An error has occurred'));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }
}
