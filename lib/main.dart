import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_weather_app/Features/Auth/Cubit/Cubit/RegisterCubit/register_cubit.dart';
import 'package:task_weather_app/Features/Auth/Cubit/LoginCubit/login_cubit.dart';
import 'package:task_weather_app/Features/Auth/View/Login_screen.dart';
import 'package:task_weather_app/Features/home/View/Home.dart';

import 'package:task_weather_app/Features/notes/Cubit/note_cubit.dart';
import 'package:task_weather_app/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: 'AIzaSyCBnTJlYLJN2lKmKdfgKBYJH1whYMCsF2M',
      appId: '1:516982999814:android:dcc57e25dcaf620ddcec87',
      messagingSenderId: '516982999814',
      projectId: 'weatherappauth-9b2f9',
      storageBucket: 'weatherappauth-9b2f9.appspot.com',
    ),
  );
  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (BuildContext context) {
        return WeatherApp();
      },
    ),
  );
}

class WeatherApp extends StatelessWidget {
  WeatherApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LoginCubit()),
        BlocProvider(create: (context) => RegisterCubit()),
        BlocProvider(create: (context) => NoteCubit()),
      ],
      child: MaterialApp(
        title: 'Weather',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          //  BlocProvider.of<WeatherCubit>(context).weatherModel == null
          // ? Colors.red
          //  : BlocProvider.of<WeatherCubit>(context)
          //     .weatherModel!
          //     .getColorTheme(),
        ),
        debugShowCheckedModeBanner: false,
        locale: DevicePreview.locale(context),
        builder: DevicePreview.appBuilder,
        home: NotesHomePage(),
      ),
    );
  }
}
