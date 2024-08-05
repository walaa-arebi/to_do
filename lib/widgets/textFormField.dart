import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
   CustomTextFormField({Key? key,
    required this.controller, required this.hintText, this.validator,  this.icon, this.obscure=false}) : super(key: key);

  final TextEditingController controller;
  final String hintText ;
  final String? Function(String?)? validator;
  final Widget? icon;
   bool obscure;
  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(fontSize: 12),
      validator: widget.validator,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
          errorMaxLines: 3,
          border: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.grey),
              borderRadius: BorderRadius.circular(10)),
          hintStyle: const TextStyle(fontSize: 12),
          suffixIcon: widget.icon,
          hintText: widget.hintText.tr()),
      controller: widget.controller,
      obscureText: widget.obscure,

    );
  }
}
