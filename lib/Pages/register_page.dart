import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:myapp1/Pages/select.dart';

import 'dashboard.dart';

class Registerpage extends StatefulWidget {
  final VoidCallback showloginpage;
  const Registerpage({Key? key, required this.showloginpage}) : super(key: key);

  @override
  State<Registerpage> createState() => _RegisterpageState();
}

class _RegisterpageState extends State<Registerpage> {
  bool _passwordVisible = false;
  String? _selectedRole;
  String? _errorText;
  final firstname = TextEditingController();
  final lastname = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordconfirmController = TextEditingController();
  late final Function()? onTap;

  Future<void> signInWithGoogle() async {
    //create an instance of the firebase auth and google signin
    FirebaseAuth auth = FirebaseAuth.instance;
    final GoogleSignIn googleSignIn = GoogleSignIn();
    //trigger the authentication flow
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
    //obtain the auth detail from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;
    //create a new credentials
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    //sign in the user with the credentials
    final UserCredential userCredential =
        await auth.signInWithCredential(credential);
  }

  @override
  void dispose() {
    firstname.dispose();
    lastname.dispose();
    emailController.dispose();
    passwordController.dispose();
    passwordconfirmController.dispose();
    super.dispose();
  }

  Future<void> addUserDetails(
      String firstname, String lastname, String email, String role) async {
    try {
      // Get the current user UID
      String userId = FirebaseAuth.instance.currentUser!.uid;
      await FirebaseFirestore.instance.collection("Users").doc(userId).set({
        'first name': firstname,
        'last name': lastname,
        'Role': role,
        'email': email,
      });
    } catch (e) {
      print('Error adding user details to Firestore: $e');
    }
  }

  Future signUp() async {
    if (firstname.text.trim().isEmpty) {
      setState(() {
        _errorText = 'Please enter your firstname';
      });
      return;
    }
    if (lastname.text.trim().isEmpty) {
      setState(() {
        _errorText = 'Please enter your lastname';
      });
      return;
    }
    if (emailController.text.trim().isEmpty) {
      setState(() {
        _errorText = 'Please enter you Email';
      });
      return;
    }
    if (passwordController.text.trim().isEmpty) {
      setState(() {
        _errorText = 'Please enter your Password';
      });
      return;
    }
    if (!passwordconfirmed()) {
      setState(() {
        _errorText = 'Passwords do not match';
      });
      return;
    }

    String role;
    if (_selectedRole == 'Renting Client') {
      role = 'Renting Client';
    } else if (_selectedRole == 'Car Owner') {
      role = 'Car Owner';
    } else {
      setState(() {
        _errorText = 'Please select your role';
      });
      return;
    }

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      addUserDetails(
        firstname.text.trim(),
        lastname.text.trim(),
        emailController.text.trim(),
        role,
      );
    } catch (e) {
      // Handle any errors that occur during user creation, if needed
      print('Error creating user: $e');
    }
    if (_selectedRole == 'Renting Client') {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
        (route) => false, // Remove all previous routes from the stack
      );
    } else if (_selectedRole == 'Car Owner') {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const Ownerpage()),
        (route) => false, // Remove all previous routes from the stack
      );
    }
  }

  bool passwordconfirmed() {
    if (passwordController.text.trim() ==
        passwordconfirmController.text.trim()) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 223, 218, 218),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 5),
              Image.asset(
                "CAR.png",
                width: 180,
                height: 180,
              ),
              const SizedBox(height: 10),
              const Text("Welcome to Kamash's Car Clinic, Register below!"),
              const SizedBox(height: 10),
              //Username details
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: TextFormField(
                  controller: firstname,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your firstname';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
                    hintText: 'Firstname',
                    prefixIcon: const Icon(Icons.person),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade400),
                    ),
                    fillColor: Colors.grey.shade200,
                    filled: true,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              //name details
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: TextFormField(
                  controller: lastname,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your lastname';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
                    hintText: 'Lastname',
                    prefixIcon: const Icon(Icons.person),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade400),
                    ),
                    fillColor: Colors.grey.shade200,
                    filled: true,
                  ),
                ),
              ),
              //role details
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: DropdownButtonFormField<String>(
                  value: _selectedRole,
                  hint: const Text(
                    'Select Role',
                    style: TextStyle(color: Colors.grey),
                  ), // Displayed when no option is selected
                  items: const [
                    DropdownMenuItem(
                      value: 'Renting Client',
                      child: Text('Renting Client'),
                    ),
                    DropdownMenuItem(
                      value: 'Car Owner',
                      child: Text('Car Owner'),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _selectedRole = value!;
                      _errorText = null;
                    });
                  },
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade400),
                    ),
                    fillColor: Colors.grey.shade200,
                    filled: true,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              // email text field
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: TextFormField(
                  controller: emailController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your Email';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
                    hintText: 'Email',
                    prefixIcon: const Icon(Icons.person),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade400),
                    ),
                    fillColor: Colors.grey.shade200,
                    filled: true,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: TextFormField(
                  controller: passwordController,
                  obscureText: !_passwordVisible,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your Password';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
                    hintText: 'Password',
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _passwordVisible = !_passwordVisible;
                        });
                      },
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade400),
                    ),
                    fillColor: Colors.grey.shade200,
                    filled: true,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: TextFormField(
                  controller: passwordconfirmController,
                  obscureText: !_passwordVisible,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your Password';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
                    hintText: 'Re-enter Password',
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _passwordVisible = !_passwordVisible;
                        });
                      },
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade400),
                    ),
                    fillColor: Colors.grey.shade200,
                    filled: true,
                  ),
                ),
              ),
              const SizedBox(height: 5),
              SizedBox(
                width: 80,
                child: GestureDetector(
                  onTap: signUp,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              if (_errorText != null)
                Text(
                  _errorText!,
                  style: const TextStyle(color: Colors.red),
                ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Divider(
                      thickness: 0.5,
                      color: Colors.grey[400],
                    ),
                  ),
                  const Text("Or sign up with"),
                  Expanded(
                    child: Divider(
                      thickness: 0.5,
                      color: Colors.grey[400],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Center(
                child: GestureDetector(
                  onTap: () async {
                    await signInWithGoogle();
                    if (mounted) {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => const HomePage()));
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.grey[200],
                    ),
                    child: Image.asset(
                      "google.png",
                      width: 50,
                      height: 50,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 74.0),
                child: Row(
                  children: [
                    const Text("Already have an account?"),
                    GestureDetector(
                      onTap: widget.showloginpage,
                      child: const Text(
                        "Login",
                        style: TextStyle(
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
