import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class forgotpasswordpage extends StatefulWidget {
  const forgotpasswordpage({super.key});

  @override
  State<forgotpasswordpage> createState() => _forgotpasswordpageState();
}

class _forgotpasswordpageState extends State<forgotpasswordpage> {
  final emailController = TextEditingController();
  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  Future passwordReset() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text.trim());
      showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
              content: Text("Password Reset link sent! Check you Email"),
            );
          });
    } on FirebaseAuthException catch (e) {
      print(e);
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text(e.message.toString()),
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.0),
          child: Text(
            "Enter your Email and we will send you a password reset link",
            style: TextStyle(
              fontSize: 20,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
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
        const SizedBox(
          height: 10,
        ),
        MaterialButton(
          onPressed: passwordReset,
          color: Colors.blue,
          child: const Text(
            "Reset Password",
            style: TextStyle(color: Colors.white),
          ),
        )
      ]),
      backgroundColor: const Color.fromARGB(255, 223, 218, 218),
    );
  }
}
