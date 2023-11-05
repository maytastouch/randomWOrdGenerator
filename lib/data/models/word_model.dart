import 'package:word_generator/domain/entities/word_entity.dart';

class WordModel extends WordEntity {
  const WordModel({
    required super.definition,
  });

  const WordModel.empty()
      : this(
          definition: 'Strong affection.',
        );

  factory WordModel.fromJson(Map<String, dynamic> json) => WordModel(
        definition: json['meanings'][0]['definitions'][0]['definition'],
      );

  Map<String, dynamic> toJson() => {
        'meanings': [
          {
            'definitions': [
              {'definition': definition}
            ]
          }
        ]
      };

  WordEntity toEntity() => WordEntity(definition: definition);
}
