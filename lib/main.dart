import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'injection_container.dart';
import 'presentation/random_bloc/random_bloc.dart';
import 'presentation/word_bloc/word_bloc.dart';
import 'presentation/pages/word_page.dart';

void main() {
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => locator<WordBloc>(),
        ),
        BlocProvider(
          create: (_) => locator<RandomBloc>(),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: WordPage(),
      ),
    );
  }
}
