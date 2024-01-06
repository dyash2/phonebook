import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgetPw extends StatefulWidget {
  const ForgetPw({Key? key}) : super(key: key);

  @override
  State<ForgetPw> createState() => _ForgetPwState();
}

class _ForgetPwState extends State<ForgetPw> {
  final formKey = GlobalKey<FormState>();
  final auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();

  // Function to send a password reset email
  void sendPasswordResetEmail(BuildContext context) {
    auth.sendPasswordResetEmail(email: _emailController.text.toString()).then((value) {
      Utils().toastMessage("Check your email for a password reset link.");
    }).onError((error, stackTrace) {
      print("Error sending password reset email: $error");
      Utils().toastMessage(error.toString());
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                Text(
                  "Reset Password",
                  style: GoogleFonts.sora(
                    fontSize: 40,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * .9,
                  child: TextFormField(
                    validator: (value) =>
                        value!.isEmpty ? "Email cannot be empty." : null,
                    controller: _emailController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text("Email"),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      sendPasswordResetEmail(context);
                    },
                    child: const Text(
                        "Send",
                        style: TextStyle(fontSize: 16),
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
class Utils {
  void toastMessage(String message) {
  }
}