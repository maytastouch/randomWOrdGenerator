// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

class WordEntity extends Equatable {
  final String definition;

  const WordEntity({
    required this.definition,
  });

  const WordEntity.empty()
      : this(
          definition: 'Strong affection.',
        );

  @override
  List<Object> get props => [definition];
}
