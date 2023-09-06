import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myapp1/Pages/register_car.dart';
import 'package:myapp1/Pages/vehicle_List.dart';

import '../Auth/main_page.dart';

class Ownerpage extends StatefulWidget {
  const Ownerpage({Key? key}) : super(key: key);

  @override
  State<Ownerpage> createState() => _OwnerpageState();
}

class _OwnerpageState extends State<Ownerpage> {
  late String _displayName = '';
  late User _user;
  int _vehicleCount = 0; // To store the number of vehicles added

  @override
  void initState() {
    super.initState();
    _user = FirebaseAuth.instance.currentUser!; // Initialize the _user variable
    _fetchUserdata();
    _fetchVehicleCount();
  }

  void _fetchUserdata() async {
    try {
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection("Users")
          .doc(_user.uid)
          .get();

      setState(() {
        _displayName = userSnapshot['first name'] ?? '';
      });
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

  void _fetchVehicleCount() async {
    // Replace with your actual logic to fetch the vehicle count
    // For example, querying the vehicles collection based on the user's email
    String userEmail = _user.email ?? '';
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('vehicles')
        .where('contactDetails', isEqualTo: userEmail)
        .get();

    setState(() {
      _vehicleCount = querySnapshot.size;
    });
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
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'DASHBOARD',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
            ),
            Icon(
              Icons.car_repair_rounded,
              size: 35,
            ),
          ],
        ),
      ),
      drawer: Drawer(
        elevation: 0,
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: const CircleAvatar(),
              accountName: Text(_displayName),
              accountEmail: Text("${_user.displayName ?? _user.email}"),
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
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 150,
                width: 400,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey.shade200,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("VEHICLES ADDED",
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w500,
                                color: Color.fromARGB(255, 31, 29, 29))),
                        SizedBox(
                          height: 20,
                        ),
                        Center(
                            child: Text(
                          "$_vehicleCount",
                          style: const TextStyle(
                              fontSize: 30,
                              color: Color.fromARGB(255, 31, 29, 29)),
                        )),
                        Center(
                            child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Vehiclelist()));
                          },
                          child: const Text(
                            "VIEW MORE",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                        )),
                      ]),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                height: 150,
                width: 400,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey.shade200,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("ACTIVE LIST",
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w500,
                                color: Color.fromARGB(255, 31, 29, 29))),
                        SizedBox(
                          height: 20,
                        ),
                        Center(
                            child: Text(
                          "5",
                          style: TextStyle(
                              fontSize: 30,
                              color: Color.fromARGB(255, 31, 29, 29)),
                        )),
                        Center(
                            child: ElevatedButton(
                          onPressed: () {},
                          child: Text(
                            "ENABLE LISTING",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                        )),
                      ]),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                height: 150,
                width: 400,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey.shade200,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("AMOUNT",
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w500,
                                color: Color.fromARGB(255, 31, 29, 29))),
                        SizedBox(
                          height: 20,
                        ),
                        Center(
                            child: Text(
                          "500\$",
                          style: TextStyle(
                              fontSize: 30,
                              color: Color.fromARGB(255, 31, 29, 29)),
                        )),
                        Center(
                            child: ElevatedButton(
                          onPressed: () {},
                          child: Text(
                            "TOP UP",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                        )),
                      ]),
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 134, 127, 127),
    );
  }
}
