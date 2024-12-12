import 'package:eweatlthbanking/common_widgets/widgets/textfield/textfields.dart';
import 'package:eweatlthbanking/util/constants/strings/strings.dart';
import 'package:eweatlthbanking/util/validation/validation.dart';
import 'package:flutter/material.dart';

class LoginEmail extends StatelessWidget {
  final TextEditingController email;
  final FocusNode emailFocus;

  const LoginEmail({super.key, required this.email, required this.emailFocus});

  @override
  Widget build(BuildContext context) {
    return LongTextFieldForm(
      isRed: false,
      showPrefixIcon: true,
      prefixIcon: Icons.person,
      focusNode: emailFocus,
      validator: (value) {
        return Validation.usernameEmailValidation(value);
      },
      obsureText: false,
      showSuffixIcon: false,
      hintText: Strings.username,
      labelText: Strings.username,
      onChanged: (value) {},
      controller: email,
    );
  }
}
