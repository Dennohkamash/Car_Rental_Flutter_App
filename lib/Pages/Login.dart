import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:myapp1/Pages/select.dart';
// import 'package:myapp1/Services/auth_service.dart';
import 'forgotpass.dart';

class Loginpage extends StatefulWidget {
  final VoidCallback showRegisterPage;
  Loginpage({Key? key, required this.showRegisterPage}) : super(key: key);
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  bool _passwordVisible = false;
  String? errorMessage;
  late final Function()? onTap;
  Future<void> signInWithGoogle() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    final UserCredential userCredential =
        await auth.signInWithCredential(credential);
  }

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
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const forgotpasswordpage();
                      }));
                    },
                    child: const Text(
                      'Forgot Password?',
                      style: TextStyle(color: Colors.blue),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 15),
            SizedBox(
              width: 80,
              child: ElevatedButton(
                  onPressed: () async {
                    if (emailController.text.isEmpty ||
                        passwordController.text.isEmpty) {
                      setState(() {
                        errorMessage = 'Please enter both email and password';
                      });
                      return;
                    }
                    try {
                      final credential = await FirebaseAuth.instance
                          .signInWithEmailAndPassword(
                        email: emailController.text,
                        password: passwordController.text,
                      );
                      // ... handle successful login ...
                    } on FirebaseAuthException catch (e) {
                      setState(() {
                        if (e.code == 'user-not-found' ||
                            e.code == 'wrong-password') {
                          errorMessage = 'Invalid email or password';
                        } else {
                          errorMessage =
                              'An error occurred. Please try again later.';
                        }
                      });
                    } catch (e) {
                      setState(() {
                        errorMessage =
                            'An error occurred. Please try again later.';
                      });
                    }
                  },
                  child: const Text("Login")),
            ),
            if (errorMessage != null)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  errorMessage!,
                  style: const TextStyle(color: Colors.red),
                ),
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
                      color: Colors.grey[200]),
                  child: Image.asset(
                    "google.png",
                    width: 50,
                    height: 50,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 74.0),
              child: Row(
                children: [
                  const Text("Don't have an account?"),
                  GestureDetector(
                      onTap: widget.showRegisterPage,
                      child: const Text(
                        "SignUp",
                        style: TextStyle(
                          color: Colors.blue,
                        ),
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
