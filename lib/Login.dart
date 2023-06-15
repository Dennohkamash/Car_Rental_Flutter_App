import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Loginpage extends StatefulWidget {
  Loginpage({Key? key}) : super(key: key);
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  bool _passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    var emailController = widget.emailController;
    var passwordController = widget.passwordController;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 223, 218, 218),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 55),
            Image.asset(
              "CAR.png",
              width: 180,
              height: 180,
            ),
            const SizedBox(height: 25),

            // username text field
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
            const SizedBox(height: 25),
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
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: const [Text("Forgot Password?")],
              ),
            ),
            const SizedBox(height: 15),
            SizedBox(
              width: 80,
              child: ElevatedButton(
                  onPressed: () async {
                    {
                      final credential = await FirebaseAuth.instance
                          .signInWithEmailAndPassword(
                              email: widget.emailController.text,
                              password: widget.passwordController.text);
                    }
                  },
                  child: Text("Login")),
            ),
            const SizedBox(height: 35),
            Row(
              children: [
                Expanded(
                  child: Divider(
                    thickness: 0.5,
                    color: Colors.grey[400],
                  ),
                ),
                const Text("Or continue with"),
                Expanded(
                  child: Divider(
                    thickness: 0.5,
                    color: Colors.grey[400],
                  ),
                )
              ],
            ),
            const SizedBox(height: 35),
            Center(
              child: Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.grey[200]),
                child: Image.asset(
                  "google.png",
                  width: 50,
                  height: 50,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 74.0),
              child: Row(
                children: [
                  Text("Don't have an account?"),
                  TextButton(onPressed: () {}, child: Text("SignUp"))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
