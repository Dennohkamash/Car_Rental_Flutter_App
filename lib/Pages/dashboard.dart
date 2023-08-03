import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Auth/main_page.dart';

class Ownerpage extends StatefulWidget {
  const Ownerpage({Key? key}) : super(key: key);

  @override
  State<Ownerpage> createState() => _OwnerpageState();
}

class _OwnerpageState extends State<Ownerpage> {
  late User _user;

  @override
  void initState() {
    super.initState();
    _user = FirebaseAuth.instance.currentUser!; // Initialize the _user variable
  }

  void _logout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const AuthPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
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
      floatingActionButton: ButtonBar(),
    );
  }
}
