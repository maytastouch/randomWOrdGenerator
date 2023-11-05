import 'package:bloc/bloc.dart';

import 'package:rxdart/rxdart.dart';
import 'package:word_generator/presentation/word_bloc/word_event.dart';
import 'package:word_generator/presentation/word_bloc/word_state.dart';

import '../../domain/usecases/get_def_usecase.dart';

class WordBloc extends Bloc<WordEvent, WordState> {
  final GetDefUseCase _getDefUseCase;

  WordBloc(this._getDefUseCase) : super(WordEmpty()) {
    on<OnButtonPressed>(
      (event, emit) async {
        emit(WordLoading());
        final result = await _getDefUseCase.execute(event.word);
        result.fold(
          (failure) {
            emit(WordLoadFailure(failure.message));
          },
          (data) {
            emit(WordLoaded(data));
          },
        );
      },
      transformer: debounce(const Duration(milliseconds: 500)),
    );
  }
}

EventTransformer<T> debounce<T>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}
