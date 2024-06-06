import 'package:flutter/material.dart';
import 'package:music_app_flutter/authentication/forgot_password.dart';
import 'package:music_app_flutter/authentication/signup.dart';
import 'package:music_app_flutter/logic/mysql.dart';
import 'package:music_app_flutter/main.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // TextEditing controllers to control the text input
  final username = TextEditingController();
  final password = TextEditingController();

  // Bool variable to show and hide the password
  bool isVisible = false;

  // Bool variable to show error message if login is incorrect
  bool isLoginTrue = false;

  // Function to handle login
  login() async {
    var db = Mysql();
    var response = await db.login(username.text, password.text);
    if (response == true) {
      // If login is correct, navigate to the main app
      if (!mounted) return;
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => MyApp()));
    } else {
      // If login is incorrect, show the error message
      setState(() {
        isLoginTrue = true;
      });
    }
  }

  // Global key for the form
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(34, 34, 34, 1.0),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Image.asset(
                    "assets/logoJoySongMain.png",
                    width: 400,
                  ),
                  const SizedBox(height: 15),
                  // Username field
                  Container(
                    margin: const EdgeInsets.all(8),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Color.fromRGBO(0, 173, 181, 1.0),
                    ),
                    child: TextFormField(
                      cursorColor: Color.fromRGBO(0, 173, 181, 1.0),
                      controller: username,
                      style: TextStyle(
                          color: Color.fromRGBO(
                              238, 238, 238, 1.0)), // Set text color to white
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Username is required";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        icon: Icon(Icons.person,
                            color: Color.fromRGBO(
                                238, 238, 238, 1.0)), // Set icon color to white
                        border: InputBorder.none,
                        hintText: "Username",
                        hintStyle: TextStyle(
                            color: Color.fromRGBO(238, 238, 238,
                                1.0)), // Set hint text color to a lighter white
                      ),
                    ),
                  ),

                  // Password field
                  Container(
                    margin: const EdgeInsets.all(8),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Color.fromRGBO(0, 173, 181, 1.0),
                    ),
                    child: TextFormField(
                      controller: password,
                      style:
                          TextStyle(color: Color.fromRGBO(238, 238, 238, 1.0)),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Password is required";
                        }
                        return null;
                      },
                      obscureText: !isVisible,
                      decoration: InputDecoration(
                        icon: Icon(Icons.lock,
                            color: Color.fromRGBO(
                                238, 238, 238, 1.0)), // Set icon color to white
                        border: InputBorder.none,
                        hintText: "Password",
                        hintStyle: TextStyle(
                            color: Color.fromRGBO(238, 238, 238,
                                1.0)), // Set hint text color to a lighter white
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isVisible = !isVisible;
                            });
                          },
                          icon: Icon(
                            isVisible ? Icons.visibility : Icons.visibility_off,
                            color: Color.fromRGBO(238, 238, 238, 1.0),
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),
                  // Login button
                  Container(
                    height: 55,
                    width: MediaQuery.of(context).size.width * .5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Color.fromRGBO(0, 173, 181, 1.0),
                    ),
                    child: TextButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          login();
                        }
                      },
                      child: const Text(
                        "LOGIN",
                        style: TextStyle(
                          color: Color.fromRGBO(238, 238, 238, 1.0),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 22,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't have an account?",
                        style: TextStyle(
                            color: Color.fromRGBO(
                                238, 238, 238, 1.0)), // Set text color to white
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignUp()));
                        },
                        child: const Text(
                          "SIGN UP",
                          style: TextStyle(
                              color: Color.fromRGBO(0, 173, 181, 1.0)),
                        ),
                      ),
                    ],
                  ),

                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const ForgotPassword()));
                        },
                        child: const Text(
                          "Forgot Password",
                          style: TextStyle(
                              color: Color.fromRGBO(0, 173, 181, 1.0)),
                        ),
                      ),
                    ],
                  ),

                  // Login error message
                  isLoginTrue
                      ? const Text(
                          "Username or password is incorrect",
                          style: TextStyle(color: Colors.red),
                        )
                      : const SizedBox(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
