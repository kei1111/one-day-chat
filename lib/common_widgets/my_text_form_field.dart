import 'package:flutter/material.dart';
import 'package:himatubu_chat/config/app_styles.dart';

class MyTextFormField extends StatelessWidget {
  const MyTextFormField({
    Key? key,
    required this.controller,
    required this.hint,
    required this.labelText,
    required this.fillColor,
    required this.inputType,
    required this.inputAction,
    required this.focusNode,
    required this.validator,
  }) : super(key: key);

  final TextEditingController controller;
  final String hint;
  final String labelText;
  final Color fillColor;
  final TextInputType inputType;
  final TextInputAction inputAction;
  final FocusNode focusNode;
  final String? Function(String?) validator;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        controller: controller,
        style: focusNode.hasFocus
            ? kBodyText2.copyWith(color: kPrimaryColor)
            : kInputHintStyle,
        cursorColor: kSecondaryColor,
        keyboardType: inputType,
        textInputAction: inputAction,
        focusNode: focusNode,
        validator: validator,
        decoration: InputDecoration(
          filled: true,
          fillColor: fillColor,
          border: kInputBorder,
          enabledBorder: kInputBorder,
          hintText: hint,
          hintStyle: kInputHintStyle,
          prefixIcon: Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Container(
              decoration: const BoxDecoration(
                border: Border(
                  right: BorderSide(
                    width: 2,
                    color: kScaffoldBackground,
                  ),
                ),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 26, vertical: 14),
                child: Text(labelText),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
