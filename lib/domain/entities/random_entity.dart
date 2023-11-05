import 'package:equatable/equatable.dart';

class RandomEntity extends Equatable {
  final String randomWord;

  const RandomEntity({required this.randomWord});

  @override
  List<Object?> get props => [randomWord];
}
