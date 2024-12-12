import 'dart:math';

import 'package:eweatlthbanking/common_widgets/widgets/buttons/long_button.dart';
import 'package:eweatlthbanking/common_widgets/widgets/textfield/textfields.dart';
import 'package:eweatlthbanking/util/validation/validation.dart';
import 'package:flutter/material.dart';

import '../../home_scree/presenation/home_page.dart';

class TransferScreen extends StatefulWidget {
  const TransferScreen({super.key});

  @override
  State<TransferScreen> createState() => _TransferScreenState();
}

class _TransferScreenState extends State<TransferScreen> {
  final _formKey = GlobalKey<FormState>();
  List<String> banks = ['FNB', 'Standard Bank', 'ABSA', 'Nedbank'];
  String? selectedBank;
  TextEditingController accountNameController = TextEditingController();
  TextEditingController accountNumberController = TextEditingController();
  TextEditingController beneficiaryReferenceController =
      TextEditingController();
  TextEditingController myReferenceController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transfer'),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                "Amount: R 500.00",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      color: Colors.green, // Default border color
                      width: 1.0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      color: Colors.green,
                      // Border color when the field is focused
                      width: 2.0,
                    ),
                  ),
                  labelText: 'Bank',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(
                      color: Colors.green, // Default border color
                      width: 1.0,
                    ),
                  ),
                ),
                value: selectedBank,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedBank = newValue!;
                  });
                },
                items: banks.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                validator: (value) =>
                    value == null ? 'Please select a bank' : null,
              ),
              const SizedBox(height: 20),
              LongTextFieldForm(
                controller: accountNameController,
                hintText: "Account Name",
                labelText: "Account Name",
                showPrefixIcon: false,
                onChanged: (value) {},
                validator: (value) {
                  return Validation.textValidation(value);
                },
                showSuffixIcon: false,
                obsureText: false,
                isRed: true,
              ),
              const SizedBox(height: 20),
              LongTextFieldForm(
                controller: accountNumberController,
                hintText: 'Account Number',
                labelText: 'Account Number',
                showPrefixIcon: false,
                onChanged: (value) {},
                validator: (value) {
                  return Validation.textValidation(value);
                },
                showSuffixIcon: false,
                obsureText: false,
                isRed: true,
              ),
              const SizedBox(height: 20),
              LongTextFieldForm(
                controller: beneficiaryReferenceController,
                hintText: 'Beneficiary Reference',
                labelText: 'Beneficiary Reference',
                showPrefixIcon: false,
                onChanged: (value) {},
                validator: (value) {
                  return Validation.textValidation(value);
                },
                showSuffixIcon: false,
                obsureText: false,
                isRed: true,
              ),
              const SizedBox(height: 20),
              LongTextFieldForm(
                controller: myReferenceController,
                hintText: 'My Reference',
                labelText: 'My Reference',
                showPrefixIcon: false,
                onChanged: (value) {},
                validator: (value) {
                  return Validation.textValidation(value);
                },
                showSuffixIcon: false,
                obsureText: false,
                isRed: true,
              ),
              const SizedBox(height: 20),

              ///todo you can not transfer anything about the amout so I need to do a check here
              LongTextFieldForm(
                controller: amountController,
                hintText: 'Amount',
                labelText: 'Amount',
                showPrefixIcon: false,
                onChanged: (value) {},
                validator: (value) {
                  return Validation.textValidation(value);
                },
                showSuffixIcon: false,
                obsureText: false,
                isRed: true,
              ),

              ///todo you need to use the number textfield or creat a custome textfield
              const SizedBox(height: 20),
              LongButton(
                onTap: () {
                  //we need to clear over here
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SuccessScreen()),
                  );
                  // if (_formKey.currentState!.validate()) {
                  //   // Here you would usually send the data to the backend or your database
                  //   showDialog(
                  //     context: context,
                  //     builder: (context) => AlertDialog(
                  //       title: Text('Success'),
                  //       content: Text('Transfer initiated successfully'),
                  //       actions: <Widget>[
                  //         TextButton(
                  //           onPressed: () {
                  //             Navigator.of(context).pop();
                  //           },
                  //           child: Text('OK'),
                  //         ),
                  //       ],
                  //     ),
                  //   );
                  // }
                },
                title: "Transfer",
                isLoading: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SuccessScreen extends StatefulWidget {
  @override
  _SuccessScreenState createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation<double>? _opacityAnimation;
  Animation<Offset>? _positionAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    _opacityAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller!,
        curve: Curves.easeIn,
      ),
    );

    _positionAnimation = Tween<Offset>(
      begin: Offset(0, 0.05), // slight vertical offset
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller!,
        curve: Curves.easeOut,
      ),
    );

    _controller!.forward();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          StarryBackground(),
          FadeTransition(
            opacity: _opacityAnimation!,
            child: SlideTransition(
              position: _positionAnimation!,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Spacer(),
                  const Icon(Icons.check_circle_outline,
                      size: 100, color: Colors.green),
                  const SizedBox(height: 20),
                  const Text(
                    "Transfer success!!",
                    style: TextStyle(
                        // color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  // const Text(
                  //   "You transferred €900 to Brooklyn Simmons.",
                  //   style: TextStyle(fontSize: 18),
                  // ),
                  const Text(
                    "Find the details in transactions page.",
                    style: TextStyle(fontSize: 16),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: LongButton(
                      ///we send them to the home screen insted over here
                      onTap: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MainHomeScreen()),
                          (Route<dynamic> route) =>
                              false, // This predicate will always return false, removing all routes
                        );
                      },
                      title: "Done",
                      isLoading: false,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class StarryBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: StarPainter(),
      size: Size(MediaQuery.of(context).size.width,
          MediaQuery.of(context).size.height),
    );
  }
}

class StarPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()..color = Colors.green;
    var rng = Random();

    for (int i = 0; i < 100; i++) {
      var x = rng.nextDouble() * size.width;
      var y = rng.nextDouble() * size.height;
      canvas.drawCircle(Offset(x, y), rng.nextDouble() * 2, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class FailScreen extends StatefulWidget {
  @override
  _FailScreenState createState() => _FailScreenState();
}

class _FailScreenState extends State<FailScreen>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation<double>? _opacityAnimation;
  Animation<Offset>? _positionAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    _opacityAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller!,
        curve: Curves.easeIn,
      ),
    );

    _positionAnimation = Tween<Offset>(
      begin: Offset(0, 0.05), // slight vertical offset
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller!,
        curve: Curves.easeOut,
      ),
    );

    _controller!.forward();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          StarryFailBackground(),
          FadeTransition(
            opacity: _opacityAnimation!,
            child: SlideTransition(
              position: _positionAnimation!,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Spacer(),
                  const Icon(Icons.cancel_outlined,
                      size: 100, color: Colors.red),
                  const SizedBox(height: 20),
                  const Text(
                    "Transfer fail!!",
                    style: TextStyle(
                        // color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  // const Text(
                  //   "You transferred €900 to Brooklyn Simmons.",
                  //   style: TextStyle(fontSize: 18),
                  // ),
                  const Text(
                    "Unable to transfer.",
                    style: TextStyle(fontSize: 16),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: LongErrorButton(
                      ///we send them to the home screen insted over here
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const TransferScreen()),
                          // This predicate will always return false, removing all routes
                        );
                      },
                      title: "Try Again",
                      isLoading: false,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class StarryFailBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: StarFailPainter(),
      size: Size(MediaQuery.of(context).size.width,
          MediaQuery.of(context).size.height),
    );
  }
}

class StarFailPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()..color = Colors.red;
    var rng = Random();

    for (int i = 0; i < 100; i++) {
      var x = rng.nextDouble() * size.width;
      var y = rng.nextDouble() * size.height;
      canvas.drawCircle(Offset(x, y), rng.nextDouble() * 2, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

// {
//   final _formKey = GlobalKey<FormState>();
//   List<String> banks = ['FNB', 'Standard Bank', 'ABSA', 'Nedbank'];
//   String? selectedBank;
//   TextEditingController accountNameController = TextEditingController();
//   TextEditingController accountNumberController = TextEditingController();
//   TextEditingController beneficiaryReferenceController =
//       TextEditingController();
//   TextEditingController myReferenceController = TextEditingController();
//   TextEditingController amountController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Money Transfer'),
//       ),
//       body: Form(
//         key: _formKey,
//         child: SingleChildScrollView(
//           padding: EdgeInsets.all(20),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//               DropdownButtonFormField<String>(
//                 decoration: InputDecoration(
//                   labelText: 'Bank',
//                   border: OutlineInputBorder(),
//                 ),
//                 value: selectedBank,
//                 onChanged: (String? newValue) {
//                   setState(() {
//                     selectedBank = newValue!;
//                   });
//                 },
//                 items: banks.map<DropdownMenuItem<String>>((String value) {
//                   return DropdownMenuItem<String>(
//                     value: value,
//                     child: Text(value),
//                   );
//                 }).toList(),
//                 validator: (value) =>
//                     value == null ? 'Please select a bank' : null,
//               ),
//               SizedBox(height: 20),
//               TextFormField(
//                 controller: accountNameController,
//                 decoration: InputDecoration(
//                   labelText: 'Account Name',
//                   border: OutlineInputBorder(),
//                 ),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter account name';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 20),
//               TextFormField(
//                 controller: accountNumberController,
//                 decoration: InputDecoration(
//                   labelText: 'Account Number',
//                   border: OutlineInputBorder(),
//                 ),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter account number';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 20),
//               TextFormField(
//                 controller: beneficiaryReferenceController,
//                 decoration: InputDecoration(
//                   labelText: 'Beneficiary Reference',
//                   border: OutlineInputBorder(),
//                 ),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter beneficiary reference';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 20),
//               TextFormField(
//                 controller: myReferenceController,
//                 decoration: InputDecoration(
//                   labelText: 'My Reference',
//                   border: OutlineInputBorder(),
//                 ),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your reference';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 20),
//               TextFormField(
//                 controller: amountController,
//                 decoration: InputDecoration(
//                   labelText: 'Amount',
//                   border: OutlineInputBorder(),
//                 ),
//                 keyboardType: TextInputType.number,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter an amount';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: () {
//                   if (_formKey.currentState!.validate()) {
//                     // Here you would usually send the data to the backend or your database
//                     showDialog(
//                       context: context,
//                       builder: (context) => AlertDialog(
//                         title: Text('Success'),
//                         content: Text('Transfer initiated successfully'),
//                         actions: <Widget>[
//                           TextButton(
//                             onPressed: () {
//                               Navigator.of(context).pop();
//                             },
//                             child: Text('OK'),
//                           ),
//                         ],
//                       ),
//                     );
//                   }
//                 },
//                 child: Text('Transfer Money'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
