import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/auth/login_screen.dart';
import 'package:todo_app/auth/user_provider.dart';
import 'package:todo_app/firebase_services/firebase_services.dart';
import 'package:todo_app/helper_methods/show_toast.dart';
import 'package:todo_app/utils/app_theme.dart';
import 'package:todo_app/widgets/default_text_form_field.dart';

import '../home_screen.dart';
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
        title: Text(AppLocalizations.of(context)!.register),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: screenHeight * 0.17,
                ),
                DefaultTextFormField(
                  validator: (value) {
                    if (value == null || value.trim().length < 5) {
                      return AppLocalizations.of(context)!
                          .name_cannot_be_less_than_2_characters;
                    }
                    return null;
                  },
                  keyboardType: TextInputType.text,
                  hintText: AppLocalizations.of(context)!.name,
                  controller: _nameController,
                ),
                SizedBox(
                  height: screenHeight * 0.02,
                ),
                DefaultTextFormField(
                  validator: (value) {
                    if (value == null || value.trim().length < 5) {
                      return AppLocalizations.of(context)!
                          .email_cannot_be_less_than_5_characters;
                    }
                    return null;
                  },
                  keyboardType: TextInputType.emailAddress,
                  hintText: AppLocalizations.of(context)!.email,
                  controller: _emailController,
                ),
                SizedBox(
                  height: screenHeight * 0.02,
                ),
                DefaultTextFormField(
                  isPassword: true,
                  validator: (value) {
                    if (value == null || value.trim().length < 8) {
                      return AppLocalizations.of(context)!
                          .password_cannot_be_less_than_8_characters;
                    }
                    return null;
                  },
                  keyboardType: TextInputType.visiblePassword,
                  hintText: AppLocalizations.of(context)!.password,
                  controller: _passwordController,
                ),
                SizedBox(
                  height: screenHeight * 0.04,
                ),
                DefaultElevatedButton(
                  label: AppLocalizations.of(context)!.register,
                  onPressed: register,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(
                        context, LoginScreen.routeName);
                  },
                  child: Text(
                      AppLocalizations.of(context)!.already_have_an_account),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void register() {
    if (formKey.currentState!.validate()) {
      FirebaseServices.registerUser(
              name: _nameController.text,
              email: _emailController.text,
              password: _passwordController.text)
          .then(
        (user) {
          Provider.of<UserProvider>(context, listen: false).updateUser(user);
          Navigator.pushReplacementNamed(context, HomeScreen.routeName);
        },
      ).catchError((error) {
        String? message;
        if (error is FirebaseAuthException) {
          message = error.message;
        }
        showToast(
            msg: message ?? "SomeThing Went Wrong!",
            backgroundColor: AppTheme.red);
      });
    }
  }
}
