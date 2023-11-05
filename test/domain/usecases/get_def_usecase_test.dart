import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:word_generator/domain/entities/word_entity.dart';

import 'package:word_generator/domain/usecases/get_def_usecase.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockWordRepository mockWordRepository;
  late GetDefUseCase getDefUseCase;

  setUp(() {
    mockWordRepository = MockWordRepository();
    getDefUseCase = GetDefUseCase(mockWordRepository);
  });

  const tWordEntity = WordEntity.empty();
  const tWord = 'love';

  test('should return [Word Entity] when successful', () async {
    //arrange
    when(mockWordRepository.getDefinition(tWord))
        .thenAnswer((_) async => const Right(tWordEntity));

    //act
    final result = await getDefUseCase.execute(tWord);
    //assert
    expect(result, equals(const Right(tWordEntity)));
  });
}
