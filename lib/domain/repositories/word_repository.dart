import 'package:dartz/dartz.dart';
import 'package:word_generator/domain/entities/word_entity.dart';

import '../../core/errors/Failures.dart';

abstract class WordRepository {
  Future<Either<Failure, WordEntity>> getDefinition(String word);
}
