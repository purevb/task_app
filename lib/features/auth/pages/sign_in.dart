import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:smooth_corner/smooth_corner.dart';
import 'package:task_app/utils/text_field.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  final key = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    super.dispose();
  }

  void signUpUser() {
    if (key.currentState!.validate()) {}
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardDismissOnTap(
      child: Form(
        key: key,
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              spacing: 10,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  textAlign: TextAlign.center,
                  "Sign in",
                  style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                ),
                KTextField(
                  controller: emailController,
                  hintText: 'Email',
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Email field cannot be empty";
                    }
                    return null;
                  },
                ),

                KTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  isObscureText: true,
                  validator: (value) {
                    if (value == null ||
                        value.trim().isEmpty ||
                        value.trim().length < 8) {
                      return "Password field is invalid";
                    }
                    return null;
                  },
                ),
                InkWell(
                  onTap: () {
                    signUpUser();
                  },
                  child: Container(
                    decoration: ShapeDecoration(
                      color: Colors.black,
                      shape: SmoothRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        smoothness: 0.7,
                      ),
                    ),
                    height: 70,
                    child: Center(
                      child: Text(
                        "SIGN IN",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                Text.rich(
                  TextSpan(
                    text: "Dont u have an account? ",
                    children: [
                      TextSpan(
                        text: "Sign In",
                        style: TextStyle(fontWeight: FontWeight.bold),
                        recognizer: TapGestureRecognizer()..onTap = () {},
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
