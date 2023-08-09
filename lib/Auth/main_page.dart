import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myapp1/Pages/Login.dart';
import 'package:myapp1/Pages/dashboard.dart';
import 'package:myapp1/Pages/select.dart';
import 'package:myapp1/Pages/register_page.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          User? user = snapshot.data;
          if (user != null) {
            // User is authenticated
            // Get the user role from Firestore and navigate to the appropriate page
            return FutureBuilder<DocumentSnapshot>(
              future: FirebaseFirestore.instance
                  .collection('Users')
                  .doc(user.uid)
                  .get(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.data != null && snapshot.data!.exists) {
                    String? userRole = snapshot.data!.get('Role');
                    if (userRole == 'Car Owner') {
                      return Ownerpage();
                    } else if (userRole == 'Renting Client') {
                      return HomePage();
                    } else {
                      // Handle unknown role or any other cases
                      return Center(child: Text('Unknown user role'));
                    }
                  } else {
                    // Handle the case when user data (Role) is not found in Firestore
                    return Center(child: Text('User data not found'));
                  }
                } else {
                  // Show a loading indicator while fetching user data
                  return Center(child: CircularProgressIndicator());
                }
              },
            );
          } else {
            // User is not authenticated, show the login page
            return Loginpage(showRegisterPage: () {
              // Navigate to the registration page
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => Registerpage(showloginpage: () {
                          // Navigate back to the login page after registration
                          Navigator.pop(context);
                        })),
              );
            });
          }
        } else {
          // Show a loading indicator while checking authentication state
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
