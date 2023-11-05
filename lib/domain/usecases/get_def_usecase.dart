import 'package:dartz/dartz.dart';
import 'package:word_generator/domain/entities/word_entity.dart';
import 'package:word_generator/domain/repositories/word_repository.dart';

import '../../core/errors/Failures.dart';

class GetDefUseCase {
  final WordRepository wordRepository;

  GetDefUseCase(this.wordRepository);

  Future<Either<Failure, WordEntity>> execute(String word) async {
    return wordRepository.getDefinition(word);
  }
}
