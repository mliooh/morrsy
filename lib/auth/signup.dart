import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:morrsy/auth/authservices.dart';
import 'package:morrsy/auth/signin.dart';
import 'package:morrsy/pages/homepage.dart';
import 'package:morrsy/widgets/customTextField.dart';
import 'package:morrsy/widgets/mybutton.dart';

class SignUp extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  SignUp({super.key});

  // sign up function

  Future<void> register(BuildContext context) async {
    final _auth = Authservices();

    // Show loading indicator
    showDialog(
      context: context,
      barrierDismissible: false, // Prevents closing the dialog
      builder: (context) => LoadingOverlay(),
    );

    String email = _emailController.text;
    String password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      print(
          "Email or password cannot be empty."); // Print statement for debugging
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Input Error'),
          content: const Text('Please enter both email and password.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
      return; // Stop the function from continuing
    }

    try {
      // _auth.signUpWithEmailPassword(_emailController.text, _passwordController.text);
      User? user = await _auth.signUpWithEmailPassword(email, password);
      if (user != null) {
        // Successfully signed up, navigate to home page
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      } else {
        // Sign-up failed due to an unknown reason
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text('Sign up failed, please try again'),
                ));
      }
    } catch (e) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text(e.toString()),
              ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //icon. message

              Icon(
                Icons.message_outlined,
                color: Colors.lightBlueAccent,
                size: 60,
              ),
              SizedBox(
                height: 50,
              ),
              // login text

              Text(
                'Create an account',
                style:
                    TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),

              //email field
              MyTextfield(
                  text: 'Email',
                  controller: _emailController,
                  ObscureText: false),
              SizedBox(
                height: 10,
              ),

              // password field
              MyTextfield(
                  text: 'Password',
                  controller: _passwordController,
                  ObscureText: true),
              SizedBox(
                height: 20,
              ),
              //login buttton

              MyButton(
                text: 'Sign Up',
                onTap: () => register(context),
              ),
              SizedBox(
                height: 50,
              ),
              // New to morsy message with signup text button

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already a member?',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => SignIn()));
                    },
                    child: Text(
                      'Login',
                      style: TextStyle(
                          color: Colors.lightBlueAccent,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
