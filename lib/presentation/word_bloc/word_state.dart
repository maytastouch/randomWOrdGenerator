import 'package:equatable/equatable.dart';

import '../../domain/entities/word_entity.dart';

abstract class WordState extends Equatable {
  const WordState();

  @override
  List<Object?> get props => [];
}

class WordEmpty extends WordState {}

class WordLoading extends WordState {}

class WordLoaded extends WordState {
  final WordEntity result;

  const WordLoaded(this.result);

  @override
  List<Object?> get props => [result];
}

class WordLoadFailure extends WordState {
  final String message;

  const WordLoadFailure(this.message);

  @override
  List<Object?> get props => [message];
}
