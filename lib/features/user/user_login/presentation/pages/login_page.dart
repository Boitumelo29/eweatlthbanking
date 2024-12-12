import 'package:eweatlthbanking/common_widgets/screens/user_layout/user_layout_screen.dart';
import 'package:eweatlthbanking/common_widgets/sized_box/sized_space.dart';
import 'package:eweatlthbanking/common_widgets/widgets/buttons/long_button.dart';
import 'package:eweatlthbanking/features/home_scree/presenation/home_page.dart';
import 'package:eweatlthbanking/features/user/user_login/presentation/widget/auth_row.dart';
import 'package:eweatlthbanking/features/user/user_login/presentation/widget/email.dart';
import 'package:eweatlthbanking/features/user/user_login/presentation/widget/forget_password.dart';
import 'package:eweatlthbanking/features/user/user_login/presentation/widget/have_an_account.dart';
import 'package:eweatlthbanking/features/user/user_login/presentation/widget/logo_image.dart';
import 'package:eweatlthbanking/features/user/user_login/presentation/widget/mylearning_text.dart';
import 'package:eweatlthbanking/features/user/user_login/presentation/widget/password.dart';
import 'package:eweatlthbanking/util/constants/strings/strings.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback? show;

  const LoginPage({super.key, this.show});

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
        const MyLearningSubText(),
        const LogoImage(),
        const SizedSpace(
          height: 60,
        ),
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
                const SizedBox(
                  height: 10,
                ),
                LongButton(
                  isLoading: isLoading,
                  onTap: () {
                    emailFocus.unfocus();
                    passwordFocus.unfocus();
                    if (_formKey.currentState!.validate()) {
                      //loginUser(context, "jdsfbhjd");
                    }
                  },
                  title: Strings.login,
                ),
                const SizedSpace(
                  height: 10,
                ),
                DontHaveAnAccount(onPressed: widget.show),
              ],
            ))
      ],
    );
  }

  Future<void> loginUser(BuildContext context, String username) async {
    setState(() {
      isLoading = true;
    });

    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      await prefs.setString('userToken', username);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => MainHomeScreen()));
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Successfully logged in!'),
        backgroundColor: Colors.green,
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
