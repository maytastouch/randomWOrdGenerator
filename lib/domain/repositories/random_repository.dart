import 'package:dartz/dartz.dart';
import 'package:word_generator/core/errors/Failures.dart';
import 'package:word_generator/domain/entities/random_entity.dart';

abstract class RandomRepository {
  Future<Either<Failure, RandomEntity>> getWord();
}
