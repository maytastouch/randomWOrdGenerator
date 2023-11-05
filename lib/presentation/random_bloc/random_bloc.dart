import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:word_generator/presentation/word_bloc/word_bloc.dart';

import '../../domain/entities/random_entity.dart';
import '../../domain/usecases/random_usecase.dart';

part 'random_event.dart';
part 'random_state.dart';

class RandomBloc extends Bloc<RandomEvent, RandomState> {
  final RandomUseCase _randomUseCase;
  RandomBloc(this._randomUseCase) : super(RandomInitial()) {
    on<OnLoaded>(
      (event, emit) async {
        emit(RandomLoading());
        final result = await _randomUseCase.getWord();
        result.fold(
          (failure) {
            emit(RandomLoadFailure(failure.message));
          },
          (data) {
            emit(RandomLoaded(data));
          },
        );
      },
      transformer: debounce(const Duration(milliseconds: 500)),
    );
  }
}
