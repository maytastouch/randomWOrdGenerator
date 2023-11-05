import 'dart:convert';

import 'package:word_generator/domain/entities/random_entity.dart';

class RandomModel extends RandomEntity {
  const RandomModel({required super.randomWord});

  factory RandomModel.fromJson(String json) {
    final List<dynamic> jsonData = jsonDecode(json);
    if (jsonData.isNotEmpty && jsonData.first is String) {
      return RandomModel(randomWord: jsonData.first);
    } else {
      throw Exception("Invalid JSON format or data missing");
    }
  }

  RandomEntity toEntity() => RandomModel(randomWord: randomWord);
}
