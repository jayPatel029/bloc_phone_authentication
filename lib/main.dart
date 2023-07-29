import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phone_auth_bloc/pages/cubits/auth_cubit/auth_cubit.dart';
import 'package:phone_auth_bloc/pages/cubits/auth_cubit/auth_state.dart';
import 'package:phone_auth_bloc/pages/home_page.dart';
import 'package:phone_auth_bloc/pages/sign_in_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: BlocBuilder<AuthCubit, AuthState>(

            buildWhen: (oldState, newState) {
              return oldState is AuthInitialState;
            },
            builder: (context, state) {
              if (state is AuthLoggedInState) {
                //Go=>HomeScreen
                return HomePage();
              } else if (state is AuthLoggedOutState) {
                // Go=>signInScreen
                return SignInScreen();
              }
              else {
                // if not loggedIn/LoggedOut
                return Scaffold(
                  body: Center(
                    child: Text("SplashScreen"),
                  ),
                );
              }
            },
          )),
    );
  }
}
