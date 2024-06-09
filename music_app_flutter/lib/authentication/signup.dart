import 'package:flutter/material.dart';
import 'package:music_app_flutter/authentication/login.dart';
import 'package:music_app_flutter/logic/mysql.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final username = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();
  final email = TextEditingController();

  final formKey = GlobalKey<FormState>();

  bool isVisible = false;

  // Function to create slide transition route
  Route createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          const LoginScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(-1.0, 0.0); // Slide from left to right
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
      backgroundColor: Color.fromRGBO(34, 40, 49, 1.0),
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const ListTile(
                    title: Text(
                      "Register New Account",
                      style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(0, 173, 181, 1.0), // Màu chữ
                      ),
                    ),
                  ),

                  // Username field
                  Container(
                    margin: EdgeInsets.all(8),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Color.fromRGBO(0, 173, 181, 1.0)),
                    child: TextFormField(
                      style: TextStyle(
                          color: Color.fromRGBO(238, 238, 238, 1.0)), // Màu chữ
                      controller: username,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "username is required";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        icon: Icon(Icons.person,
                            color:
                                Color.fromRGBO(238, 238, 238, 1.0)), // Màu icon
                        border: InputBorder.none,
                        hintText: "Username",
                        hintStyle: TextStyle(
                            color: Color.fromRGBO(
                                238, 238, 238, 1.0)), // Màu chữ gợi ý
                      ),
                    ),
                  ),

                  // Password field
                  Container(
                      margin: const EdgeInsets.all(8),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18, vertical: 6),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Color.fromRGBO(0, 173, 181, 1.0)),
                      child: TextFormField(
                        style: TextStyle(
                            color:
                                Color.fromRGBO(238, 238, 238, 1.0)), // Màu chữ
                        controller: password,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Password is required";
                          } else if (value.length < 8) {
                            return "Password must be at least 8 characters long";
                          } else if (!RegExp(
                                  r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                              .hasMatch(value)) {
                            return "Password must contain at least one special character";
                          }
                          return null;
                        },
                        obscureText: !isVisible,
                        decoration: InputDecoration(
                          icon: const Icon(Icons.lock,
                              color: Color.fromRGBO(
                                  238, 238, 238, 1.0)), // Màu icon
                          border: InputBorder.none,
                          hintText: "Password",
                          hintStyle: TextStyle(
                              color: Color.fromRGBO(
                                  238, 238, 238, 1.0)), // Màu chữ gợi ý
                          suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  isVisible = !isVisible;
                                });
                              },
                              icon: Icon(
                                  isVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Color.fromRGBO(
                                      238, 238, 238, 1.0))), // Màu icon
                        ),
                      )),

                  // Confirm Password field
                  Container(
                      margin: const EdgeInsets.all(8),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18, vertical: 6),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Color.fromRGBO(0, 173, 181, 1.0)),
                      child: TextFormField(
                        style: TextStyle(
                            color:
                                Color.fromRGBO(238, 238, 238, 1.0)), // Màu chữ
                        controller: confirmPassword,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "password is required";
                          } else if (password.text != confirmPassword.text) {
                            return "Passwords don't match";
                          }
                          return null;
                        },
                        obscureText: !isVisible,
                        decoration: InputDecoration(
                          icon: const Icon(Icons.lock,
                              color: Color.fromRGBO(
                                  238, 238, 238, 1.0)), // Màu icon
                          border: InputBorder.none,
                          hintText: "Confirm Password",
                          hintStyle: TextStyle(
                              color: Color.fromRGBO(
                                  238, 238, 238, 1.0)), // Màu chữ gợi ý
                          suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  isVisible = !isVisible;
                                });
                              },
                              icon: Icon(
                                  isVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Color.fromRGBO(
                                      238, 238, 238, 1.0))), // Màu icon
                        ),
                      )),

                  // Email field
                  Container(
                    margin: EdgeInsets.all(8),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Color.fromRGBO(0, 173, 181, 1.0)),
                    child: TextFormField(
                      style: TextStyle(
                          color: Color.fromRGBO(238, 238, 238, 1.0)), // Màu chữ
                      controller: email,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Email is required";
                        } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                            .hasMatch(value)) {
                          return "Invalid email address";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        icon: Icon(Icons.email,
                            color:
                                Color.fromRGBO(238, 238, 238, 1.0)), // Màu icon
                        border: InputBorder.none,
                        hintText: "Email",
                        hintStyle: TextStyle(
                            color: Color.fromRGBO(
                                238, 238, 238, 1.0)), // Màu chữ gợi ý
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),
                  // Sign Up button
                  Container(
                    height: 55,
                    width: MediaQuery.of(context).size.width * .5,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Color.fromRGBO(0, 173, 181, 1.0)),
                    child: TextButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            final db = Mysql();
                            db
                                .signup(
                              username.text,
                              password.text,
                              email.text,
                            )
                                .whenComplete(() {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const LoginScreen()));
                            });
                          }
                        },
                        child: const Text(
                          "SIGN UP",
                          style: TextStyle(
                            color:
                                Color.fromRGBO(238, 238, 238, 1.0), // Màu chữ
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                  ),

                  // Login button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account?",
                        style: TextStyle(
                            color:
                                Color.fromRGBO(238, 238, 238, 1.0)), // Màu chữ
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).push(createRoute());
                          },
                          child: Text(
                            "Login",
                            style: TextStyle(
                                fontSize: 16,
                                color: Color.fromRGBO(
                                    0, 173, 181, 1.0)), // Màu chữ
                          )),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
