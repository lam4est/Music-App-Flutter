import 'package:flutter/material.dart';
import 'package:email_otp/email_otp.dart';
import 'package:music_app_flutter/logic/mysql.dart';

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
  bool showEnterEmailText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:
            const Color.fromRGBO(0, 173, 181, 1.0), // Màu của AppBar
        leading: IconButton(
          icon:
              const Icon(Icons.arrow_back, color: Colors.white), // Màu của icon
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor:
          const Color.fromRGBO(34, 34, 34, 1.0), // Màu nền của trang
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Find Account",
                style: TextStyle(
                  fontSize: 28,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              if (showEnterEmailText && !otpSent)
                const Text(
                  "Please enter your email",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              const SizedBox(height: 16),
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
                    const SizedBox(height: 12),
                    const Text(
                      "We may send notifications via gmail for security purposes and to assist you in logging in",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(0, 173, 181, 1.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 13),
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
                            showEnterEmailText =
                                false; // Ẩn dòng chữ "Please enter your email"
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
                    SizedBox(
                      height: 6,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(0, 173, 181, 1.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 14),
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
                                builder: (context) =>
                                    ResetPassword(email: email.text)),
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
    );
  }
}

class ResetPassword extends StatefulWidget {
  final String email;

  const ResetPassword({Key? key, required this.email}) : super(key: key);

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
        backgroundColor:
            const Color.fromRGBO(0, 173, 181, 1.0), // Màu của AppBar
        leading: IconButton(
          icon:
              const Icon(Icons.arrow_back, color: Colors.white), // Màu của icon
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor:
          const Color.fromRGBO(34, 34, 34, 1.0), // Màu nền của trang
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start, // Căn lề theo chiều ngang
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Create New Password",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  "Your new password must be different from previously used passwords",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
              ),
              SizedBox(height: 16),
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
              SizedBox(
                height: 8,
              ),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(0, 173, 181, 1.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 14),
                  ),
                  onPressed: () async {
                    if (newPassword.text == confirmPassword.text) {
                      var db = Mysql();
                      bool result = await db.resetPassword(
                          widget.email, newPassword.text);
                      if (result) {
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
                            content: Text("Password reset failed"),
                          ),
                        );
                      }
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
