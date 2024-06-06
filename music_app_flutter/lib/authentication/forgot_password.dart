import 'package:flutter/material.dart';
import 'package:email_otp/email_otp.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController email = TextEditingController();
  TextEditingController otp = TextEditingController();
  EmailOTP myauth = EmailOTP();
  bool otpSent = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(34, 34, 34, 1.0),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Forgot Password'),
      ),
      backgroundColor: const Color.fromRGBO(34, 34, 34, 1.0),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (!otpSent)
                  Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.all(8),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 18, vertical: 6),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: const Color.fromRGBO(0, 173, 181, 1.0),
                        ),
                        child: TextFormField(
                          cursorColor: const Color.fromRGBO(0, 173, 181, 1.0),
                          controller: email,
                          style: const TextStyle(
                              color: Color.fromRGBO(238, 238, 238, 1.0)),
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            icon: Icon(Icons.email,
                                color: Color.fromRGBO(238, 238, 238, 1.0)),
                            border: InputBorder.none,
                            hintText: "User Email",
                            hintStyle: TextStyle(
                                color: Color.fromRGBO(238, 238, 238, 1.0)),
                          ),
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromRGBO(0, 173, 181, 1.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 50, vertical: 15),
                        ),
                        onPressed: () async {
                          myauth.setConfig(
                            appEmail: "me@rohitchouhan.com",
                            appName: "Email OTP",
                            userEmail: email.text,
                            otpLength: 6,
                            otpType: OTPType.digitsOnly,
                          );
                          if (await myauth.sendOTP() == true) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("OTP has been sent"),
                              ),
                            );
                            setState(() {
                              otpSent = true;
                            });
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Oops, OTP send failed"),
                              ),
                            );
                          }
                        },
                        child: const Text(
                          "Send OTP",
                          style: TextStyle(
                            color: Color.fromRGBO(238, 238, 238, 1.0),
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                if (otpSent)
                  Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.all(8),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 18, vertical: 6),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: const Color.fromRGBO(0, 173, 181, 1.0),
                        ),
                        child: TextFormField(
                          controller: otp,
                          style: const TextStyle(
                              color: Color.fromRGBO(238, 238, 238, 1.0)),
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            icon: Icon(Icons.security,
                                color: Color.fromRGBO(238, 238, 238, 1.0)),
                            border: InputBorder.none,
                            hintText: "Enter OTP",
                            hintStyle: TextStyle(
                                color: Color.fromRGBO(238, 238, 238, 1.0)),
                          ),
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromRGBO(0, 173, 181, 1.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 50, vertical: 15),
                        ),
                        onPressed: () async {
                          if (await myauth.verifyOTP(otp: otp.text) == true) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("OTP is verified"),
                              ),
                            );
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ResetPassword()),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Invalid OTP"),
                              ),
                            );
                          }
                        },
                        child: const Text(
                          "Verify",
                          style: TextStyle(
                            color: Color.fromRGBO(238, 238, 238, 1.0),
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(34, 34, 34, 1.0),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Reset Password'),
      ),
      backgroundColor: const Color.fromRGBO(34, 34, 34, 1.0),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.all(8),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: const Color.fromRGBO(0, 173, 181, 1.0),
                  ),
                  child: TextFormField(
                    cursorColor: const Color.fromRGBO(0, 173, 181, 1.0),
                    controller: newPassword,
                    style: const TextStyle(
                        color: Color.fromRGBO(238, 238, 238, 1.0)),
                    obscureText: true,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.lock,
                          color: Color.fromRGBO(238, 238, 238, 1.0)),
                      border: InputBorder.none,
                      hintText: "New Password",
                      hintStyle:
                          TextStyle(color: Color.fromRGBO(238, 238, 238, 1.0)),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(8),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: const Color.fromRGBO(0, 173, 181, 1.0),
                  ),
                  child: TextFormField(
                    cursorColor: const Color.fromRGBO(0, 173, 181, 1.0),
                    controller: confirmPassword,
                    style: const TextStyle(
                        color: Color.fromRGBO(238, 238, 238, 1.0)),
                    obscureText: true,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.lock,
                          color: Color.fromRGBO(238, 238, 238, 1.0)),
                      border: InputBorder.none,
                      hintText: "Confirm Password",
                      hintStyle:
                          TextStyle(color: Color.fromRGBO(238, 238, 238, 1.0)),
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(0, 173, 181, 1.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 15),
                  ),
                  onPressed: () {
                    if (newPassword.text == confirmPassword.text) {
// Handle the password reset logic here
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Password has been reset"),
                        ),
                      );
// Navigate back or to login screen
                      Navigator.pop(context);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Passwords do not match"),
                        ),
                      );
                    }
                  },
                  child: const Text(
                    "Reset Password",
                    style: TextStyle(
                      color: Color.fromRGBO(238, 238, 238, 1.0),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
