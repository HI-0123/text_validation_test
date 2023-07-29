import 'package:flutter/material.dart';
import 'mixin/validation.dart' show ValidationMixin;

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with ValidationMixin {
  late TextEditingController emailController;
  late TextEditingController passwordController;

  var showMsg = false;

  @override
  void initState() {
    emailController = TextEditingController(text: "");
    passwordController = TextEditingController(text: "");
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        final currentFocus = FocusScope.of(context);
        if (currentFocus.previousFocus()) {
          return currentFocus.unfocus();
        }
      },
      child: Scaffold(
        body: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: SafeArea(
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 240),
                    const Text('ログインページ'),
                    const SizedBox(height: 40),
                    TextInputField(
                      controller: emailController,
                      hintText: "Email",
                      validator: (value) {
                        if (value == null) return null;

                        return isEmailValid(value)
                            ? null
                            : "Emailの形式で入力してください。";
                      },
                    ),
                    const SizedBox(height: 24),
                    TextInputField(
                      controller: passwordController,
                      hintText: "Password",
                      validator: (value) {
                        if (value == null) return null;

                        return isPasswordValid(value) ? null : "８文字以上入力してください。";
                      },
                    ),
                    const SizedBox(height: 40),
                    TextButton(
                      onPressed: () {
                        if (!formKey.currentState!.validate()) return;

                        setState(() {
                          showMsg = !showMsg;
                        });
                      },
                      child: const Text(
                        "ログイン",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    if (showMsg) ...[
                      const SizedBox(height: 24),
                      const Text(
                        "ログインしました！",
                        style: TextStyle(fontSize: 24),
                        textAlign: TextAlign.center,
                      ),
                    ],
                    const SizedBox(height: 2400),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class TextInputField extends StatelessWidget {
  const TextInputField({
    Key? key,
    required this.controller,
    required this.hintText,
    this.validator,
  }) : super(key: key);

  final TextEditingController controller;
  final String hintText;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.black26),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: const BorderSide(
            color: Colors.black87,
          ),
        ),
      ),
      validator: validator,
    );
  }
}
