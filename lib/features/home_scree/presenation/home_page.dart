import 'package:eweatlthbanking/features/auth/auth.dart';
import 'package:eweatlthbanking/features/deposit/presentation/deposit_page.dart';
import 'package:eweatlthbanking/features/tranfer_screen/presnation/transfer_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () => logoutUser(context),
          ),
        ],
        elevation: 0,
        backgroundColor: Colors.white10,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: Card(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.width * 0.5,
                  padding: EdgeInsets.all(20),
                  child: const Column(
                    children: <Widget>[
                      Text(
                        'Current balance',
                        style: TextStyle(color: Colors.grey),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'R 500.00',
                        style: TextStyle(
                            fontSize: 40, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      Divider(
                        color: Colors.green,
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('**** **** **** 1234'),
                          Icon(
                            Icons.credit_card,
                            color: Colors.green,
                          ),
                          // Changed from FlutterIcons to Icons.credit_card
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _buildActionButton(Icons.add, 'Deposit', () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const DepositPage()));
                  }),
                  _buildActionButton(Icons.send, 'Transfer', () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const TransferScreen()));
                  }),
                ],
              ),
            ),

            ListTile(
              title: Text('Transactions'),
              trailing: TextButton(
                onPressed: () {},
                child: Text(
                  'History',
                  style: TextStyle(
                    color: Colors.green,
                  ),
                ),
              ),
            ),
            // SizedBox(height: 120,),
            // Center(
            //   child: Text(
            //     textAlign: TextAlign.center,
            //     "eWealth",
            //     style: TextStyle(
            //         color: Colors.green[100],
            //         fontStyle: FontStyle.italic,
            //         fontSize: 60),
            //   ),
            // )
            ListTile(
              leading: Icon(Icons.account_balance_wallet),
              title: Text('Deposit'),
              trailing: Text('R 500'),
            ),
          ],
        ),
      ),
    );
  }

  void checkBeforeLogout(BuildContext context) async {
    String token = await getUserToken();
    if (token.isNotEmpty) {
      logoutUser(context);
    } else {
      // Inform user they are not logged in or handle as needed
    }
  }

  Future<String> getUserToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('userToken') ?? '';
  }

  Future<void> fetchUserData() async {
    String token = await getUserToken();
    // var response = await http.get(
    //   Uri.parse('https://yourapi.com/userdata'),
    //   headers: {'Authorization': 'Bearer $token'},
    // );
    // Process the response
  }

  Future<void> logoutUser(BuildContext context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('isLoggedIn');
    await prefs.remove('userToken');
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const AuthPage()));
  }

  Widget _buildActionButton(IconData icon, String label, Function() onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: <Widget>[
          Icon(
            icon,
            size: 30,
            color: Colors.green,
          ),
          SizedBox(height: 8),
          Text(label),
        ],
      ),
    );
  }
}
