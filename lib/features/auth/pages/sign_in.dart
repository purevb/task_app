import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:go_router/go_router.dart';
import 'package:local_auth/local_auth.dart';
import 'package:smooth_corner/smooth_corner.dart';
import 'package:task_app/utils/text_field.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final LocalAuthentication auth = LocalAuthentication();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  Future<bool> canAuthenticate() async {
    try {
      return await auth.canCheckBiometrics || await auth.isDeviceSupported();
    } catch (e) {
      return false;
    }
  }

  Future<bool> authenticateUser() async {
    try {
      return await auth.authenticate(
        localizedReason: 'Authenticate to sign in',
        biometricOnly: false,
      );
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  void signInUser() {
    if (formKey.currentState!.validate()) {
      debugPrint("Email: ${emailController.text}");
      debugPrint("Password: ${passwordController.text}");
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardDismissOnTap(
      child: Scaffold(
        body: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Sign In",
                  style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 30),

                KTextField(
                  controller: emailController,
                  hintText: 'Email',
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Email cannot be empty";
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 10),

                KTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  isObscureText: true,
                  validator: (value) {
                    if (value == null || value.length < 8) {
                      return "Password must be at least 8 characters";
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 20),

                InkWell(
                  onTap: signInUser,
                  child: Container(
                    height: 70,
                    decoration: ShapeDecoration(
                      color: Colors.black,
                      shape: SmoothRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        smoothness: 0.7,
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        "SIGN IN",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // ✅ Navigate
                Text.rich(
                  TextSpan(
                    text: "Don't have an account? ",
                    children: [
                      TextSpan(
                        text: "Sign Up",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            context.go("/");
                          },
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                GestureDetector(
                  onTap: () async {
                    final canAuth = await canAuthenticate();
                    if (!canAuth) {
                      debugPrint("Biometric not available");
                      return;
                    }

                    final success = await authenticateUser();
                    if (success && mounted) {
                      debugPrint("Authenticated");
                    }
                  },
                  child: Container(
                    height: 55,
                    width: 55,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(color: Colors.black26, blurRadius: 6),
                      ],
                    ),
                    child: CachedNetworkImage(
                      fit: BoxFit.contain,
                      imageUrl:
                          "https://cdn-icons-png.flaticon.com/128/9796/9796616.png",
                      errorWidget: (_, __, ___) =>
                          const Icon(Icons.fingerprint),
                    ),
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
