import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:word_generator/core/errors/Exceptions.dart';

import '../../core/constants/constants.dart';
import '../../core/constants/prune/prune.dart';
import '../models/word_model.dart';

abstract class WordRemoteDataSource {
  Future<WordModel> getDefinition(String word);
}

class WordRemoteDataSourceImpl extends WordRemoteDataSource {
  final http.Client client;

  WordRemoteDataSourceImpl({required this.client});
  //problem
  @override
  Future<WordModel> getDefinition(String word) async {
    final response = await client.get(Uri.parse(Urls.currentDefinition(word)));
    if (response.statusCode == 200) {
      return WordModel.fromJson(
          json.decode(Prune.removeInvalidCharacters(response.body)));
    } else {
      throw ServerException();
    }
  }
}
