import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:word_generator/data/datasources/word_remote_data_sources.dart';
import 'package:word_generator/domain/repositories/word_repository.dart';
import 'package:word_generator/domain/usecases/get_def_usecase.dart';

@GenerateMocks(
  [
    WordRepository,
    WordRemoteDataSource,
    GetDefUseCase,
  ],
  customMocks: [MockSpec<http.Client>(as: #MockHttpClient)],
)
void main() {}
