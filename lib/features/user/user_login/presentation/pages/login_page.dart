import 'package:eweatlthbanking/common_widgets/screens/user_layout/user_layout_screen.dart';
import 'package:eweatlthbanking/common_widgets/sized_box/sized_space.dart';
import 'package:eweatlthbanking/common_widgets/widgets/buttons/long_button.dart';
import 'package:eweatlthbanking/features/user/user_login/presentation/widget/auth_row.dart';
import 'package:eweatlthbanking/features/user/user_login/presentation/widget/email.dart';
import 'package:eweatlthbanking/features/user/user_login/presentation/widget/forget_password.dart';
import 'package:eweatlthbanking/features/user/user_login/presentation/widget/have_an_account.dart';
import 'package:eweatlthbanking/features/user/user_login/presentation/widget/mylearning_text.dart';
import 'package:eweatlthbanking/features/user/user_login/presentation/widget/password.dart';
import 'package:eweatlthbanking/util/constants/strings/strings.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback show;

  const LoginPage({super.key, required this.show});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  FocusNode emailFocus = FocusNode();
  TextEditingController password = TextEditingController();
  FocusNode passwordFocus = FocusNode();
  bool isLoading = false;
  bool isForgotPasswordLoading = false;

  @override
  Widget build(BuildContext context) {
    return UserLayoutScreen(
      children: [
        const MyLearningText(),
        const SizedSpace(
          height: 40,
        ),
       // const LogoImage(),
        Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                LoginEmail(
                  email: email,
                  emailFocus: emailFocus,
                ),
                const SizedBox(
                  height: 10,
                ),
                LoginPassword(
                  password: password,
                  passwordFocus: passwordFocus,
                ),
                LoginForgetPassword(onTap: () {
                //  forgotPassword(context, setState, isForgotPasswordLoading);
                }),
                LongButton(
                  isLoading: isLoading,
                  onTap: () {
                    emailFocus.unfocus();
                    passwordFocus.unfocus();
                    if (_formKey.currentState!.validate()) {
                      _login();
                    }
                  },
                  title: Strings.login,
                ),
                const SizedSpace(
                  height: 10,
                ),
                const AuthRow(),
                const SizedSpace(
                  height: 8,
                ),
                DontHaveAnAccount(onPressed: widget.show),
              ],
            ))
      ],
    );
  }

  Future<void> _login() async {
    setState(() {
      isLoading = true;
    });

    try {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Successfully logged in!'),
        backgroundColor: Colors.red,
      ));
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Failed to sign up: $e')));
      setState(() {
        isLoading = false;
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
}
