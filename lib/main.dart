import 'dart:developer';

import 'package:assignment10/core/routes.dart';
import 'package:assignment10/core/ui.dart';
import 'package:assignment10/logic/cubits/user_cubit/user_cubit.dart';
import 'package:assignment10/presentation/screens/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => UserCubit(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: Themes.defaultTheme,
        debugShowCheckedModeBanner: false,
        onGenerateRoute: Routes.onGenerateRoute,
        initialRoute: LoginScreen.routeName,
      ),
    );
  }
}

class MyBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    log('Created: $bloc');
    super.onCreate(bloc);
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    log('Changed in $bloc: $change');
    super.onChange(bloc, change);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    log('Changed in $bloc: $transition');
    super.onTransition(bloc, transition);
  }

  @override
  void onClose(BlocBase bloc) {
    log('Closed: $bloc');
    super.onClose(bloc);
  }
}
