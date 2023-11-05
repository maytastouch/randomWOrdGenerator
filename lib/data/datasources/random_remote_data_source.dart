import 'package:http/http.dart' as http;
import 'package:word_generator/core/errors/Exceptions.dart';

import '../../core/constants/constants.dart';

import '../models/random_model.dart';

abstract class RandomRemoteDataSource {
  Future<RandomModel> getWord();
}

class RandomRemoteDataSourceImpl extends RandomRemoteDataSource {
  final http.Client client;

  RandomRemoteDataSourceImpl({required this.client});
  @override
  Future<RandomModel> getWord() async {
    final response = await client.get(Uri.parse(Urls.baseRandUrl));
    if (response.statusCode == 200) {
      return RandomModel.fromJson(response.body);
    } else {
      throw ServerException();
    }
  }
}
