import 'package:assignment10/core/ui.dart';
import 'package:assignment10/presentation/screens/auth/providers/signup_provider.dart';
import 'package:assignment10/presentation/widgets/gap_widget.dart';
import 'package:assignment10/presentation/widgets/link_button.dart';
import 'package:assignment10/presentation/widgets/primary_button.dart';
import 'package:assignment10/presentation/widgets/primary_textfield.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  static const String routeName = 'signup';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SignupProvider>(context);

    return Scaffold(
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
              'Create Account',
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
            const GapWidget(),
            PrimaryTextField(
              controller: provider.cPasswordController,
              labelText: 'Confirm password',
              obscureText: true,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Confirm your password!';
                } else if (value.trim() !=
                    provider.passwordController.text.trim()) {
                  return 'Passwords do not match!';
                }
                return null;
              },
            ),
            const GapWidget(),
            PrimaryButton(
              onPressed: provider.createAccount,
              text: (provider.isLoading) ? '...' : 'Create Account',
            ),
            const GapWidget(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Already have an account?",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                const GapWidget(),
                LinkButton(
                  onPressed: () {},
                  text: 'Log In',
                ),
              ],
            )
          ],
        ),
      )),
    );
  }
}
