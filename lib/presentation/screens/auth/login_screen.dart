import 'package:assignment10/core/ui.dart';
import 'package:assignment10/logic/cubits/user_cubit/user_cubit.dart';
import 'package:assignment10/logic/cubits/user_cubit/user_state.dart';
import 'package:assignment10/presentation/screens/auth/providers/login_provider.dart';
import 'package:assignment10/presentation/screens/auth/signup_screen.dart';
import 'package:assignment10/presentation/screens/home/home_screen.dart';
import 'package:assignment10/presentation/widgets/gap_widget.dart';
import 'package:assignment10/presentation/widgets/link_button.dart';
import 'package:assignment10/presentation/widgets/primary_button.dart';
import 'package:assignment10/presentation/widgets/primary_textfield.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static const String routeName = 'login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LoginProvider>(context);
    return BlocListener<UserCubit, UserState>(
      listener: (context, state) {
        if (state is UserLoggedInState) {
          Navigator.popUntil(context, (route) => route.isFirst);
          Navigator.pushReplacementNamed(context, HomeScreen.routeName);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          title: const Text('Ecommerce App'),
        ),
        body: SafeArea(
            child: Form(
          key: provider.formKey,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text(
                'Log In',
                style: TextStyles.heading2,
              ),
              const GapWidget(
                size: -10,
              ),
              (provider.error != '')
                  ? Text(
                      provider.error,
                      style: const TextStyle(color: Colors.red),
                    )
                  : const SizedBox(),
              const GapWidget(
                size: 5,
              ),
              PrimaryTextField(
                controller: provider.emailController,
                labelText: 'Email Address',
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Email Address is required!';
                  } else if (!EmailValidator.validate(value.trim())) {
                    return 'Invalid email address';
                  }
                  return null;
                },
              ),
              const GapWidget(),
              PrimaryTextField(
                controller: provider.passwordController,
                labelText: 'Password',
                obscureText: true,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Password is required!';
                  }
                  return null;
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  LinkButton(
                    text: 'Forgot password?',
                    onPressed: () {},
                  ),
                ],
              ),
              const GapWidget(),
              PrimaryButton(
                onPressed: provider.logIn,
                text: (provider.isLoading) ? '...' : 'Login',
              ),
              const GapWidget(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have account?",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  const GapWidget(),
                  LinkButton(
                    onPressed: () {
                      Navigator.pushNamed(context, SignUpScreen.routeName);
                    },
                    text: 'Signup',
                  ),
                ],
              )
            ],
          ),
        )),
      ),
    );
  }
}
