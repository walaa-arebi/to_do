import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:to_do/widgets/app_bar.dart';
import '../../../widgets/textFormField.dart';
import '../view_model/auth_service.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool hidePassword = true;
  final AuthServices _auth = AuthServices();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        context,
        centeredTitle: true,
        titleText: "signUpForFree",
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 30),
                  CustomTextFormField(
                      hintText: "yourName",
                      controller: nameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "pleaseEnterYourName".tr();
                        }
                        return null; // Input is valid
                      },
                     ),
                  const SizedBox(height: 20),
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
                    validator: validatePassword,
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
                      : buildSignUpButton(context),
                  const SizedBox(height: 50),
                  buildGoToLogin(context)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String? validatePassword(String? value) {
    // should contain at least one upper case
    // should contain at least one lower case
    // should contain at least one digit
    // should contain at least one Special character
    // Must be at least 8 characters in length
    RegExp regex =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
    if (value == null || value.isEmpty) {
      return 'pleaseEnterPassword'.tr();
    } else {
      if (!regex.hasMatch(value)) {
        return 'Enter valid password'.tr();
      } else {
        return null;
      }
    }
  }

  Widget buildSignUpButton(BuildContext context) {
    return InkWell(
      onTap: () async {
        if (_formKey.currentState!.validate()) {
          setState(() {
            isLoading = true;
          });
          final result = await _auth.createUser(emailController.text,
              passwordController.text, nameController.text);
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
          "signUp".tr(),
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
        )),
      ),
    );
  }

  Widget buildGoToLogin(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "alreadyHaveAnAccount".tr(),
          style: const TextStyle(fontSize: 12),
        ),
        const SizedBox(width: 8),
        InkWell(
            onTap: () {
              context.go('/login');
            },
            child: Text(
              "signIn".tr(),
              style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo),
            ))
      ],
    );
  }
}
