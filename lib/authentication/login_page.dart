import 'package:contacts_app/controllers/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(children: [
              SizedBox(
                height: 30,
              ),
              Text(
                "Login",
                style:
                    GoogleFonts.sora(fontSize: 40, fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                  width: MediaQuery.of(context).size.width * .9,
                  child: TextFormField(
                    validator: (value) =>
                        value!.isEmpty ? "Email cannot be empty." : null,
                    controller: _emailController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text("Email"),
                    ),
                  )),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                  width: MediaQuery.of(context).size.width * .9,
                  child: TextFormField(
                    validator: (value) => value!.length < 8
                        ? "Password should have atleast 8 characters."
                        : null,
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text("Password"),
                    ),
                  )),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, "/forget");
                },
                child: Text("Forget Password"),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                  height: 65,
                  width: MediaQuery.of(context).size.width * .9,
                  child: ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          AuthService()
                              .loginWithEmail(
                                  _emailController.text, _passwordController.text)
                              .then((value) {
                            if (value == "Login Successful") {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("Login Successful")));
                              Navigator.pushReplacementNamed(context, "/home");
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(
                                  value,
                                  style: TextStyle(color: Colors.white),
                                ),
                                backgroundColor: Colors.red.shade400,
                              ));
                            }
                          });
                        }
                      },
                      child: Text(
                        "Login",
                        style: TextStyle(fontSize: 16),
                      ))),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account?"),
                  TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, "/signup");
                      },
                      child: Text("Sign Up"))
                ],
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
