import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:word_generator/presentation/word_bloc/word_bloc.dart';
import 'package:word_generator/presentation/word_bloc/word_state.dart';

import '../random_bloc/random_bloc.dart';
import '../word_bloc/word_event.dart';

class WordPage extends StatelessWidget {
  const WordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String word = '';
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff1D1E22),
        title: const Text(
          'RANDOM WORD GENERATOR',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 32.0),
            BlocBuilder<RandomBloc, RandomState>(builder: (context, state) {
              if (state is RandomLoading) {
                return const CircularProgressIndicator();
              }
              if (state is RandomLoaded) {
                word = state.results.randomWord;
                context.read<WordBloc>().add(OnButtonPressed(word));
                return Center(
                  child: Text(
                    state.results.randomWord,
                    style: const TextStyle(
                        fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                );
              }
              return Container();
            }),

            const SizedBox(
              height: 50,
            ),
            //blocbuilder
            BlocBuilder<WordBloc, WordState>(
              builder: (context, state) {
                if (state is WordLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is WordLoaded) {
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Center(
                              child: Text(
                                state.result.definition,
                                style: const TextStyle(
                                  fontSize: 22.0,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8.0),
                      const SizedBox(height: 24.0),
                    ],
                  );
                }
                if (state is WordLoadFailure) {
                  return const Center(
                    child: Text('Definition not Found'),
                  );
                }
                return Container();
              },
            ),
            const SizedBox(
              height: 20,
            ),

            ElevatedButton(
              style: ButtonStyle(
                elevation: MaterialStateProperty.all<double>(0.0),
                backgroundColor:
                    MaterialStateProperty.all<Color>(const Color(0xff1D1E22)),
                foregroundColor: MaterialStateProperty.all<Color>(
                    Colors.white), // Set the text color
              ),
              onPressed: () {
                context.read<RandomBloc>().add(const OnLoaded());
              },
              child: const Text('Generate'),
            )
          ],
        ),
      ),
    );
  }
}
