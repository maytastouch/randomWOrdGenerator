part of 'random_bloc.dart';

sealed class RandomState extends Equatable {
  const RandomState();

  @override
  List<Object?> get props => [];
}

final class RandomInitial extends RandomState {}

class RandomLoading extends RandomState {}

class RandomLoaded extends RandomState {
  final RandomEntity results;

  const RandomLoaded(this.results);

  @override
  List<Object?> get props => [results];
}

class RandomLoadFailure extends RandomState {
  final String message;

  const RandomLoadFailure(this.message);

  @override
  List<Object?> get props => [message];
}
