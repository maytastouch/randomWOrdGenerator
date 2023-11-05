import 'package:dartz/dartz.dart';
import 'package:word_generator/domain/entities/random_entity.dart';
import 'package:word_generator/domain/repositories/random_repository.dart';

import '../../core/errors/Failures.dart';

class RandomUseCase {
  final RandomRepository randomRepository;

  RandomUseCase({required this.randomRepository});

  Future<Either<Failure, RandomEntity>> getWord() async {
    return randomRepository.getWord();
  }
}
