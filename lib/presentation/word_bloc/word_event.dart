import 'package:equatable/equatable.dart';

abstract class WordEvent extends Equatable {
  const WordEvent();

  @override
  List<Object?> get props => [];
}

class OnButtonPressed extends WordEvent {
  final String word;

  const OnButtonPressed(this.word);

  @override
  List<Object?> get props => [word];
}
