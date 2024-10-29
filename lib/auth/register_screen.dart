import 'package:flutter/material.dart';
import 'package:todo_app/auth/login_screen.dart';
import 'package:todo_app/widgets/default_text_form_field.dart';

import '../widgets/default_elevated_button.dart';

class RegisterScreen extends StatefulWidget {
  static const routeName = "/registerScreen";

  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    final screenWidth = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DefaultTextFormField(
                validator: (value) {
                  if (value == null || value.trim().length < 5) {
                    return 'Name cannot be less than 2 characters ';
                  }
                  return null;
                },
                keyboardType: TextInputType.text,
                hintText: 'Name',
                controller: _nameController,
              ),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              DefaultTextFormField(
                validator: (value) {
                  if (value == null || value.trim().length < 5) {
                    return 'Email cannot be less than 5 characters ';
                  }
                  return null;
                },
                keyboardType: TextInputType.emailAddress,
                hintText: 'Email',
                controller: _emailController,
              ),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              DefaultTextFormField(
                isPassword: true,
                validator: (value) {
                  if (value == null || value.trim().length < 8) {
                    return 'Password cannot be less than 8 characters ';
                  }
                  return null;
                },
                keyboardType: TextInputType.visiblePassword,
                hintText: 'Password',
                controller: _passwordController,
              ),
              SizedBox(
                height: screenHeight * 0.05,
              ),
              DefaultElevatedButton(
                label: 'Register',
                onPressed: register,
              ),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(
                      context, LoginScreen.routeName);
                },
                child: const Text("Already have an account ?"),
              )
            ],
          ),
        ),
      ),
    );
  }

  void register() {
    if (formKey.currentState!.validate()) {
      // register logic
    }
  }
}
