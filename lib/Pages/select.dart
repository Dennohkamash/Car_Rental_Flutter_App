import 'package:flutter/material.dart';
import 'service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:myapp1/Auth/main_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late User _user;

  void _logout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const Authpage()),
    );
  }

  @override
  void initState() {
    super.initState();
    _user = FirebaseAuth.instance.currentUser!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(0, 196, 103, 103),
        elevation: 0,
      ),
      drawer: Drawer(
        elevation: 0,
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: const CircleAvatar(),
              accountEmail: Text("${_user.displayName ?? _user.email}"),
              accountName: null,
            ),
            const ListTile(
              title: Text("Vehicle Dashboard"),
              leading: Icon(Icons.speed),
            ),
            const ListTile(
              title: Text("Reminder"),
              leading: Icon(Icons.lock_clock),
            ),
            const ListTile(
              title: Text("Maps"),
              leading: Icon(Icons.map),
            ),
            const ListTile(
              title: Text("Help"),
              leading: Icon(Icons.help_center),
            ),
            ListTile(
              title: const Text("Logout"),
              leading: const Icon(Icons.logout),
              onTap: _logout,
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            GradientText('Choose Your Option to Continue',
                style: const TextStyle(
                  fontSize: 30.0,
                ),
                colors: const [
                  Colors.blue,
                  Colors.red,
                  Colors.teal,
                ],
                textAlign: TextAlign.center),
            Image.asset(
              "assets/carservice.gif",
              fit: BoxFit.cover,
              width: double.infinity,
            ),
            const SizedBox(
              height: 35,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => RentPage()));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.pink[100],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        height: 100,
                        width: 100,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.monetization_on,
                              size: 45,
                              color: Colors.pink[700],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Rent",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.pink[700],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ServicePage()));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.green[100],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        height: 100,
                        width: 100,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.build,
                              size: 45,
                              color: Colors.green[700],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Service",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.green[700],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 223, 218, 218),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
        ],
      ),
    );
  }
}
