import 'package:assignment10/core/ui.dart';
import 'package:assignment10/presentation/screens/auth/providers/login_provider.dart';
import 'package:assignment10/presentation/widgets/gap_widget.dart';
import 'package:assignment10/presentation/widgets/link_button.dart';
import 'package:assignment10/presentation/widgets/primary_button.dart';
import 'package:assignment10/presentation/widgets/primary_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: const Text('Ecommerce App'),
      ),
      body: SafeArea(
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
          ),
          const GapWidget(),
          PrimaryTextField(
            controller: provider.passwordController,
            labelText: 'Password',
            obscureText: true,
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
                onPressed: () {},
                text: 'Signup',
              ),
            ],
          )
        ],
      )),
    );
  }
}
