import 'package:eweatlthbanking/common_widgets/screens/user_layout/user_layout_screen.dart';
import 'package:eweatlthbanking/common_widgets/sized_box/sized_space.dart';
import 'package:eweatlthbanking/common_widgets/widgets/buttons/long_button.dart';
import 'package:eweatlthbanking/features/home_scree/presenation/home_page.dart';
import 'package:eweatlthbanking/features/onboarding/presentation/onboarding_page.dart';
import 'package:eweatlthbanking/features/user/user_login/presentation/widget/auth_row.dart';
import 'package:eweatlthbanking/features/user/user_login/presentation/widget/logo_image.dart';
import 'package:eweatlthbanking/features/user/user_login/presentation/widget/mylearning_text.dart';
import 'package:eweatlthbanking/features/user/user_sign_up/widget/SignupEmail.dart';
import 'package:eweatlthbanking/features/user/user_sign_up/widget/address.dart';
import 'package:eweatlthbanking/features/user/user_sign_up/widget/already_have_account.dart';
import 'package:eweatlthbanking/features/user/user_sign_up/widget/signup_password.dart';
import 'package:eweatlthbanking/features/user/user_sign_up/widget/signup_username.dart';
import 'package:eweatlthbanking/util/constants/strings/strings.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpPage extends StatefulWidget {
  final VoidCallback? show;

  const SignUpPage({super.key, this.show});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final email = TextEditingController();
  FocusNode email_f = FocusNode();
  final password = TextEditingController();
  FocusNode password_f = FocusNode();
  final passwordConfirm = TextEditingController();
  FocusNode passwordConfirm_f = FocusNode();
  final username = TextEditingController();
  FocusNode username_f = FocusNode();
  final lastname = TextEditingController();
  FocusNode lastname_f = FocusNode();
  final cellphone = TextEditingController();
  FocusNode cellphone_f = FocusNode();
  final id = TextEditingController();
  FocusNode id_f = FocusNode();
  final sub = TextEditingController();
  FocusNode sub_f = FocusNode();
  final city = TextEditingController();
  FocusNode city_f = FocusNode();
  final streetName = TextEditingController();
  FocusNode streetName_f = FocusNode();
  final TextEditingController dobController =
      TextEditingController(); // Controller for the DOB field

  bool isLoading = false;
  final List<String> provinces = [
    'Gauteng',
    'Western Cape',
    'KwaZulu-Natal',
    'Eastern Cape',
    'Free State',
    'Limpopo',
    'Mpumalanga',
    'Northern Cape',
    'North West'
  ];
  String? selectedProvince;

  @override
  Widget build(BuildContext context) {
    return UserLayoutScreen(
      children: [
        Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                const SizedSpace(
                  height: 20,
                ),
                const MyLearningText(),
                const MyLearningSubText(),
                const LogoImage(),
                SignupUsername(username: username, username_f: username_f),
                const SizedSpace(
                  height: 10,
                ),
                SignupLastName(username: lastname, username_f: lastname_f),
                const SizedSpace(
                  height: 10,
                ),
                SignupCellPhone(username: cellphone, username_f: cellphone_f),
                const SizedSpace(
                  height: 10,
                ),
                SignupEmail(email: email, email_f: email_f),
                const SizedSpace(
                  height: 10,
                ),
                SignupProvinceDropdown(
                  provinces: provinces,
                  initialValue: selectedProvince, // Can be null initially
                  onChanged: (value) {
                    setState(() {
                      selectedProvince = value!;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a province';
                    }
                    return null;
                  },
                ),
                const SizedSpace(
                  height: 10,
                ),
                SignupSurb(
                  username: sub,
                  username_f: sub_f,
                ),
                const SizedSpace(
                  height: 10,
                ),
                SignupCity(
                  username: city,
                  username_f: city_f,
                ),
                const SizedSpace(
                  height: 10,
                ),
                SignupStreetName(
                  username: streetName,
                  username_f: streetName_f,
                ),
                const SizedSpace(
                  height: 10,
                ),
                SignupID(
                  username: id,
                  username_f: id_f,
                  onIDChanged: onIDChanged,
                ),
                const SizedSpace(
                  height: 10,
                ),

                ///todo look here
                TextField(
                  controller: dobController,
                  decoration: InputDecoration(
                      labelText: 'Date of Birth (DD/MM/YYYY)',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.grey, width: 0.7),
                      )),
                  readOnly: true,
                ),
                const SizedSpace(
                  height: 10,
                ),
                SignupPassword(password: password, password_f: password_f),
                const SizedBox(
                  height: 10,
                ),
                LongButton(
                    isLoading: isLoading,
                    onTap: () {
                      _signUp(username.text);
                      // if (_formKey.currentState!.validate()) {
                      //
                      // }
                    },
                    title: Strings.signUp),
                const SizedBox(
                  height: 10,
                ),
                AlreadyHaveAnAccount(onPressed: widget.show)
              ],
            )),
      ],
    );
  }

  Future<void> _signUp(username) async {
    setState(() {
      isLoading = true;
    });
    try {
      ///on the signup it should then take us to the onboading screen
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      await prefs.setString('userToken', username);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => OnboardingPage()));

      // _showWelcomeDialog(context);
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

  void onIDChanged(String id) {
    String? dob = formatDOB(id);
    if (dob != null) {
      setState(() {
        dobController.text = dob;
      });
    } else {
      setState(() {
        dobController.text = "Invalid ID";
      });
    }
  }

  String? formatDOB(String id) {
    if (id.length != 13) {
      // print("ID length is incorrect");
      return null;
    }

    try {
      String year = id.substring(0, 2);
      String month = id.substring(2, 4);
      String day = id.substring(4, 6);

      // print("Extracted Year: $year, Month: $month, Day: $day");

      int yearInt = int.parse(year);
      int monthInt = int.parse(month);
      int dayInt = int.parse(day);

      // Assume current year is 2023; adjust century cutoff accordingly
      int currentYearLastTwoDigits = DateTime.now().year % 100;
      int fullYear = (yearInt > currentYearLastTwoDigits)
          ? 1900 + yearInt
          : 2000 + yearInt;

      // Use DateTime to validate the actual date
      DateTime? date = DateTime.tryParse('$fullYear-$month-$day');
      if (date == null) {
        // print("Date parsing failed");
        return null;
      }

      // print("Formatted Date: ${date.day}/${date.month}/${date.year}");
      return '${date.day}/${date.month}/${date.year}';
    } catch (e) {
      // print("Error in parsing: $e");
      return null;
    }
  }
}
