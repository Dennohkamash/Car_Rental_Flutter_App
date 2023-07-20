import 'package:flutter/src/widgets/framework.dart';
import 'package:myapp1/Pages/Login.dart';
import 'package:myapp1/Pages/register_page.dart';

class Authepage extends StatefulWidget {
  const Authepage({super.key});

  @override
  State<Authepage> createState() => _AuthepageState();
}

class _AuthepageState extends State<Authepage> {
  bool showloginpage = true;

  void togglescreen() {
    setState(() {
      showloginpage = !showloginpage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showloginpage) {
      return Loginpage(showRegisterPage: togglescreen);
    } else {
      return Registerpage(showloginpage: togglescreen);
    }
  }
}
