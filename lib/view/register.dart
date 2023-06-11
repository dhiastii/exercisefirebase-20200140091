import 'package:materi3pam/controller/auth_controller.dart';
import 'package:materi3pam/model/user_model.dart';
import 'package:materi3pam/view/login.dart';
import 'package:flutter/material.dart';

class Register extends StatelessWidget {
  Register({super.key});

  final formkey = GlobalKey<FormState>();

  final authCr = AuthController();

  @override
  Widget build(BuildContext context) {
    String? name;

    String? email;

    String? password;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Form(
            key: formkey,
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(hintText: 'Name'),
                  onChanged: (value) {
                    name = value;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(hintText: 'Email'),
                  onChanged: (value) {
                    email = value;
                  },
                ),
                TextFormField(
                  obscureText: true,
                  decoration: const InputDecoration(hintText: 'Password'),
                  onChanged: (value) {
                    password = value;
                  },
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (formkey.currentState!.validate()) {
                      UserModel? registeredUser =
                          await authCr.registerWithEmailAndPassword(
                              email!, password!, name!);

                      if (registeredUser != null) {
                        // Registration success
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Registration Success'),
                              content: const Text(
                                  'You have successfully registered'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    print(registeredUser.name);
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return Login();
                                    }));
                                    // Navigate to the next screen or perform any desired action
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                      } else {
                        // Registration failed
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Registration Failed'),
                              content: const Text(
                                  'Please check your email or password!'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                      }
                    }
                  },
                  child: const Text('Register'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
