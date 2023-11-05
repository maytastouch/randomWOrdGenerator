import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:word_generator/core/errors/Failures.dart';
import 'package:word_generator/data/datasources/random_remote_data_source.dart';
import 'package:word_generator/domain/entities/random_entity.dart';
import 'package:word_generator/domain/repositories/random_repository.dart';

import '../../core/errors/Exceptions.dart';

class RandomRepositoryImpl extends RandomRepository {
  final RandomRemoteDataSource randomRemoteDataSource;

  RandomRepositoryImpl({required this.randomRemoteDataSource});
  @override
  Future<Either<Failure, RandomEntity>> getWord() async {
    try {
      final result = await randomRemoteDataSource.getWord();
      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure('An error has occurred'));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }
}
