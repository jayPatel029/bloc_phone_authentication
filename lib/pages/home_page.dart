import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phone_auth_bloc/pages/cubits/auth_cubit/auth_cubit.dart';
import 'package:phone_auth_bloc/pages/sign_in_screen.dart';
import 'cubits/auth_cubit/auth_state.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Welcome..LOGGED IN Successfully"),
              Container(
                child: BlocConsumer<AuthCubit, AuthState>(
                  listener: (context, state) {
                    if (state is AuthLoggedOutState) {
                      Navigator.popUntil(context, (route) => route.isFirst);
                      Navigator.pushReplacement(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => SignInScreen()));
                    }
                  },
                  builder: (context, state) {
                    return CupertinoButton(
                      onPressed: () {
                        BlocProvider.of<AuthCubit>(context).logOut();
                      },
                      child: const Text("Click here to Log out"),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
