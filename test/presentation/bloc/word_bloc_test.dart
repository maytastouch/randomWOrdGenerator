import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:word_generator/core/errors/Failures.dart';
import 'package:word_generator/domain/entities/word_entity.dart';
import 'package:word_generator/presentation/word_bloc/word_bloc.dart';
import 'package:word_generator/presentation/word_bloc/word_event.dart';
import 'package:word_generator/presentation/word_bloc/word_state.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockGetDefUseCase mockGetDefUseCase;
  late WordBloc wordBloc;

  setUp(() {
    mockGetDefUseCase = MockGetDefUseCase();
    wordBloc = WordBloc(mockGetDefUseCase);
  });

  const tWordE = WordEntity.empty();
  const tWord = "Love";

  blocTest<WordBloc, WordState>(
      'should emit [WordLoading, WordLoaded] when data is gotten successfully',
      build: () {
        when(mockGetDefUseCase.execute(tWord))
            .thenAnswer((_) async => const Right(tWordE));
        return wordBloc;
      },
      act: (bloc) => bloc.add(const OnButtonPressed(tWord)),
      wait: const Duration(milliseconds: 500),
      expect: () => [WordLoading(), const WordLoaded(tWordE)]);

  blocTest<WordBloc, WordState>(
      'should emit [WeatherLoading, WeatherLoadFailure] when get data is unsuccessful',
      build: () {
        when(mockGetDefUseCase.execute(tWord)).thenAnswer(
            (_) async => const Left(ServerFailure('Server failure')));
        return wordBloc;
      },
      act: (bloc) => bloc.add(const OnButtonPressed(tWord)),
      wait: const Duration(milliseconds: 500),
      expect: () => [WordLoading(), const WordLoadFailure('Server failure')]);
}







// void main() {
//   late MockGetCurrentWeatherUseCase mockGetCurrentWeatherUseCase;
//   late WeatherBloc weatherBloc;

//   setUp(() {
//     mockGetCurrentWeatherUseCase = MockGetCurrentWeatherUseCase();
//     weatherBloc = WeatherBloc(mockGetCurrentWeatherUseCase);
//   });

//   const testWeather = WeatherEntity(
//     cityName: 'New York',
//     main: 'Clouds',
//     description: 'few clouds',
//     iconCode: '02d',
//     temperature: 302.28,
//     pressure: 1009,
//     humidity: 70,
//   );

//   const testCityName = 'New York';
//   blocTest<WeatherBloc, WeatherState>(
//       'should emit [WeatherLoading, WeatherLoaded] when data is gotten successfully',
//       build: () {
//         when(mockGetCurrentWeatherUseCase.execute(testCityName))
//             .thenAnswer((_) async => const Right(testWeather));
//         return weatherBloc;
//       },
//       act: (bloc) => bloc.add(const OnCityChanged(testCityName)),
//       wait: const Duration(milliseconds: 500),
//       expect: () => [WeatherLoading(), const WeatherLoaded(testWeather)]);

//   blocTest<WeatherBloc, WeatherState>(
//     'should emit [WeatherLoading, WeatherLoadFailure] when get data is unsuccessful',
//     build: () {
//       when(mockGetCurrentWeatherUseCase.execute(testCityName))
//           .thenAnswer((_) async => const Left(ServerFailure('Server failure')));
//       return weatherBloc;
//     },
//     act: (bloc) => bloc.add(const OnCityChanged(testCityName)),
//     wait: const Duration(milliseconds: 500),
//     expect: () => [
//       WeatherLoading(),
//       const WeatherLoadFailure('Server failure'),
//     ],
//   );
// }

