import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/image_canvas/image_canvas.dart';
import 'features/image_canvas/image_cubit.dart';
import 'features/image_edit_panel/image_edit_panel.dart';
import 'features/image_edit_panel/image_settings_cubit.dart';
import 'features/test.dart';

Future<void> main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
          isDense: true,
        ),
      ),
      home: const MyHomePage(title: ''),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => ImageCubit()),
          BlocProvider(create: (_) => ImageSettingsCubit()),
        ],
        child: SafeArea(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: const [
              Expanded(child: ImageEditPanel()),

              Expanded(child: ImageCanvas()),
            ],
          ),
        ),
      ),
    );
    return App();
  }
}
