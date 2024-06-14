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
  final username = TextEditingController();
  final password = TextEditingController();
  bool isVisible = false;
  bool isLoginTrue = false;

  // Function to handle login
  login() async {
    var db = Mysql();
    var role = await db.login(username.text, password.text);
    if (role != null) {
      if (!mounted) return;
      if (role == 'admin') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => AdminApp()), // Thay AdminApp bằng widget trang admin của bạn
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => UserApp()), // Thay UserApp bằng widget trang user của bạn
        );
      }
    } else {
      setState(() {
        isLoginTrue = true;
      });
    }
  }

  // Global key for the form
  final formKey = GlobalKey<FormState>();

  // Function to create slide transition route
  Route createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => const SignUp(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    );
  }

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
                              238, 238, 238, 1.0)), 
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Username is required";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        icon: Icon(Icons.person,
                            color: Color.fromRGBO(
                                238, 238, 238, 1.0)), 
                        border: InputBorder.none,
                        hintText: "Username",
                        hintStyle: TextStyle(
                            color: Color.fromRGBO(238, 238, 238,
                                1.0)), 
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
                                238, 238, 238, 1.0)), 
                        border: InputBorder.none,
                        hintText: "Password",
                        hintStyle: TextStyle(
                            color: Color.fromRGBO(238, 238, 238,
                                1.0)), 
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
                          Navigator.of(context).push(createRoute());
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
