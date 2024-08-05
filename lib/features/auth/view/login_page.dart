import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:to_do/widgets/app_bar.dart';
import '../../../widgets/textFormField.dart';
import '../view_model/auth_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool hidePassword = true;
  final AuthServices _auth = AuthServices();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        context,
        titleText: "signInToYourAccount",
        centeredTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 30),
                CustomTextFormField(
                  hintText: "yourEmailAddress",
                  controller: emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "pleaseEnterEmailAddress".tr();
                    }
                    return null; // Input is valid
                  },
                ),
                const SizedBox(height: 20),
                CustomTextFormField(
                  hintText: "yourPassword",
                  controller: passwordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "pleaseEnterPassword".tr();
                    }
                    return null; // Input is valid
                  },
                  icon: InkWell(
                    onTap: () {
                      setState(() {
                        hidePassword = !hidePassword;
                      });
                    },
                    child: Icon(
                      hidePassword ? Icons.visibility : Icons.visibility_off,
                      size: 18,
                    ),
                  ),
                  obscure: hidePassword,
                ),
                const SizedBox(height: 35),
                isLoading
                    ? const CircularProgressIndicator()
                    : buildLoginButton(context),
                const SizedBox(height: 50),
                buildGoToSignUpScreen(context)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildGoToSignUpScreen(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "dontHaveAnAccount".tr(),
          style: TextStyle(fontSize: 12),
        ),
        InkWell(
            onTap: () {
              context.go('/signup');
            },
            child: Text(
              "signUp".tr(),
              style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo),
            ))
      ],
    );
  }

  Widget buildLoginButton(BuildContext context) {
    return InkWell(
      onTap: () async {
        if (_formKey.currentState!.validate()) {
          setState(() {
            isLoading = true;
          });
          final result = await _auth.login(
            emailController.text,
            passwordController.text,
          );
          setState(() {
            isLoading = false;
          });
          result.fold((msg) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(msg)));
          }, (user) {
            if (user != null) {
              context.go('/home', extra: user);
            }
          });
        }
      },
      child: Container(
        height: 40,
        width: 250,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.indigo,
        ),
        child: Center(
            child: Text(
          "signIn".tr(),
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
        )),
      ),
    );
  }
}
